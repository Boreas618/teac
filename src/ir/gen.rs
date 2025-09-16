use indexmap::IndexMap;

use crate::ast::{self, AssignmentStmt, RightValList};
use crate::ir::stmt::Stmt;
use crate::ir::{
    self, BlockLabel, Dtype, FunctionGenerator, LocalVariable, Operand, StructMember, Typed,
};
use std::rc::Rc;

pub trait BaseDtype {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier>;

    fn base_dtype(&self) -> Dtype {
        match self.type_specifier().as_ref().as_ref().map(|t| &t.inner) {
            Some(ast::TypeSpecifierInner::Composite(name)) => Dtype::Struct {
                type_name: name.to_string(),
            },
            Some(ast::TypeSpecifierInner::BuiltIn(_)) | None => Dtype::I32,
        }
    }
}

pub trait Named {
    fn identifier(&self) -> Option<String>;
}

impl BaseDtype for ast::VarDecl {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier> {
        &self.type_specifier
    }
}

impl Named for ast::VarDecl {
    fn identifier(&self) -> Option<String> {
        Some(self.identifier.clone())
    }
}

impl BaseDtype for ast::VarDef {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier> {
        &self.type_specifier
    }
}

impl Named for ast::VarDef {
    fn identifier(&self) -> Option<String> {
        Some(self.identifier.clone())
    }
}

impl Named for ast::VarDeclStmt {
    fn identifier(&self) -> Option<String> {
        match &self.inner {
            ast::VarDeclStmtInner::Decl(d) => Some(d.identifier.clone()),
            ast::VarDeclStmtInner::Def(d) => Some(d.identifier.clone()),
        }
    }
}

impl From<ast::TypeSepcifier> for Dtype {
    fn from(a: ast::TypeSepcifier) -> Self {
        Self::from(&a)
    }
}

impl From<&ast::TypeSepcifier> for Dtype {
    fn from(a: &ast::TypeSepcifier) -> Self {
        match &a.inner {
            ast::TypeSpecifierInner::BuiltIn(_) => Self::I32,
            ast::TypeSpecifierInner::Composite(name) => Self::Struct {
                type_name: name.to_string(),
            },
        }
    }
}

impl TryFrom<&ast::VarDecl> for Dtype {
    type Error = ir::Error;

    fn try_from(decl: &ast::VarDecl) -> Result<Self, Self::Error> {
        let base_dtype = decl.base_dtype();
        match &decl.inner {
            ast::VarDeclInner::Array(decl) => Ok(Dtype::Pointer {
                inner: Box::new(base_dtype),
                length: decl.len,
            }),
            ast::VarDeclInner::Scalar(_) => Ok(decl.base_dtype()),
        }
    }
}

impl TryFrom<&ast::VarDef> for Dtype {
    type Error = ir::Error;

    fn try_from(def: &ast::VarDef) -> Result<Self, Self::Error> {
        if let Dtype::Struct { .. } = &def.base_dtype() {
            return Err(ir::Error::StructInitialization);
        }
        let base_dtype = def.base_dtype();
        match &def.inner {
            ast::VarDefInner::Array(def) => Ok(Dtype::Pointer {
                inner: Box::new(base_dtype),
                length: def.len,
            }),
            ast::VarDefInner::Scalar(_) => Ok(base_dtype),
        }
    }
}

impl TryFrom<&ast::VarDeclStmt> for Dtype {
    type Error = ir::Error;

    fn try_from(value: &ast::VarDeclStmt) -> Result<Self, Self::Error> {
        match &value.inner {
            ast::VarDeclStmtInner::Decl(d) => Dtype::try_from(d.as_ref()),
            ast::VarDeclStmtInner::Def(d) => Dtype::try_from(d.as_ref()),
        }
    }
}

/// Walks all top-level program elements and builds IR metadata:
/// - Function signatures (return type and parameter types)
/// - Global variables
/// - Struct definitions (and layouts)
impl ir::ModuleGenerator {
    pub fn gen(&mut self, from: &ast::Program) -> Result<(), ir::Error> {
        for elem in from.elements.iter() {
            use ast::ProgramElementInner::*;
            match &elem.inner {
                VarDeclStmt(stmt) => self.handle_global_var_decl(stmt)?,
                FnDeclStmt(fn_decl) => self.handle_fn_decl(fn_decl)?,
                FnDef(fn_def) => self.handle_fn_def(fn_def)?,
                StructDef(struct_def) => self.handle_struct_def(struct_def)?,
            }
        }

        for elem in from.elements.iter() {
            use ast::ProgramElementInner::*;
            if let FnDef(fn_def) = &elem.inner {
                let mut function_generator = FunctionGenerator {
                    arguments: Vec::new(),
                    irs: Vec::new(),
                    local_variables: IndexMap::new(),
                    module_generator: self,
                    virt_reg_index: 100,
                    basic_block_index: 1,
                };

                function_generator.gen(fn_def)?;

                // Harvest the emit irs from function_generator to module
                let blocks = Self::harvest_function_irs(function_generator.irs);

                let local_variables = function_generator.local_variables;
                let arguments = function_generator.arguments;

                let fun = self
                    .module
                    .function_list
                    .get_mut(&fn_def.fn_decl.identifier);

                if let Some(f) = fun {
                    f.blocks = Some(blocks);
                    f.local_variables = Some(local_variables);
                    f.arguments = arguments;
                } else {
                    return Err(ir::Error::FunctionNotDefined {
                        symbol: fn_def.fn_decl.identifier.clone(),
                    });
                }
            }
        }

        Ok(())
    }

    fn harvest_function_irs(irs: Vec<ir::stmt::Stmt>) -> Vec<Vec<Stmt>> {
        let mut blocks = Vec::new();
        let mut insts = Vec::new();

        let mut flag = false;
        for stmt in irs {
            if let ir::stmt::StmtInner::Label(_) = &stmt.inner {
                if !insts.is_empty() {
                    blocks.push(insts);
                    insts = Vec::new();
                }
                flag = false;
            }
            if flag {
                continue;
            }
            if matches!(&stmt.inner, ir::stmt::StmtInner::Return(_))
                || matches!(&stmt.inner, ir::stmt::StmtInner::CJump(_))
                || matches!(&stmt.inner, ir::stmt::StmtInner::Jump(_))
            {
                flag = true;
            }
            insts.push(stmt);
        }
        if !insts.is_empty() {
            blocks.push(insts);
        }

        for block_index in 1..blocks.len() {
            let block = blocks.get(block_index).unwrap();
            let (allocas, remaining): (Vec<Stmt>, Vec<Stmt>) = block
                .iter()
                .cloned()
                .partition(|x| matches!(x.inner, ir::stmt::StmtInner::Alloca(_)));
            blocks[0].splice(1..1, allocas);
            blocks[block_index] = remaining;
        }

        return blocks;
    }

