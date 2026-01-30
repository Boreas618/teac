use std::rc::Rc;

use crate::ast::{self, AssignmentStmt, RightValList};
use crate::ir::function::{BlockLabel, FunctionGenerator};
use crate::ir::stmt::StmtInner;
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Named, Operand};
use crate::ir::Error;

impl<'ir> FunctionGenerator<'ir> {
    pub fn gen(&mut self, from: &ast::FnDef) -> Result<(), Error> {
        let identifier = &from.fn_decl.identifier;
        let function_type = self
            .module_generator
            .registry
            .function_types
            .get(identifier)
            .unwrap();

        let arguments = function_type.arguments.clone();
        self.emit_label(BlockLabel::Function(identifier.clone()));

        for (id, dtype) in arguments.iter() {
            if self.local_variables.contains_key(id) {
                return Err(Error::VariableRedefinition { symbol: id.clone() });
            }

            let var = LocalVariable::new(
                dtype.clone(),
                self.alloc_vreg(),
                Some(id.to_string()),
            );
            self.arguments.push(var.clone());

            let ptr = Rc::new(LocalVariable::new(
                Dtype::ptr_to(dtype.clone()),
                self.alloc_vreg(),
                Some(id.to_string()),
            ));
            self.emit_alloca(Operand::Local(ptr.as_ref().clone()));
            self.emit_store(Operand::Local(var), Operand::Local(ptr.as_ref().clone()));
            self.local_variables.insert(id.clone(), ptr);
        }

        for stmt in from.stmts.iter() {
            self.handle_block(stmt, None, None)?;
        }

        if let Some(stmt) = self.irs.last() {
            if !matches!(stmt.inner, StmtInner::Return(_)) {
                let return_type = self
                    .module_generator
                    .registry
                    .function_types
                    .get(identifier)
                    .map(|ft| &ft.return_dtype)
                    .unwrap();

                match return_type {
                    Dtype::I32 => {
                        self.emit_return(Some(Operand::from(0)));
                    }
                    Dtype::Void => {
                        self.emit_return(None);
                    }
                    _ => return Err(Error::ReturnTypeUnsupported),
                }
            }
        }

        Ok(())
    }
}

impl<'ir> FunctionGenerator<'ir> {
    pub fn handle_block(
        &mut self,
        stmt: &ast::CodeBlockStmt,
        con_label: Option<BlockLabel>,
        bre_label: Option<BlockLabel>,
    ) -> Result<(), Error> {
        match &stmt.inner {
            ast::CodeBlockStmtInner::Assignment(s) => self.handle_assignment_stmt(s),
            ast::CodeBlockStmtInner::VarDecl(s) => match &s.inner {
                ast::VarDeclStmtInner::Decl(d) => self.handle_local_var_decl(d),
                ast::VarDeclStmtInner::Def(d) => self.handle_local_var_def(d),
            },
            ast::CodeBlockStmtInner::Call(s) => self.handle_call_stmt(s),
            ast::CodeBlockStmtInner::If(s) => self.handle_if_stmt(s, con_label, bre_label),
            ast::CodeBlockStmtInner::While(s) => self.handle_while_stmt(s),
            ast::CodeBlockStmtInner::Return(s) => self.handle_return_stmt(s),
            ast::CodeBlockStmtInner::Continue(_) => self.handle_continue_stmt(con_label),
            ast::CodeBlockStmtInner::Break(_) => self.handle_break_stmt(bre_label),
            ast::CodeBlockStmtInner::Null(_) => Ok(()),
        }
    }

    pub fn handle_assignment_stmt(&mut self, stmt: &AssignmentStmt) -> Result<(), Error> {
        let mut left = self.handle_left_val(&stmt.left_val)?;
        let right = self.handle_right_val(&stmt.right_val)?;

        if left.dtype() == &Dtype::Undecided {
            let right_type = right.dtype();
            let local_val = LocalVariable::new(
                Dtype::ptr_to(right_type.clone()),
                self.alloc_vreg(),
                left.identifier(),
            );
            left = Operand::Local(local_val.clone());
            self.emit_alloca(left.clone());

            self.local_variables
                .insert(local_val.identifier().unwrap(), Rc::new(local_val.clone()));
        }

        self.emit_store(right, left);
        Ok(())
    }