    fn handle_global_var_decl(&mut self, stmt: &ast::VarDeclStmt) -> Result<(), ir::Error> {
        let identifier = match stmt.identifier() {
            Some(id) => id,
            None => return Err(ir::Error::SymbolMissing),
        };

        let dtype = ir::Dtype::try_from(stmt)?;
        let initializers = if let ast::VarDeclStmtInner::Def(d) = &stmt.inner {
            Some(match &d.inner {
                ast::VarDefInner::Array(def) => {
                    let initializers = def
                        .vals
                        .iter()
                        .map(|val| Self::handle_right_val_static(val).unwrap())
                        .collect();

                    initializers
                }

                // Global variable should be statically assigned
                ast::VarDefInner::Scalar(scalar) => {
                    let value = Self::handle_right_val_static(&scalar.val)?;
                    vec![value]
                }
            })
        } else {
            None
        };

        self.module
            .global_list
            .insert(
                identifier.clone(),
                ir::GlobalVariable {
                    dtype,
                    identifier,
                    initializers,
                },
            )
            .map_or(Ok(()), |v| {
                Err(ir::Error::VariableRedefinition {
                    symbol: v.identifier,
                })
            })
    }

    fn handle_fn_decl(&mut self, decl: &ast::FnDecl) -> Result<(), ir::Error> {
        let identifier = decl.identifier.clone();

        let mut arguments = Vec::new();
        if let Some(params) = &decl.param_decl {
            for decl in params.decls.iter() {
                let identifier = &decl.identifier().unwrap();
                let dtype = ir::Dtype::try_from(decl)?;
                arguments.push((identifier.clone(), dtype));
            }
        }

        let function_type = ir::FunctionType {
            return_dtype: match decl.return_dtype.as_ref() {
                Some(type_specifier) => type_specifier.into(),
                None => ir::Dtype::Void,
            },
            arguments,
        };

        if let Some(ftype) = self
            .registry
            .function_types
            .insert(identifier.clone(), function_type.clone())
        {
            if ftype != function_type {
                return Err(ir::Error::ConflictedFunction { symbol: identifier });
            }
        }

        self.module.function_list.insert(
            identifier.clone(),
            ir::Function {
                arguments: Vec::new(),
                local_variables: None,
                identifier: identifier.clone(),
                blocks: None,
            },
        );

        Ok(())
    }

    fn handle_fn_def(&mut self, stmt: &ast::FnDef) -> Result<(), ir::Error> {
        let identifier = stmt.fn_decl.identifier.clone();

        match self.registry.function_types.get(&identifier) {
            None => self.handle_fn_decl(&stmt.fn_decl)?,
            Some(ty) => {
                if ty != stmt.fn_decl.as_ref() {
                    return Err(ir::Error::DeclDefMismatch {
                        symbol: identifier.clone(),
                    });
                }
            }
        }

        Ok(())
    }

    fn handle_struct_def(&mut self, struct_def: &ast::StructDef) -> Result<(), ir::Error> {
        let identifier = struct_def.identifier.clone();
        let mut offset = 0;
        let mut elements = Vec::new();

        for decl in struct_def.decls.iter() {
            elements.push((
                decl.identifier.clone(),
                StructMember {
                    offset,
                    dtype: {
                        let base_dtype = match decl.type_specifier.as_ref() {
                            Some(type_specifier) => type_specifier.into(),
                            None => ir::Dtype::Void,
                        };
                        match &decl.inner {
                            ast::VarDeclInner::Scalar(_) => base_dtype,
                            ast::VarDeclInner::Array(array) => ir::Dtype::Pointer {
                                inner: Box::new(base_dtype),
                                length: array.len,
                            },
                        }
                    },
                },
            ));

            offset += 1;
        }

        self.registry
            .struct_types
            .insert(identifier.clone(), ir::StructType { elements });

        Ok(())
    }
}

/// Static methods used during IR generation for static evaluation.
///
/// Some parts of the program, such as global variable initializations,
/// must be evaluated statically rather than at runtime. Also, we expose
/// these static evaluation functions publicly. This won't be probelmatic,
/// as they do not produce side effects on the internal state of the IR
/// Module.
impl ir::ModuleGenerator {
    pub fn handle_right_val_static(r: &ast::RightVal) -> Result<i32, ir::Error> {
        match &r.inner {
            ast::RightValInner::ArithExpr(expr) => Self::handle_arith_expr_static(&expr),
            ast::RightValInner::BoolExpr(expr) => Self::handle_bool_expr_static(&expr),
        }
    }