    pub fn handle_local_var_decl(&mut self, decl: &ast::VarDecl) -> Result<(), Error> {
        let identifier = &decl.identifier;
        let dtype = match decl.type_specifier.as_ref() {
            Some(type_spec) => Some(Dtype::from(type_spec)),
            None => None,
        };

        let (var_dtype, needs_alloca) = match (&decl.inner, &dtype) {
            (ast::VarDeclInner::Scalar(_), None) => (Dtype::Undecided, false),
            (ast::VarDeclInner::Scalar(_), Some(Dtype::I32)) => (Dtype::ptr_to(Dtype::I32), true),
            (ast::VarDeclInner::Array(arr), None) => (Dtype::array_of(Dtype::I32, arr.len), false),
            (ast::VarDeclInner::Array(arr), Some(Dtype::I32)) => {
                (Dtype::array_of(Dtype::I32, arr.len), true)
            }
            (ast::VarDeclInner::Array(arr), Some(Dtype::Struct { type_name })) => (
                Dtype::array_of(
                    Dtype::Struct {
                        type_name: type_name.clone(),
                    },
                    arr.len,
                ),
                true,
            ),
            // Slice types (&[T]) are only valid for function parameters, not local variables
            (ast::VarDeclInner::Slice(_), _) => return Err(Error::LocalVarDefinitionUnsupported),
            _ => return Err(Error::LocalVarDefinitionUnsupported),
        };

        let variable = Rc::new(LocalVariable::new(
            var_dtype,
            self.alloc_vreg(),
            Some(identifier.clone()),
        ));

        if needs_alloca {
            self.emit_alloca(Operand::Local(variable.as_ref().clone()));
        }

        if self
            .local_variables
            .insert(identifier.clone(), variable)
            .is_some()
        {
            return Err(Error::VariableRedefinition {
                symbol: identifier.clone(),
            });
        }

        Ok(())
    }

    pub fn init_array(&mut self, base_ptr: Operand, vals: &RightValList) -> Result<(), Error> {
        for (i, val) in vals.iter().enumerate() {
            let element_ptr = self.alloc_temporary(Dtype::ptr_to(Dtype::I32));
            let right_elem = self.handle_right_val(val)?;

            self.emit_gep(
                element_ptr.clone(),
                base_ptr.clone(),
                Operand::from(i as i32),
            );
            self.emit_store(right_elem, element_ptr);
        }
        Ok(())
    }

    pub fn handle_local_var_def(&mut self, def: &ast::VarDef) -> Result<(), Error> {
        let identifier = &def.identifier;
        let dtype = match def.type_specifier.as_ref() {
            Some(type_spec) => Some(Dtype::from(type_spec)),
            None => None,
        };

        let variable: Rc<LocalVariable> = match &def.inner {
            ast::VarDefInner::Scalar(scalar) => {
                let right_val = self.handle_right_val(&scalar.val)?;

                let v = match &dtype {
                    None => LocalVariable::new(Dtype::Undecided, 0, Some(identifier.clone())),
                    Some(Dtype::I32) => LocalVariable::new(
                        Dtype::ptr_to(Dtype::I32),
                        self.alloc_vreg(),
                        Some(identifier.clone()),
                    ),
                    _ => return Err(Error::LocalVarDefinitionUnsupported),
                };
                let v = Rc::new(v);

                if dtype.is_some() {
                    self.emit_alloca(Operand::Local(v.as_ref().clone()));
                    self.emit_store(right_val, Operand::Local(v.as_ref().clone()));
                }
                v
            }
            ast::VarDefInner::Array(array) => {
                let (var_dtype, needs_init) = match &dtype {
                    None => (Dtype::array_of(Dtype::I32, array.len), false),
                    Some(Dtype::I32) => (Dtype::array_of(Dtype::I32, array.len), true),
                    _ => return Err(Error::LocalVarDefinitionUnsupported),
                };

                let v = Rc::new(LocalVariable::new(
                    var_dtype,
                    self.alloc_vreg(),
                    Some(identifier.clone()),
                ));

                if needs_init {
                    self.emit_alloca(Operand::Local(v.as_ref().clone()));
                    self.init_array(Operand::Local(v.as_ref().clone()), &array.vals)?;
                }
                v
            }
        };

        if self
            .local_variables
            .insert(identifier.clone(), variable)
            .is_some()
        {
            return Err(Error::VariableRedefinition {
                symbol: identifier.clone(),
            });
        }

        Ok(())
    }

    pub fn handle_call_stmt(&mut self, stmt: &ast::CallStmt) -> Result<(), Error> {
        let function_name = if let Some(module) = &stmt.fn_call.module_prefix {
            format!("{}::{}", module, stmt.fn_call.name)
        } else {
            stmt.fn_call.name.clone()
        };
        let mut args = Vec::new();
        for arg in stmt.fn_call.vals.iter() {
            let right_val = self.handle_right_val(arg)?;
            args.push(right_val);
        }

        match self
            .module_generator
            .registry
            .function_types
            .get(&function_name)
        {
            None => Err(Error::FunctionNotDefined {
                symbol: function_name,
            }),
            Some(function_type) => {
                let retval = match &function_type.return_dtype {
                    Dtype::Void => Ok(None),
                    Dtype::I32 | Dtype::Struct { .. } => Ok(Some(
                        self.alloc_temporary(function_type.return_dtype.clone()),
                    )),
                    _ => Err(Error::FunctionCallUnsupported),
                }?;
                self.emit_call(function_name, retval, args);
                Ok(())
            }
        }
    }

    pub fn handle_if_stmt(
        &mut self,
        stmt: &ast::IfStmt,
        con_label: Option<BlockLabel>,
        bre_label: Option<BlockLabel>,
    ) -> Result<(), Error> {
        let true_label = self.alloc_basic_block();
        let false_label = self.alloc_basic_block();
        let after_label = self.alloc_basic_block();

        let bool_evaluated = self.alloc_temporary(Dtype::ptr_to(Dtype::I32));
        self.handle_bool_unit(&stmt.bool_unit, true_label.clone(), false_label.clone())?;
        self.emit_alloca(bool_evaluated);

        self.emit_label(true_label);
        let local_variables_prev = self.local_variables.clone();
        for s in stmt.if_stmts.iter() {
            self.handle_block(s, con_label.clone(), bre_label.clone())?;
        }
        self.local_variables = local_variables_prev;
        self.emit_jump(after_label.clone());

        self.emit_label(false_label);
        let local_variables_prev = self.local_variables.clone();
        if let Some(else_stmts) = &stmt.else_stmts {
            for s in else_stmts.iter() {
                self.handle_block(s, con_label.clone(), bre_label.clone())?;
            }
        }
        self.local_variables = local_variables_prev;
        self.emit_jump(after_label.clone());

        self.emit_label(after_label);

        Ok(())
    }

    pub fn handle_while_stmt(&mut self, stmt: &ast::WhileStmt) -> Result<(), Error> {
        let test_label = self.alloc_basic_block();
        let true_label = self.alloc_basic_block();
        let false_label = self.alloc_basic_block();

        self.emit_jump(test_label.clone());

        self.emit_label(test_label.clone());
        self.handle_bool_unit(&stmt.bool_unit, true_label.clone(), false_label.clone())?;

        self.emit_label(true_label);
        let local_variables_prev = self.local_variables.clone();
        for s in stmt.stmts.iter() {
            self.handle_block(s, Some(test_label.clone()), Some(false_label.clone()))?;
        }
        self.local_variables = local_variables_prev;
        self.emit_jump(test_label);

        self.emit_label(false_label);
        Ok(())
    }