    pub fn handle_arith_expr_static(expr: &ast::ArithExpr) -> Result<i32, ir::Error> {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => Self::handle_arith_biop_expr_static(&expr),
            ast::ArithExprInner::ExprUnit(unit) => Self::handle_expr_unit_static(&unit),
        }
    }

    pub fn handle_bool_expr_static(expr: &ast::BoolExpr) -> Result<i32, ir::Error> {
        match &expr.inner {
            ast::BoolExprInner::BoolBiOpExpr(expr) => Self::handle_bool_biop_expr_static(&expr),
            ast::BoolExprInner::BoolUnit(unit) => Self::handle_bool_unit_static(&unit),
        }
    }

    pub fn handle_arith_biop_expr_static(expr: &ast::ArithBiOpExpr) -> Result<i32, ir::Error> {
        let left = Self::handle_arith_expr_static(&expr.left)?;
        let right = Self::handle_arith_expr_static(&expr.right)?;
        match &expr.op {
            ast::ArithBiOp::Add => Ok(left + right),
            ast::ArithBiOp::Sub => Ok(left - right),
            ast::ArithBiOp::Mul => Ok(left * right),
            ast::ArithBiOp::Div => Ok(left / right),
        }
    }

    pub fn handle_expr_unit_static(expr: &ast::ExprUnit) -> Result<i32, ir::Error> {
        match &expr.inner {
            ast::ExprUnitInner::Num(num) => Ok(*num),
            ast::ExprUnitInner::ArithExpr(expr) => Self::handle_arith_expr_static(&expr),
            ast::ExprUnitInner::ArithUExpr(expr) => Self::handle_arith_uexpr_static(&expr),
            _ => Err(ir::Error::InvalidExprUnit {
                expr_unit: expr.clone(),
            }),
        }
    }

    pub fn handle_bool_biop_expr_static(expr: &ast::BoolBiOpExpr) -> Result<i32, ir::Error> {
        let left = Self::handle_bool_expr_static(&expr.left)? != 0;
        let right = Self::handle_bool_expr_static(&expr.right)? != 0;
        if expr.op == ast::BoolBiOp::And {
            Ok((left && right) as i32)
        } else {
            Ok((left || right) as i32)
        }
    }

    pub fn handle_bool_unit_static(unit: &ast::BoolUnit) -> Result<i32, ir::Error> {
        match &unit.inner {
            ast::BoolUnitInner::ComExpr(expr) => Self::handle_com_op_expr_static(&expr),
            ast::BoolUnitInner::BoolExpr(expr) => Self::handle_bool_expr_static(&expr),
            ast::BoolUnitInner::BoolUOpExpr(expr) => Self::handle_bool_uop_expr_static(&expr),
        }
    }

    pub fn handle_arith_uexpr_static(u: &ast::ArithUExpr) -> Result<i32, ir::Error> {
        if u.op == ast::ArithUOp::Neg {
            Ok(-Self::handle_expr_unit_static(&u.expr)?)
        } else {
            Ok(0)
        }
    }

    pub fn handle_com_op_expr_static(expr: &ast::ComExpr) -> Result<i32, ir::Error> {
        let left = Self::handle_expr_unit_static(&expr.left)?;
        let right = Self::handle_expr_unit_static(&expr.right)?;
        match expr.op {
            ast::ComOp::Lt => Ok((left < right) as i32),
            ast::ComOp::Eq => Ok((left == right) as i32),
            ast::ComOp::Ge => Ok((left >= right) as i32),
            ast::ComOp::Gt => Ok((left > right) as i32),
            ast::ComOp::Le => Ok((left <= right) as i32),
            ast::ComOp::Ne => Ok((left != right) as i32),
        }
    }

    pub fn handle_bool_uop_expr_static(expr: &ast::BoolUOpExpr) -> Result<i32, ir::Error> {
        if expr.op == ast::BoolUOp::Not {
            Ok((Self::handle_bool_unit_static(&expr.cond)? == 0) as i32)
        } else {
            Ok(0)
        }
    }
}

impl<'ir> ir::FunctionGenerator<'ir> {
    fn handle_com_op_expr(
        &mut self,
        expr: &ast::ComExpr,
        true_label: ir::BlockLabel,
        false_label: ir::BlockLabel,
    ) -> Result<(), ir::Error> {
        let left = self.handle_expr_unit(&expr.left)?;
        let left = self.ptr_deref(left);
        let right = self.handle_expr_unit(&expr.right)?;
        let right = self.ptr_deref(right);

        let index = self.increment_virt_reg_index();
        let dst: Rc<dyn ir::Operand> = Rc::new(ir::LocalVariable::create_int(index));

        self.irs.push(ir::stmt::Stmt::as_cmp(
            expr.op.clone(),
            left,
            right,
            Rc::clone(&dst),
        ));

        self.irs
            .push(ir::stmt::Stmt::as_cjump(dst, true_label, false_label));

        Ok(())
    }