    pub fn handle_return_stmt(&mut self, stmt: &ast::ReturnStmt) -> Result<(), Error> {
        match &stmt.val {
            None => {
                self.emit_return(None);
            }
            Some(val) => {
                let val = self.handle_right_val(val)?;
                self.emit_return(Some(val));
            }
        }
        Ok(())
    }

    pub fn handle_continue_stmt(&mut self, con_label: Option<BlockLabel>) -> Result<(), Error> {
        let label = con_label.ok_or(Error::InvalidContinueInst)?;
        self.emit_jump(label);
        Ok(())
    }

    pub fn handle_break_stmt(&mut self, bre_label: Option<BlockLabel>) -> Result<(), Error> {
        let label = bre_label.ok_or(Error::InvalidBreakInst)?;
        self.emit_jump(label);
        Ok(())
    }
}

impl<'ir> FunctionGenerator<'ir> {
    fn handle_com_op_expr(
        &mut self,
        expr: &ast::ComExpr,
        true_label: BlockLabel,
        false_label: BlockLabel,
    ) -> Result<(), Error> {
        let left = self.handle_expr_unit(&expr.left)?;
        let right = self.handle_expr_unit(&expr.right)?;

        let dst = self.alloc_temporary(Dtype::I32);
        self.emit_cmp(expr.op.clone(), left, right, dst.clone());
        self.emit_cjump(dst, true_label, false_label);

        Ok(())
    }

    fn handle_expr_unit(&mut self, unit: &ast::ExprUnit) -> Result<Operand, Error> {
        let operand = match &unit.inner {
            ast::ExprUnitInner::Num(num) => Ok(Operand::from(*num)),
            ast::ExprUnitInner::Id(id) => self.lookup_variable(id),
            ast::ExprUnitInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::ExprUnitInner::FnCall(fn_call) => {
                let name = if let Some(module) = &fn_call.module_prefix {
                    format!("{}::{}", module, fn_call.name)
                } else {
                    fn_call.name.clone()
                };
                let return_dtype = &self
                    .module_generator
                    .registry
                    .function_types
                    .get(&name)
                    .ok_or_else(|| Error::InvalidExprUnit {
                        expr_unit: unit.clone(),
                    })?
                    .return_dtype;

                let res = match &return_dtype {
                    Dtype::I32 | Dtype::Struct { .. } => self.alloc_temporary(return_dtype.clone()),
                    _ => {
                        return Err(Error::InvalidExprUnit {
                            expr_unit: unit.clone(),
                        });
                    }
                };

                let mut args: Vec<Operand> = Vec::new();
                for arg in fn_call.vals.iter() {
                    let rval = self.handle_right_val(arg)?;
                    args.push(rval);
                }
                self.emit_call(name, Some(res.clone()), args);

                Ok(res)
            }
            ast::ExprUnitInner::ArrayExpr(expr) => self.handle_array_expr(expr),
            ast::ExprUnitInner::MemberExpr(expr) => self.handle_member_expr(expr),
            ast::ExprUnitInner::ArithUExpr(expr) => self.handle_arith_uexpr(expr),
        }?;

        Ok(match operand.dtype() {
            Dtype::Pointer { inner, length: 0 } if operand.is_addressable() => {
                let dst = self.alloc_temporary(inner.as_ref().clone());
                self.emit_load(dst, operand)
            }
            Dtype::I32 if matches!(&operand, Operand::Global(_)) => {
                let dst = self.alloc_temporary(Dtype::I32);
                self.emit_load(dst, operand)
            }
            _ => operand,
        })
    }

    fn handle_arith_expr(&mut self, expr: &ast::ArithExpr) -> Result<Operand, Error> {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => self.handle_arith_biop_expr(expr),
            ast::ArithExprInner::ExprUnit(unit) => self.handle_expr_unit(unit),
        }
    }

    fn handle_right_val(&mut self, val: &ast::RightVal) -> Result<Operand, Error> {
        match &val.inner {
            ast::RightValInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::RightValInner::BoolExpr(expr) => self.handle_bool_expr_as_value(expr),
        }
    }

    fn handle_array_expr(&mut self, expr: &ast::ArrayExpr) -> Result<Operand, Error> {
        let arr = self.handle_left_val(&expr.arr)?;

        let (arr, arr_dtype) = match arr.dtype() {
            Dtype::Pointer { inner, length: 0 }
                if matches!(inner.as_ref(), Dtype::Pointer { .. }) =>
            {
                let inner_ptr = self.alloc_temporary(inner.as_ref().clone());
                self.emit_load(inner_ptr.clone(), arr);
                (inner_ptr.clone(), inner_ptr.dtype().clone())
            }
            _ => (arr.clone(), arr.dtype().clone()),
        };

        let target = match &arr_dtype {
            Dtype::Pointer { inner, .. } => {
                Ok(self.alloc_temporary(Dtype::ptr_to(inner.as_ref().clone())))
            }
            Dtype::Struct { .. } => Ok(self.alloc_temporary(Dtype::ptr_to(arr_dtype))),
            _ => Err(Error::InvalidArrayExpression),
        }?;

        let index = self.handle_index_expr(expr.idx.as_ref())?;
        self.emit_gep(target.clone(), arr, index);

        Ok(target)
    }

    fn handle_member_expr(&mut self, expr: &ast::MemberExpr) -> Result<Operand, Error> {
        let s = self.handle_left_val(&expr.struct_id)?;

        let type_name = s
            .dtype()
            .struct_type_name()
            .ok_or_else(|| Error::InvalidStructMemberExpression { expr: expr.clone() })?;

        let member = &self
            .module_generator
            .registry
            .struct_types
            .get(type_name)
            .unwrap()
            .elements
            .iter()
            .find(|elem| elem.0 == expr.member_id)
            .unwrap()
            .1;
        let member_dtype = member.dtype.clone();
        let member_offset = member.offset;

        let target = match &member_dtype {
            Dtype::Void | Dtype::Undecided => {
                return Err(Error::InvalidStructMemberExpression { expr: expr.clone() })
            }
            _ => self.alloc_temporary(member_dtype),
        };

        self.emit_gep(target.clone(), s, Operand::from(member_offset));
        Ok(target)
    }

    fn handle_left_val(&mut self, val: &ast::LeftVal) -> Result<Operand, Error> {
        match &val.inner {
            ast::LeftValInner::Id(id) => self.lookup_variable(id),
            ast::LeftValInner::ArrayExpr(expr) => self.handle_array_expr(expr),
            ast::LeftValInner::MemberExpr(expr) => self.handle_member_expr(expr),
        }
    }

    fn handle_arith_uexpr(&mut self, expr: &ast::ArithUExpr) -> Result<Operand, Error> {
        let val = self.handle_expr_unit(expr.expr.as_ref())?;
        let res = self.alloc_temporary(Dtype::I32);
        self.emit_biop(ast::ArithBiOp::Sub, Operand::from(0), val, res.clone());
        Ok(res)
    }

    fn handle_arith_biop_expr(&mut self, expr: &ast::ArithBiOpExpr) -> Result<Operand, Error> {
        let left = self.handle_arith_expr(&expr.left)?;
        let right = self.handle_arith_expr(&expr.right)?;
        let dst = self.alloc_temporary(Dtype::I32);
        self.emit_biop(expr.op.clone(), left, right, dst.clone());
        Ok(dst)
    }

    fn handle_index_expr(&mut self, expr: &ast::IndexExpr) -> Result<Operand, Error> {
        match &expr.inner {
            ast::IndexExprInner::Id(id) => {
                let src = self.lookup_variable(id)?;
                let idx = self.alloc_temporary(Dtype::I32);
                self.emit_load(idx.clone(), src);
                Ok(idx)
            }
            ast::IndexExprInner::Num(num) => Ok(Operand::from(*num as i32)),
        }
    }
}