    fn handle_expr_unit(&mut self, unit: &ast::ExprUnit) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        match &unit.inner {
            ast::ExprUnitInner::Num(num) => Ok(Rc::new(ir::Integer::from(*num))),
            ast::ExprUnitInner::Id(id) => {
                if let Some(def) = self.local_variables.get(id) {
                    Ok(def.clone())
                } else if let Some(def) = self.module_generator.module.global_list.get(id) {
                    Ok(Rc::new(def.clone()))
                } else {
                    Err(ir::Error::VariableNotDefined { symbol: id.clone() })
                }
            }
            ast::ExprUnitInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::ExprUnitInner::FnCall(fn_call) => {
                let name = fn_call.name.clone();
                let return_dtype = &self
                    .module_generator
                    .registry
                    .function_types
                    .get(&name)
                    .ok_or_else(|| ir::Error::InvalidExprUnit {
                        expr_unit: unit.clone(),
                    })?
                    .return_dtype;

                let res = match &return_dtype {
                    ir::Dtype::I32 => {
                        ir::LocalVariable::create_int(self.increment_virt_reg_index())
                    }
                    ir::Dtype::Struct { type_name } => ir::LocalVariable::create_struct(
                        type_name.clone(),
                        self.increment_virt_reg_index(),
                    ),
                    _ => {
                        return Err(ir::Error::InvalidExprUnit {
                            expr_unit: unit.clone(),
                        });
                    }
                };

                let res_op = Rc::new(res);

                let mut args: Vec<Rc<dyn ir::Operand>> = Vec::new();
                if let Some(vals) = fn_call.vals.as_ref() {
                    for arg in vals.iter() {
                        let rval = self.handle_right_val(&arg)?;
                        args.push(self.ptr_deref(rval));
                    }
                }
                self.irs.push(ir::stmt::Stmt::as_call(
                    name,
                    Some(Rc::clone(&res_op)),
                    args,
                ));

                Ok(res_op)
            }
            ast::ExprUnitInner::ArrayExpr(expr) => self.handle_array_expr(&expr),
            ast::ExprUnitInner::MemberExpr(expr) => self.handle_member_expr(&expr),
            ast::ExprUnitInner::ArithUExpr(expr) => self.handle_arith_uexpr(&expr),
        }
    }

    fn handle_arith_expr(
        &mut self,
        expr: &ast::ArithExpr,
    ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => self.handle_arith_biop_expr(&expr),
            ast::ArithExprInner::ExprUnit(unit) => {
                let res = self.handle_expr_unit(&unit)?;
                Ok(self.ptr_deref(res))
            }
        }
    }

    fn handle_right_val(&mut self, val: &ast::RightVal) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        match &val.inner {
            ast::RightValInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::RightValInner::BoolExpr(expr) => {
                let true_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
                let false_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
                let after_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());

                let bool_evaluated =
                    ir::LocalVariable::create_int_ptr(self.increment_virt_reg_index(), 0);

                let alloca_dst: Rc<dyn ir::Operand> = Rc::new(bool_evaluated);
                self.irs
                    .push(ir::stmt::Stmt::as_alloca(Rc::clone(&alloca_dst)));
                self.handle_bool_expr(expr, Some(true_label.clone()), Some(false_label.clone()))?;

                self.produce_bool_val(
                    true_label.clone(),
                    false_label.clone(),
                    after_label,
                    Rc::clone(&alloca_dst),
                );

                let bool_val = ir::LocalVariable::create_int(self.increment_virt_reg_index());
                let dst: Rc<dyn ir::Operand> = Rc::new(bool_val);
                let ptr = Rc::clone(&alloca_dst);
                self.irs.push(ir::stmt::Stmt::as_load(Rc::clone(&dst), ptr));

                Ok(dst)
            }
        }
    }

    fn handle_array_expr(
        &mut self,
        expr: &ast::ArrayExpr,
    ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        let arr = self.handle_left_val(&expr.arr)?;

        fn handle_pointer_or_struct_var<T: Operand>(
            var: &T,
            index: usize,
        ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
            match var.dtype() {
                ir::Dtype::Pointer { inner, .. } => match inner.as_ref() {
                    ir::Dtype::I32 => Ok(Rc::new(ir::LocalVariable::create_int_ptr(index, 0))),
                    ir::Dtype::Struct { type_name } => Ok(Rc::new(
                        ir::LocalVariable::create_struct_ptr(type_name.clone(), index, 0),
                    )),
                    _ => Err(ir::Error::InvalidArrayExpression),
                },
                ir::Dtype::Struct {
                    type_name: name, ..
                } => Ok(Rc::new(ir::LocalVariable::create_struct_ptr(
                    name.clone(),
                    index,
                    0,
                ))),
                _ => Err(ir::Error::InvalidArrayExpression),
            }
        }

        let target: Rc<dyn ir::Operand> =
            if let Some(_) = arr.as_ref().as_any().downcast_ref::<ir::Integer>() {
                Err(ir::Error::InvalidArrayExpression)
            } else if let Some(l) = arr.as_ref().as_any().downcast_ref::<ir::LocalVariable>() {
                let index: usize = self.increment_virt_reg_index();
                handle_pointer_or_struct_var(l, index)
            } else if let Some(g) = arr.as_ref().as_any().downcast_ref::<ir::GlobalVariable>() {
                let index = self.increment_virt_reg_index();
                handle_pointer_or_struct_var(g, index)
            } else {
                Err(ir::Error::InvalidOperand)
            }?;

        let index = self.handle_index_expr(expr.idx.as_ref())?;

        self.irs.push(ir::stmt::Stmt::as_gep(
            Rc::clone(&target.clone()),
            arr,
            index,
        ));

        Ok(target)
    }

    fn handle_member_expr(
        &mut self,
        expr: &ast::MemberExpr,
    ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        let s = self.handle_left_val(&expr.struct_id)?;
        let type_name = if let Some(_) = s.as_ref().as_any().downcast_ref::<ir::Integer>() {
            Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() })
        } else if let Some(l) = s.as_ref().as_any().downcast_ref::<ir::LocalVariable>() {
            if let ir::Dtype::Struct { type_name: name } = l.dtype() {
                Ok(name)
            } else if let ir::Dtype::Pointer { inner, .. } = l.dtype() {
                match inner.as_ref() {
                    ir::Dtype::Struct { type_name } => Ok(type_name),
                    _ => Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() }),
                }
            } else {
                Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() })
            }
        } else if let Some(l) = s.as_ref().as_any().downcast_ref::<ir::GlobalVariable>() {
            if let ir::Dtype::Struct { type_name: name } = l.dtype() {
                Ok(name)
            } else if let ir::Dtype::Pointer { inner, .. } = l.dtype() {
                match inner.as_ref() {
                    ir::Dtype::Struct { type_name } => Ok(type_name),
                    _ => Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() }),
                }
            } else {
                Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() })
            }
        } else {
            Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() })
        }?;

        let target_index = self.increment_virt_reg_index();

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

        let target: Rc<dyn ir::Operand> = match &member.dtype {
            ir::Dtype::I32 => Rc::new(ir::LocalVariable::create_int_ptr(target_index, 0)),
            ir::Dtype::Pointer { inner, length } => {
                if let ir::Dtype::I32 = inner.as_ref() {
                    Rc::new(ir::LocalVariable::create_int_ptr(target_index, *length))
                } else if let ir::Dtype::Struct { type_name: name } = inner.as_ref() {
                    Rc::new(ir::LocalVariable::create_struct_ptr(
                        name.clone(),
                        target_index,
                        *length,
                    ))
                } else {
                    return Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() });
                }
            }
            ir::Dtype::Struct { type_name: name } => Rc::new(ir::LocalVariable::create_struct_ptr(
                name.clone(),
                target_index,
                0,
            )),
            ir::Dtype::Void | ir::Dtype::Undecided => {
                return Err(ir::Error::InvalidStructMemberExpression { expr: expr.clone() })
            }
        };

        self.irs.push(ir::stmt::Stmt::as_gep(
            Rc::clone(&target),
            s,
            Rc::new(ir::Integer::from(member.offset)),
        ));

        Ok(target)
    }

    fn handle_left_val(&mut self, val: &ast::LeftVal) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        match &val.inner {
            ast::LeftValInner::Id(id) => {
                if let Some(local) = self.local_variables.get(id) {
                    Ok(local.clone())
                } else if let Some(global) = self.module_generator.module.global_list.get(id) {
                    Ok(Rc::new(global.clone()))
                } else {
                    Err(ir::Error::VariableNotDefined { symbol: id.clone() })
                }
            }
            ast::LeftValInner::ArrayExpr(expr) => self.handle_array_expr(expr),
            ast::LeftValInner::MemberExpr(expr) => self.handle_member_expr(expr),
        }
    }

    fn handle_arith_uexpr(
        &mut self,
        expr: &ast::ArithUExpr,
    ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        let expr = self.handle_expr_unit(expr.expr.as_ref())?;
        let val = self.ptr_deref(expr);
        let res = ir::LocalVariable::create_int(self.increment_virt_reg_index());
        let res_op: Rc<dyn ir::Operand> = Rc::new(res);
        self.irs.push(ir::stmt::Stmt::as_biop(
            ast::ArithBiOp::Sub,
            Rc::new(ir::Integer::from(0)),
            val,
            Rc::clone(&res_op),
        ));

        Ok(res_op)
    }

    fn handle_arith_biop_expr(
        &mut self,
        expr: &ast::ArithBiOpExpr,
    ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        let left = self.handle_arith_expr(&expr.left)?;
        let right = self.handle_arith_expr(&expr.right)?;
        let dst: Rc<dyn ir::Operand> = Rc::new(ir::LocalVariable::create_int(
            self.increment_virt_reg_index(),
        ));

        let biop_stmt = ir::stmt::Stmt::as_biop(expr.op.clone(), left, right, Rc::clone(&dst));
        self.irs.push(biop_stmt);

        Ok(dst)
    }

    fn handle_bool_expr(
        &mut self,
        expr: &ast::BoolExpr,
        true_label: Option<ir::BlockLabel>,
        false_label: Option<ir::BlockLabel>,
    ) -> Result<Option<Rc<dyn ir::Operand>>, ir::Error> {
        if true_label.is_none() && false_label.is_none() {
            let true_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
            let false_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
            let after_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());

            let bool_evaluated: Rc<dyn ir::Operand> = Rc::new(ir::LocalVariable::create_int_ptr(
                self.increment_virt_reg_index(),
                0,
            ));

            self.irs
                .push(ir::stmt::Stmt::as_alloca(Rc::clone(&bool_evaluated)));

            match &expr.inner {
                ast::BoolExprInner::BoolBiOpExpr(expr) => self.handle_bool_biop_expr(
                    expr,
                    Some(true_label.clone()),
                    Some(false_label.clone()),
                )?,
                ast::BoolExprInner::BoolUnit(unit) => self.handle_bool_unit(
                    unit,
                    Some(true_label.clone()),
                    Some(false_label.clone()),
                )?,
            }

            self.produce_bool_val(
                true_label,
                false_label,
                after_label,
                Rc::clone(&bool_evaluated),
            );

            let truncated = ir::LocalVariable::create_int(self.increment_virt_reg_index());
            let bool_val = ir::LocalVariable::create_int(self.increment_virt_reg_index());

            let dst: Rc<dyn ir::Operand> = Rc::new(bool_val);
            let ptr = Rc::clone(&bool_evaluated);
            let retval: Rc<dyn ir::Operand> = Rc::new(truncated);

            self.irs
                .push(ir::stmt::Stmt::as_load(Rc::clone(&dst), Rc::clone(&ptr)));

            self.irs.push(ir::stmt::Stmt::as_cmp(
                ast::ComOp::Ne,
                Rc::clone(&dst),
                Rc::new(ir::Integer::from(0)),
                Rc::clone(&retval),
            ));

            return Ok(Some(retval));
        } else if true_label.is_none() || false_label.is_none() {
            return Err(ir::Error::InvalidBoolExpr);
        }

        match &expr.inner {
            ast::BoolExprInner::BoolBiOpExpr(expr) => {
                self.handle_bool_biop_expr(expr, true_label, false_label)?
            }
            ast::BoolExprInner::BoolUnit(unit) => {
                self.handle_bool_unit(unit, true_label, false_label)?
            }
        }

        Ok(None)
    }

    fn produce_bool_val(
        &mut self,
        true_label: ir::BlockLabel,
        false_label: ir::BlockLabel,
        after_label: ir::BlockLabel,
        bool_evaluated: Rc<dyn ir::Operand>,
    ) {
        let store_src_true = Rc::new(ir::Integer::from(1));
        let store_src_false = Rc::new(ir::Integer::from(0));
        let store_ptr = Rc::clone(&bool_evaluated);

        self.irs.push(ir::stmt::Stmt::as_label(true_label));
        self.irs.push(ir::stmt::Stmt::as_store(
            store_src_true,
            Rc::clone(&store_ptr),
        ));
        self.irs.push(ir::stmt::Stmt::as_jump(after_label.clone()));
        self.irs.push(ir::stmt::Stmt::as_label(false_label));
        self.irs.push(ir::stmt::Stmt::as_store(
            store_src_false,
            Rc::clone(&store_ptr),
        ));
        self.irs.push(ir::stmt::Stmt::as_jump(after_label.clone()));

        self.irs.push(ir::stmt::Stmt::as_label(after_label.clone()));
    }

    fn handle_index_expr(
        &mut self,
        expr: &ast::IndexExpr,
    ) -> Result<Rc<dyn ir::Operand>, ir::Error> {
        match &expr.inner {
            ast::IndexExprInner::Id(id) => {
                let idx: Rc<dyn ir::Operand> = Rc::new(ir::LocalVariable::create_int(
                    self.increment_virt_reg_index(),
                ));

                if self.local_variables.get(id).is_some() {
                    let src = self.local_variables.get(id).unwrap();
                    self.irs.push(ir::stmt::Stmt::as_load(
                        Rc::clone(&idx),
                        src.clone() as Rc<dyn Operand>,
                    ));
                } else if self.module_generator.module.global_list.get(id).is_some() {
                    let src = self.module_generator.module.global_list.get(id).unwrap();
                    self.irs.push(ir::stmt::Stmt::as_load(
                        Rc::clone(&idx),
                        Rc::new(src.clone()),
                    ));
                } else {
                    Err(ir::Error::VariableNotDefined { symbol: id.clone() })?
                }

                Ok(idx)
            }
            ast::IndexExprInner::Num(num) => Ok(Rc::new(ir::Integer::from(*num as i32))),
        }
    }

    fn handle_bool_biop_expr(
        &mut self,
        expr: &ast::BoolBiOpExpr,
        true_label: Option<ir::BlockLabel>,
        false_label: Option<ir::BlockLabel>,
    ) -> Result<(), ir::Error> {
        let eval_right_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
        let lhs = self.handle_bool_expr(&expr.left, None, None)?;

        let false_label_unwrapped = false_label.unwrap().clone();
        let true_label_unwrapped = true_label.unwrap().clone();

        match &expr.op {
            ast::BoolBiOp::And => {
                self.irs.push(ir::stmt::Stmt::as_cjump(
                    lhs.unwrap(),
                    eval_right_label.clone(),
                    false_label_unwrapped.clone(),
                ));
                self.irs.push(ir::stmt::Stmt::as_label(eval_right_label));

                let rhs = self.handle_bool_expr(&expr.right, None, None)?;
                self.irs.push(ir::stmt::Stmt::as_cjump(
                    rhs.unwrap(),
                    true_label_unwrapped,
                    false_label_unwrapped,
                ));

                Ok(())
            }
            ast::BoolBiOp::Or => {
                self.irs.push(ir::stmt::Stmt::as_cjump(
                    lhs.unwrap(),
                    true_label_unwrapped.clone(),
                    eval_right_label.clone(),
                ));
                self.irs.push(ir::stmt::Stmt::as_label(eval_right_label));

                let rhs = self.handle_bool_expr(&expr.right, None, None)?;
                self.irs.push(ir::stmt::Stmt::as_cjump(
                    rhs.unwrap(),
                    true_label_unwrapped,
                    false_label_unwrapped,
                ));

                Ok(())
            }
        }
    }

    fn handle_bool_unit(
        &mut self,
        unit: &ast::BoolUnit,
        true_label: Option<ir::BlockLabel>,
        false_label: Option<ir::BlockLabel>,
    ) -> Result<(), ir::Error> {
        match &unit.inner {
            ast::BoolUnitInner::ComExpr(expr) => {
                self.handle_com_op_expr(expr, true_label.unwrap(), false_label.unwrap())
            }
            ast::BoolUnitInner::BoolExpr(expr) => {
                let _ = self.handle_bool_expr(expr, true_label, false_label)?;
                Ok(())
            }
            ast::BoolUnitInner::BoolUOpExpr(expr) => {
                self.handle_bool_unit(&expr.cond, false_label, true_label)
            }
        }
    }

    fn ptr_deref(&mut self, op: Rc<dyn ir::Operand>) -> Rc<dyn ir::Operand> {
        if let ir::Dtype::Pointer { length, .. } = op.dtype() {
            if op.as_any().downcast_ref::<ir::LocalVariable>().is_some()
                || op.as_any().downcast_ref::<ir::GlobalVariable>().is_some()
            {
                if *length == 0 {
                    let val = ir::LocalVariable::create_int(self.increment_virt_reg_index());
                    let dst: Rc<dyn ir::Operand> = Rc::new(val);
                    self.irs
                        .push(ir::stmt::Stmt::as_load(Rc::clone(&dst), op.clone()));
                    return dst;
                }
            }
        } else if let ir::Dtype::I32 = op.dtype() {
            if op.as_any().downcast_ref::<ir::GlobalVariable>().is_some() {
                let val = ir::LocalVariable::create_int(self.increment_virt_reg_index());
                let dst: Rc<dyn ir::Operand> = Rc::new(val);
                self.irs
                    .push(ir::stmt::Stmt::as_load(Rc::clone(&dst), op.clone()));
                return dst;
            }
        }

        op
    }
}