impl<'ir> FunctionGenerator<'ir> {
    fn handle_bool_expr_as_value(&mut self, expr: &ast::BoolExpr) -> Result<Operand, Error> {
        let true_label = self.alloc_basic_block();
        let false_label = self.alloc_basic_block();
        let after_label = self.alloc_basic_block();

        let bool_evaluated = self.alloc_temporary(Dtype::ptr_to(Dtype::I32));
        self.emit_alloca(bool_evaluated.clone());

        self.handle_bool_expr_as_branch(expr, true_label.clone(), false_label.clone())?;
        self.emit_bool_materialization(
            true_label,
            false_label,
            after_label,
            bool_evaluated.clone(),
        );

        let loaded = self.alloc_temporary(Dtype::I32);
        self.emit_load(loaded.clone(), bool_evaluated);

        Ok(loaded)
    }

    fn handle_bool_expr_as_branch(
        &mut self,
        expr: &ast::BoolExpr,
        true_label: BlockLabel,
        false_label: BlockLabel,
    ) -> Result<(), Error> {
        match &expr.inner {
            ast::BoolExprInner::BoolBiOpExpr(biop) => {
                self.handle_bool_biop_expr(biop, true_label, false_label)
            }
            ast::BoolExprInner::BoolUnit(unit) => {
                self.handle_bool_unit(unit, true_label, false_label)
            }
        }
    }

    fn emit_bool_materialization(
        &mut self,
        true_label: BlockLabel,
        false_label: BlockLabel,
        after_label: BlockLabel,
        bool_ptr: Operand,
    ) {
        self.emit_label(true_label);
        self.emit_store(Operand::from(1), bool_ptr.clone());
        self.emit_jump(after_label.clone());

        self.emit_label(false_label);
        self.emit_store(Operand::from(0), bool_ptr);
        self.emit_jump(after_label.clone());

        self.emit_label(after_label);
    }

    fn handle_bool_biop_expr(
        &mut self,
        expr: &ast::BoolBiOpExpr,
        true_label: BlockLabel,
        false_label: BlockLabel,
    ) -> Result<(), Error> {
        let eval_right_label = self.alloc_basic_block();
        let lhs = self.handle_bool_expr_as_value(&expr.left)?;

        match &expr.op {
            ast::BoolBiOp::And => {
                let lhs_cond = self.emit_bool_to_condition(lhs);
                self.emit_cjump(lhs_cond, eval_right_label.clone(), false_label.clone());
                self.emit_label(eval_right_label);

                let rhs = self.handle_bool_expr_as_value(&expr.right)?;
                let rhs_cond = self.emit_bool_to_condition(rhs);
                self.emit_cjump(rhs_cond, true_label, false_label);
            }
            ast::BoolBiOp::Or => {
                let lhs_cond = self.emit_bool_to_condition(lhs);
                self.emit_cjump(lhs_cond, true_label.clone(), eval_right_label.clone());
                self.emit_label(eval_right_label);

                let rhs = self.handle_bool_expr_as_value(&expr.right)?;
                let rhs_cond = self.emit_bool_to_condition(rhs);
                self.emit_cjump(rhs_cond, true_label, false_label);
            }
        }
        Ok(())
    }

    fn emit_bool_to_condition(&mut self, val: Operand) -> Operand {
        let cond = self.alloc_temporary(Dtype::I32);
        self.emit_cmp(ast::ComOp::Ne, val, Operand::from(0), cond.clone());
        cond
    }

    fn handle_bool_unit(
        &mut self,
        unit: &ast::BoolUnit,
        true_label: BlockLabel,
        false_label: BlockLabel,
    ) -> Result<(), Error> {
        match &unit.inner {
            ast::BoolUnitInner::ComExpr(expr) => {
                self.handle_com_op_expr(expr, true_label, false_label)
            }
            ast::BoolUnitInner::BoolExpr(expr) => {
                self.handle_bool_expr_as_branch(expr, true_label, false_label)
            }
            ast::BoolUnitInner::BoolUOpExpr(expr) => {
                self.handle_bool_unit(&expr.cond, false_label, true_label)
            }
        }
    }
}