impl<'ir> ir::FunctionGenerator<'ir> {
    fn gen(&mut self, from: &ast::FnDef) -> Result<(), ir::Error> {
        let identifier = &from.fn_decl.identifier;
        let function_type = self
            .module_generator
            .registry
            .function_types
            .get(identifier)
            .unwrap();

        let arguments = function_type.arguments.clone();
        for (id, dtype) in arguments {
            let var = ir::LocalVariable {
                dtype,
                identifier: Some(id.clone()),
                index: self.increment_virt_reg_index(),
            };
            self.arguments.push(var.clone());
            if self
                .local_variables
                .insert(id.clone(), Rc::new(var))
                .is_some()
            {
                return Err(ir::Error::VariableRedefinition { symbol: id.clone() });
            }
        }

        self.irs.push(ir::stmt::Stmt::as_label(BlockLabel::Function(
            identifier.clone(),
        )));

        for (id, var) in self.local_variables.clone() {
            match &var.dtype {
                ir::Dtype::I32 => {
                    let ptr = Rc::new(ir::LocalVariable::create_int_ptr(
                        self.increment_virt_reg_index(),
                        0,
                    ));
                    self.irs
                        .push(ir::stmt::Stmt::as_alloca(ptr.clone() as Rc<dyn Operand>));
                    self.irs.push(ir::stmt::Stmt::as_store(
                        (var as Rc<dyn Operand>).clone(),
                        ptr.clone() as Rc<dyn Operand>,
                    ));

                    // No need to check duplicated variable definition here, since we are modifying exisiting variable record.
                    self.local_variables.insert(id, ptr);
                }
                ir::Dtype::Pointer { inner, length } => {
                    let ptr = Rc::new(match inner.as_ref() {
                        ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                            var.index,
                            if *length == 0 { usize::MAX } else { *length },
                        )),
                        ir::Dtype::Struct { type_name } => {
                            Ok(ir::LocalVariable::create_struct_ptr(
                                type_name.clone(),
                                var.index,
                                if *length == 0 { usize::MAX } else { *length },
                            ))
                        }
                        _ => Err(ir::Error::ArgumentTypeUnsupported),
                    }?);
                    self.local_variables.insert(id, ptr);
                }
                _ => {
                    return Err(ir::Error::ArgumentTypeUnsupported);
                }
            }
        }

        for stmt in from.stmts.iter() {
            self.handle_block(stmt, None, None)?;
        }

        // If the function body doesn't end with an explicit `return`, append a default one.
        // Only `i32` and `void` returns can be synthesized.
        if let Some(stmt) = self.irs.last() {
            if !matches!(stmt.inner, ir::stmt::StmtInner::Return(_)) {
                let return_type = self
                    .module_generator
                    .registry
                    .function_types
                    .get(identifier)
                    .map(|ft| &ft.return_dtype)
                    .unwrap();

                match return_type {
                    ir::Dtype::I32 => {
                        self.irs
                            .push(ir::stmt::Stmt::as_return(Some(Rc::new(ir::Integer::from(
                                0,
                            )))));
                    }
                    ir::Dtype::Void => {
                        self.irs.push(ir::stmt::Stmt::as_return(None));
                    }
                    _ => return Err(ir::Error::ReturnTypeUnsupported),
                }
            }
        }

        Ok(())
    }

    pub fn handle_block(
        &mut self,
        stmt: &ast::CodeBlockStmt,
        con_label: Option<ir::BlockLabel>,
        bre_label: Option<ir::BlockLabel>,
    ) -> Result<(), ir::Error> {
        let res = match &stmt.inner {
            ast::CodeBlockStmtInner::Assignment(s) => self.handle_assignment_stmt(s),
            ast::CodeBlockStmtInner::VarDecl(s) => match &s.inner {
                ast::VarDeclStmtInner::Decl(d) => self.handle_local_var_decl(d),
                ast::VarDeclStmtInner::Def(d) => self.handle_local_var_def(d),
            },
            ast::CodeBlockStmtInner::Call(s) => self.handle_call_stmt(s),
            ast::CodeBlockStmtInner::If(s) => self.handle_if_stmt(s, con_label, bre_label),
            ast::CodeBlockStmtInner::While(s) => self.handle_while_stmt(s),
            ast::CodeBlockStmtInner::Return(s) => self.handle_return_stmt(s),
            ast::CodeBlockStmtInner::Continue(_) => {
                let label = con_label.ok_or_else(|| return ir::Error::InvalidContinueInst)?;
                self.irs.push(ir::stmt::Stmt::as_jump(label));
                Ok(())
            }
            ast::CodeBlockStmtInner::Break(_) => {
                let label = bre_label.ok_or_else(|| return ir::Error::InvalidBreakInst)?;
                self.irs.push(ir::stmt::Stmt::as_jump(label));
                Ok(())
            }
            ast::CodeBlockStmtInner::Null(_) => Ok(()),
        };
        res
    }

    pub fn handle_assignment_stmt(&mut self, stmt: &AssignmentStmt) -> Result<(), ir::Error> {
        let left = self.handle_left_val(&stmt.left_val)?;
        let right = self.handle_right_val(&stmt.right_val)?;
        let right = self.ptr_deref(right);

        if left.as_ref().dtype() == &ir::Dtype::Undecided {
            let right_type = right.dtype();
            let local_val = match right_type {
                ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                    self.increment_virt_reg_index(),
                    0,
                )),
                ir::Dtype::Struct { type_name } => Ok(ir::LocalVariable::create_struct_ptr(
                    type_name.clone(),
                    self.increment_virt_reg_index(),
                    0,
                )),
                ir::Dtype::Pointer { inner, length } => match inner.as_ref() {
                    ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                        self.increment_virt_reg_index(),
                        *length,
                    )),
                    ir::Dtype::Struct { type_name } => Ok(ir::LocalVariable::create_struct_ptr(
                        type_name.clone(),
                        self.increment_virt_reg_index(),
                        *length,
                    )),
                    _ => Err(ir::Error::LocalVarTypeUnsupported),
                },
                _ => Err(ir::Error::LocalVarTypeUnsupported),
            }?;
            let left = Rc::new(local_val);
            self.irs.push(ir::stmt::Stmt::as_alloca(Rc::clone(
                &(left.clone() as Rc<dyn ir::Operand>),
            )));

            if self
                .local_variables
                .insert(left.as_ref().identifier().unwrap(), left.clone())
                .is_some()
            {
                return Err(ir::Error::VariableRedefinition {
                    symbol: left.as_ref().identifier().unwrap(),
                });
            }
        }
        self.irs.push(ir::stmt::Stmt::as_store(right, left));
        Ok(())
    }

    pub fn handle_local_var_decl(&mut self, decl: &ast::VarDecl) -> Result<(), ir::Error> {
        let identifier = &decl.identifier;
        let dtype = match decl.type_specifier.as_ref() {
            Some(type_spec) => Some(ir::Dtype::from(type_spec)),
            None => None,
        };

        let variable: Rc<LocalVariable> = match &decl.inner {
            ast::VarDeclInner::Scalar(_) => match &dtype {
                None => {
                    let v = Rc::new(ir::LocalVariable::create_undecided());
                    Ok(v)
                }
                Some(inner) => {
                    let v = Rc::new(match inner {
                        ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                            self.increment_virt_reg_index(),
                            0,
                        )),
                        _ => Err(ir::Error::LocalVarDefinitionUnsupported),
                    }?);
                    self.irs.push(ir::stmt::Stmt::as_alloca(v.clone()));
                    Ok(v)
                }
            }?,
            ast::VarDeclInner::Array(array) => {
                match &dtype {
                    // Since we don't support defining an array of structs, we can infer that the
                    // base type is i32.
                    None => Ok(Rc::new(ir::LocalVariable::create_int_ptr(
                        self.increment_virt_reg_index(),
                        array.len,
                    ))),

                    Some(inner) => {
                        let v = match inner {
                            ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                                self.increment_virt_reg_index(),
                                array.len,
                            )),
                            ir::Dtype::Struct { type_name } => {
                                Ok(ir::LocalVariable::create_struct_ptr(
                                    type_name.clone(),
                                    self.increment_virt_reg_index(),
                                    array.len,
                                ))
                            }
                            _ => Err(ir::Error::LocalVarDefinitionUnsupported),
                        }?;
                        let v = Rc::new(v);
                        self.irs.push(ir::stmt::Stmt::as_alloca(v.clone()));

                        Ok(v)
                    }
                }?
            }
        };

        if self
            .local_variables
            .insert(identifier.clone(), variable)
            .is_some()
        {
            return Err(ir::Error::VariableRedefinition {
                symbol: identifier.clone(),
            });
        }

        Ok(())
    }

    pub fn init_array(
        &mut self,
        base_ptr: Rc<dyn Operand>,
        vals: Box<RightValList>,
    ) -> Result<(), ir::Error> {
        // let vals_size = vals.iter().count();
        for (i, val) in vals.iter().enumerate() {
            let element_ptr: Rc<dyn Operand> = Rc::new(ir::LocalVariable::create_int_ptr(
                self.increment_virt_reg_index(),
                0,
            ));
            let right_elem = self.handle_right_val(val)?;
            let right_elem = self.ptr_deref(right_elem);

            self.irs.push(ir::stmt::Stmt::as_gep(
                element_ptr.clone(),
                base_ptr.clone(),
                Rc::new(ir::Integer::from(i as i32)),
            ));

            self.irs
                .push(ir::stmt::Stmt::as_store(right_elem, element_ptr));
        }

        Ok(())
    }

    pub fn handle_local_var_def(&mut self, def: &ast::VarDef) -> Result<(), ir::Error> {
        let identifier = &def.identifier;
        let dtype = match def.type_specifier.as_ref() {
            Some(type_spec) => Some(ir::Dtype::from(type_spec)),
            None => None,
        };

        let variable: Rc<LocalVariable> = match &def.inner {
            ast::VarDefInner::Scalar(scalar) => {
                let right_val = self.handle_right_val(&scalar.val)?;
                let right_val = self.ptr_deref(right_val);
                match &dtype {
                    None => {
                        let v = Rc::new(ir::LocalVariable::create_undecided());
                        Ok(v)
                    }
                    Some(inner) => {
                        let v = Rc::new(match inner {
                            ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                                self.increment_virt_reg_index(),
                                0,
                            )),
                            _ => Err(ir::Error::LocalVarDefinitionUnsupported),
                        }?);
                        self.irs.push(ir::stmt::Stmt::as_alloca(v.clone()));
                        self.irs
                            .push(ir::stmt::Stmt::as_store(right_val, v.clone()));
                        Ok(v)
                    }
                }?
            }
            ast::VarDefInner::Array(array) => {
                match &dtype {
                    // Since we don't support defining an array of structs, we can infer that the
                    // base type is i32.
                    None => Ok(Rc::new(ir::LocalVariable::create_int_ptr(
                        self.increment_virt_reg_index(),
                        array.len,
                    ))),

                    Some(inner) => {
                        let v = match inner {
                            ir::Dtype::I32 => Ok(ir::LocalVariable::create_int_ptr(
                                self.increment_virt_reg_index(),
                                array.len,
                            )),
                            ir::Dtype::Struct { type_name } => {
                                Ok(ir::LocalVariable::create_struct_ptr(
                                    type_name.clone(),
                                    self.increment_virt_reg_index(),
                                    array.len,
                                ))
                            }
                            _ => Err(ir::Error::LocalVarDefinitionUnsupported),
                        }?;
                        let v = Rc::new(v);
                        self.irs.push(ir::stmt::Stmt::as_alloca(v.clone()));

                        match inner {
                            ir::Dtype::I32 => self.init_array(v.clone(), array.vals.clone()),
                            _ => Err(ir::Error::LocalVarDefinitionUnsupported),
                        }?;

                        Ok(v)
                    }
                }?
            }
        };

        if self
            .local_variables
            .insert(identifier.clone(), variable)
            .is_some()
        {
            return Err(ir::Error::VariableRedefinition {
                symbol: identifier.clone(),
            });
        }

        Ok(())
    }

    pub fn handle_call_stmt(&mut self, stmt: &ast::CallStmt) -> Result<(), ir::Error> {
        let function_name = stmt.fn_call.name.clone();
        let mut args = Vec::new();
        if stmt.fn_call.vals.is_some() {
            for arg in stmt.fn_call.vals.as_ref().unwrap().iter() {
                let right_val = self.handle_right_val(arg)?;
                args.push(self.ptr_deref(right_val));
            }
        }

        match self
            .module_generator
            .registry
            .function_types
            .get(&function_name)
        {
            None => Err(ir::Error::FunctionNotDefined {
                symbol: function_name,
            }),
            Some(function_type) => {
                let ret = match &function_type.return_dtype {
                    ir::Dtype::Void => Ok(None),
                    ir::Dtype::I32 => Ok(Some(Rc::new(ir::LocalVariable::create_int(
                        self.increment_virt_reg_index(),
                    )))),
                    ir::Dtype::Struct { type_name } => {
                        Ok(Some(Rc::new(ir::LocalVariable::create_struct_ptr(
                            type_name.clone(),
                            self.increment_virt_reg_index(),
                            0,
                        ))))
                    }
                    _ => Err(ir::Error::FunctionCallUnsupported),
                }?;
                self.irs
                    .push(ir::stmt::Stmt::as_call(function_name, ret, args));

                Ok(())
            }
        }
    }

    pub fn handle_if_stmt(
        &mut self,
        stmt: &ast::IfStmt,
        con_label: Option<ir::BlockLabel>,
        bre_label: Option<ir::BlockLabel>,
    ) -> Result<(), ir::Error> {
        let true_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
        let false_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
        let after_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());

        let bool_evaluated = ir::LocalVariable::create_int_ptr(self.increment_virt_reg_index(), 0);
        self.handle_bool_unit(
            &stmt.bool_unit,
            Some(true_label.clone()),
            Some(false_label.clone()),
        )?;

        self.irs
            .push(ir::stmt::Stmt::as_alloca(Rc::new(bool_evaluated)));

        // True block
        self.irs.push(ir::stmt::Stmt::as_label(true_label));
        let local_variables_prev = self.local_variables.clone();
        for s in stmt.if_stmts.iter() {
            self.handle_block(s, con_label.clone(), bre_label.clone())?;
        }
        self.local_variables = local_variables_prev;
        self.irs.push(ir::stmt::Stmt::as_jump(after_label.clone()));

        // False block
        self.irs.push(ir::stmt::Stmt::as_label(false_label));
        let local_variables_prev = self.local_variables.clone();
        if let Some(else_stmts) = &stmt.else_stmts {
            for s in else_stmts.iter() {
                self.handle_block(s, con_label.clone(), bre_label.clone())?;
            }
        }
        self.local_variables = local_variables_prev;
        self.irs.push(ir::stmt::Stmt::as_jump(after_label.clone()));

        // After block
        self.irs.push(ir::stmt::Stmt::as_label(after_label.clone()));

        Ok(())
    }

    pub fn handle_while_stmt(&mut self, stmt: &ast::WhileStmt) -> Result<(), ir::Error> {
        let test_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
        let true_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());
        let false_label = ir::BlockLabel::BasicBlock(self.increment_basic_block_index());

        // Every block should end with a `br` instruction. Therefore, we manually
        // terminate the last block here.
        //
        // Note the subtle difference between the `if` and `while` statements. In
        // the case of an `if`, the boolean condition is evaluated only once, so
        // `HandleBoolUnit` can be included in the previous block. However, in a
        // `while`, the condition is checked multiple times, which introduces a
        // `test_label` right before `HandleBoolUnit`. Although `HandleBoolUnit`
        // emits a `br` to terminate the block, the presence of the `test_label`
        // before it causes the last block to end without `br`, which violates the
        // rule of terminating a block with a `br`. To address this, we manually
        // insert a jump here to ensure proper block termination.
        self.irs.push(ir::stmt::Stmt::as_jump(test_label.clone()));

        // Test block
        self.irs.push(ir::stmt::Stmt::as_label(test_label.clone()));
        self.handle_bool_unit(
            &stmt.bool_unit,
            Some(true_label.clone()),
            Some(false_label.clone()),
        )?;

        // While body
        self.irs.push(ir::stmt::Stmt::as_label(true_label.clone()));
        let local_variables_prev = self.local_variables.clone();
        for s in stmt.stmts.iter() {
            self.handle_block(s, Some(test_label.clone()), Some(false_label.clone()))?;
        }
        self.local_variables = local_variables_prev;
        self.irs.push(ir::stmt::Stmt::as_jump(test_label.clone()));

        // After while
        self.irs.push(ir::stmt::Stmt::as_label(false_label));
        Ok(())
    }

    pub fn handle_return_stmt(&mut self, stmt: &ast::ReturnStmt) -> Result<(), ir::Error> {
        match &stmt.val {
            None => {
                self.irs.push(ir::stmt::Stmt::as_return(None));
            }
            Some(val) => {
                let val = self.handle_right_val(val)?;
                self.irs.push(ir::stmt::Stmt::as_return(Some(val)));
            }
        }
        Ok(())
    }
}
