//! Function body IR generation.
//!
//! Handles:
//! - Expression evaluation (arithmetic, boolean, array, struct member)
//! - Statement generation (assignment, if, while, return, etc.)
//! - Local variable declarations and definitions

use std::rc::Rc;

use crate::ast::{self, AssignmentStmt, RightValList};
use crate::ir::function::{BlockLabel, FunctionGenerator};
use crate::ir::stmt::StmtInner;
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Named, Value};
use crate::ir::Error;

// =============================================================================
// Function Entry Point
// =============================================================================

impl<'ir> FunctionGenerator<'ir> {
    /// Generates IR for a function definition.
    pub fn gen(&mut self, from: &ast::FnDef) -> Result<(), Error> {
        let identifier = &from.fn_decl.identifier;
        let function_type = self
            .module_generator
            .registry
            .function_types
            .get(identifier)
            .unwrap();

        // Allocate register indices for all arguments
        let arguments = function_type.arguments.clone();
        for (id, dtype) in arguments.iter() {
            let var = LocalVariable::builder()
                .dtype(dtype.clone())
                .identifier(id.clone())
                .index(self.increment_virt_reg_index())
                .build();
            self.arguments.push(var.clone());
            if self
                .local_variables
                .insert(id.clone(), Rc::new(var))
                .is_some()
            {
                return Err(Error::VariableRedefinition { symbol: id.clone() });
            }
        }

        self.emit_label(BlockLabel::Function(identifier.clone()));

        // Create pointer variables for i32 arguments
        for (id, var) in self.local_variables.clone() {
            match &var.dtype {
                Dtype::I32 => {
                    let ptr = Rc::new(
                        LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::I32),
                                length: 0,
                            })
                            .index(self.increment_virt_reg_index())
                            .build(),
                    );
                    self.emit_alloca(Value::Local(ptr.as_ref().clone()));
                    self.emit_store(
                        Value::Local(var.as_ref().clone()),
                        Value::Local(ptr.as_ref().clone()),
                    );
                    self.local_variables.insert(id, ptr);
                }
                Dtype::Pointer { inner, length } => {
                    let ptr = Rc::new(match inner.as_ref() {
                        Dtype::I32 => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::I32),
                                length: if *length == 0 { usize::MAX } else { *length },
                            })
                            .index(var.index)
                            .build()),
                        Dtype::Struct { type_name } => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::Struct {
                                    type_name: type_name.clone(),
                                }),
                                length: if *length == 0 { usize::MAX } else { *length },
                            })
                            .index(var.index)
                            .build()),
                        _ => Err(Error::ArgumentTypeUnsupported),
                    }?);
                    self.local_variables.insert(id, ptr);
                }
                _ => {
                    return Err(Error::ArgumentTypeUnsupported);
                }
            }
        }

        for stmt in from.stmts.iter() {
            self.handle_block(stmt, None, None)?;
        }

        // Append default return if needed
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
                        self.emit_return(Some(Value::from(0)));
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

// =============================================================================
// Statement Handlers
// =============================================================================

impl<'ir> FunctionGenerator<'ir> {
    /// Handles a code block statement.
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
            ast::CodeBlockStmtInner::Continue(_) => {
                let label = con_label.ok_or(Error::InvalidContinueInst)?;
                self.emit_jump(label);
                Ok(())
            }
            ast::CodeBlockStmtInner::Break(_) => {
                let label = bre_label.ok_or(Error::InvalidBreakInst)?;
                self.emit_jump(label);
                Ok(())
            }
            ast::CodeBlockStmtInner::Null(_) => Ok(()),
        }
    }

    /// Handles an assignment statement.
    pub fn handle_assignment_stmt(&mut self, stmt: &AssignmentStmt) -> Result<(), Error> {
        let left = self.handle_left_val(&stmt.left_val)?;
        let right = self.handle_right_val(&stmt.right_val)?;
        let right = self.ptr_deref(right);

        if left.dtype() == &Dtype::Undecided {
            let right_type = right.dtype();
            let local_val = self.create_ptr_for_dtype(right_type, 0)?;
            let left = Value::Local(local_val.clone());
            self.emit_alloca(left.clone());

            if self
                .local_variables
                .insert(local_val.identifier().unwrap(), Rc::new(local_val.clone()))
                .is_some()
            {
                return Err(Error::VariableRedefinition {
                    symbol: local_val.identifier().unwrap(),
                });
            }
            self.emit_store(right, left);
        } else {
            self.emit_store(right, left);
        }
        Ok(())
    }

    /// Handles a local variable declaration.
    pub fn handle_local_var_decl(&mut self, decl: &ast::VarDecl) -> Result<(), Error> {
        let identifier = &decl.identifier;
        let dtype = match decl.type_specifier.as_ref() {
            Some(type_spec) => Some(Dtype::from(type_spec)),
            None => None,
        };

        let variable: Rc<LocalVariable> = match &decl.inner {
            ast::VarDeclInner::Scalar(_) => match &dtype {
                None => {
                    let v = Rc::new(
                        LocalVariable::builder()
                            .dtype(Dtype::Undecided)
                            .index(0)
                            .build(),
                    );
                    Ok(v)
                }
                Some(inner) => {
                    let v = Rc::new(match inner {
                        Dtype::I32 => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::I32),
                                length: 0,
                            })
                            .index(self.increment_virt_reg_index())
                            .build()),
                        _ => Err(Error::LocalVarDefinitionUnsupported),
                    }?);
                    self.emit_alloca(Value::Local(v.as_ref().clone()));
                    Ok(v)
                }
            }?,
            ast::VarDeclInner::Array(array) => match &dtype {
                None => Ok(Rc::new(
                    LocalVariable::builder()
                        .dtype(Dtype::Pointer {
                            inner: Box::new(Dtype::I32),
                            length: array.len,
                        })
                        .index(self.increment_virt_reg_index())
                        .build(),
                )),
                Some(inner) => {
                    let v = match inner {
                        Dtype::I32 => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::I32),
                                length: array.len,
                            })
                            .index(self.increment_virt_reg_index())
                            .build()),
                        Dtype::Struct { type_name } => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::Struct {
                                    type_name: type_name.clone(),
                                }),
                                length: array.len,
                            })
                            .index(self.increment_virt_reg_index())
                            .build()),
                        _ => Err(Error::LocalVarDefinitionUnsupported),
                    }?;
                    let v = Rc::new(v);
                    self.emit_alloca(Value::Local(v.as_ref().clone()));
                    Ok(v)
                }
            }?,
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

    /// Initializes an array with values.
    pub fn init_array(&mut self, base_ptr: Value, vals: &RightValList) -> Result<(), Error> {
        for (i, val) in vals.iter().enumerate() {
            let element_ptr = self.new_int_ptr_reg(0);
            let right_elem = self.handle_right_val(val)?;
            let right_elem = self.ptr_deref(right_elem);

            self.emit_gep(element_ptr.clone(), base_ptr.clone(), Value::from(i as i32));
            self.emit_store(right_elem, element_ptr);
        }
        Ok(())
    }

    /// Handles a local variable definition.
    pub fn handle_local_var_def(&mut self, def: &ast::VarDef) -> Result<(), Error> {
        let identifier = &def.identifier;
        let dtype = match def.type_specifier.as_ref() {
            Some(type_spec) => Some(Dtype::from(type_spec)),
            None => None,
        };

        let variable: Rc<LocalVariable> = match &def.inner {
            ast::VarDefInner::Scalar(scalar) => {
                let right_val = self.handle_right_val(&scalar.val)?;
                let right_val = self.ptr_deref(right_val);
                match &dtype {
                    None => {
                        let v = Rc::new(
                            LocalVariable::builder()
                                .dtype(Dtype::Undecided)
                                .index(0)
                                .build(),
                        );
                        Ok(v)
                    }
                    Some(inner) => {
                        let v = Rc::new(match inner {
                            Dtype::I32 => Ok(LocalVariable::builder()
                                .dtype(Dtype::Pointer {
                                    inner: Box::new(Dtype::I32),
                                    length: 0,
                                })
                                .index(self.increment_virt_reg_index())
                                .build()),
                            _ => Err(Error::LocalVarDefinitionUnsupported),
                        }?);
                        self.emit_alloca(Value::Local(v.as_ref().clone()));
                        self.emit_store(right_val, Value::Local(v.as_ref().clone()));
                        Ok(v)
                    }
                }?
            }
            ast::VarDefInner::Array(array) => match &dtype {
                None => Ok(Rc::new(
                    LocalVariable::builder()
                        .dtype(Dtype::Pointer {
                            inner: Box::new(Dtype::I32),
                            length: array.len,
                        })
                        .index(self.increment_virt_reg_index())
                        .build(),
                )),
                Some(inner) => {
                    let v = match inner {
                        Dtype::I32 => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::I32),
                                length: array.len,
                            })
                            .index(self.increment_virt_reg_index())
                            .build()),
                        Dtype::Struct { type_name } => Ok(LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::Struct {
                                    type_name: type_name.clone(),
                                }),
                                length: array.len,
                            })
                            .index(self.increment_virt_reg_index())
                            .build()),
                        _ => Err(Error::LocalVarDefinitionUnsupported),
                    }?;
                    let v = Rc::new(v);
                    self.emit_alloca(Value::Local(v.as_ref().clone()));

                    if matches!(inner, Dtype::I32) {
                        self.init_array(Value::Local(v.as_ref().clone()), &array.vals)?;
                    } else {
                        return Err(Error::LocalVarDefinitionUnsupported);
                    }

                    Ok(v)
                }
            }?,
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

    /// Handles a function call statement.
    pub fn handle_call_stmt(&mut self, stmt: &ast::CallStmt) -> Result<(), Error> {
        let function_name = stmt.fn_call.name.clone();
        let mut args = Vec::new();
        for arg in stmt.fn_call.vals.iter() {
            let right_val = self.handle_right_val(arg)?;
            args.push(self.ptr_deref(right_val));
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
                let ret = match &function_type.return_dtype {
                    Dtype::Void => Ok(None),
                    Dtype::I32 => Ok(Some(
                        LocalVariable::builder()
                            .dtype(Dtype::I32)
                            .index(self.increment_virt_reg_index())
                            .build(),
                    )),
                    Dtype::Struct { type_name } => Ok(Some(
                        LocalVariable::builder()
                            .dtype(Dtype::Pointer {
                                inner: Box::new(Dtype::Struct {
                                    type_name: type_name.clone(),
                                }),
                                length: 0,
                            })
                            .index(self.increment_virt_reg_index())
                            .build(),
                    )),
                    _ => Err(Error::FunctionCallUnsupported),
                }?;
                self.emit_call(function_name, ret, args);
                Ok(())
            }
        }
    }

    /// Handles an if statement.
    pub fn handle_if_stmt(
        &mut self,
        stmt: &ast::IfStmt,
        con_label: Option<BlockLabel>,
        bre_label: Option<BlockLabel>,
    ) -> Result<(), Error> {
        let true_label = self.new_block_label();
        let false_label = self.new_block_label();
        let after_label = self.new_block_label();

        let bool_evaluated = self.new_int_ptr_reg(0);
        self.handle_bool_unit(&stmt.bool_unit, true_label.clone(), false_label.clone())?;
        self.emit_alloca(bool_evaluated);

        // True block
        self.emit_label(true_label);
        let local_variables_prev = self.local_variables.clone();
        for s in stmt.if_stmts.iter() {
            self.handle_block(s, con_label.clone(), bre_label.clone())?;
        }
        self.local_variables = local_variables_prev;
        self.emit_jump(after_label.clone());

        // False block
        self.emit_label(false_label);
        let local_variables_prev = self.local_variables.clone();
        if let Some(else_stmts) = &stmt.else_stmts {
            for s in else_stmts.iter() {
                self.handle_block(s, con_label.clone(), bre_label.clone())?;
            }
        }
        self.local_variables = local_variables_prev;
        self.emit_jump(after_label.clone());

        // After block
        self.emit_label(after_label);

        Ok(())
    }

    /// Handles a while statement.
    pub fn handle_while_stmt(&mut self, stmt: &ast::WhileStmt) -> Result<(), Error> {
        let test_label = self.new_block_label();
        let true_label = self.new_block_label();
        let false_label = self.new_block_label();

        self.emit_jump(test_label.clone());

        // Test block
        self.emit_label(test_label.clone());
        self.handle_bool_unit(&stmt.bool_unit, true_label.clone(), false_label.clone())?;

        // While body
        self.emit_label(true_label);
        let local_variables_prev = self.local_variables.clone();
        for s in stmt.stmts.iter() {
            self.handle_block(s, Some(test_label.clone()), Some(false_label.clone()))?;
        }
        self.local_variables = local_variables_prev;
        self.emit_jump(test_label);

        // After while
        self.emit_label(false_label);
        Ok(())
    }

    /// Handles a return statement.
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
}

// =============================================================================
// Expression Handlers
// =============================================================================

impl<'ir> FunctionGenerator<'ir> {
    /// Handles a comparison expression, emitting comparison and conditional jump.
    fn handle_com_op_expr(
        &mut self,
        expr: &ast::ComExpr,
        true_label: BlockLabel,
        false_label: BlockLabel,
    ) -> Result<(), Error> {
        let left = self.handle_expr_unit(&expr.left)?;
        let left = self.ptr_deref(left);
        let right = self.handle_expr_unit(&expr.right)?;
        let right = self.ptr_deref(right);

        let dst = self.new_int_reg();
        self.emit_cmp(expr.op.clone(), left, right, dst.clone());
        self.emit_cjump(dst, true_label, false_label);

        Ok(())
    }

    /// Handles an expression unit and returns its value.
    fn handle_expr_unit(&mut self, unit: &ast::ExprUnit) -> Result<Value, Error> {
        match &unit.inner {
            ast::ExprUnitInner::Num(num) => Ok(Value::from(*num)),
            ast::ExprUnitInner::Id(id) => self.lookup_variable(id),
            ast::ExprUnitInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::ExprUnitInner::FnCall(fn_call) => {
                let name = fn_call.name.clone();
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
                    Dtype::I32 => LocalVariable::builder()
                        .dtype(Dtype::I32)
                        .index(self.increment_virt_reg_index())
                        .build(),
                    Dtype::Struct { type_name } => LocalVariable::builder()
                        .dtype(Dtype::Struct {
                            type_name: type_name.clone(),
                        })
                        .index(self.increment_virt_reg_index())
                        .build(),
                    _ => {
                        return Err(Error::InvalidExprUnit {
                            expr_unit: unit.clone(),
                        });
                    }
                };

                let mut args: Vec<Value> = Vec::new();
                for arg in fn_call.vals.iter() {
                    let rval = self.handle_right_val(arg)?;
                    args.push(self.ptr_deref(rval));
                }
                self.emit_call(name, Some(res.clone()), args);

                Ok(Value::Local(res))
            }
            ast::ExprUnitInner::ArrayExpr(expr) => self.handle_array_expr(expr),
            ast::ExprUnitInner::MemberExpr(expr) => self.handle_member_expr(expr),
            ast::ExprUnitInner::ArithUExpr(expr) => self.handle_arith_uexpr(expr),
        }
    }

    /// Handles an arithmetic expression.
    fn handle_arith_expr(&mut self, expr: &ast::ArithExpr) -> Result<Value, Error> {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => self.handle_arith_biop_expr(expr),
            ast::ArithExprInner::ExprUnit(unit) => {
                let res = self.handle_expr_unit(unit)?;
                Ok(self.ptr_deref(res))
            }
        }
    }

    /// Handles a right-value expression.
    fn handle_right_val(&mut self, val: &ast::RightVal) -> Result<Value, Error> {
        match &val.inner {
            ast::RightValInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::RightValInner::BoolExpr(expr) => self.handle_bool_expr_as_value(expr),
        }
    }

    /// Handles an array indexing expression.
    fn handle_array_expr(&mut self, expr: &ast::ArrayExpr) -> Result<Value, Error> {
        let arr = self.handle_left_val(&expr.arr)?;

        let target = match &arr {
            Value::Integer(_) => Err(Error::InvalidArrayExpression),
            Value::Local(l) => self.create_ptr_from_dtype(&l.dtype),
            Value::Global(g) => self.create_ptr_from_dtype(&g.dtype),
        }?;

        let index = self.handle_index_expr(expr.idx.as_ref())?;
        self.emit_gep(target.clone(), arr, index);

        Ok(target)
    }

    /// Creates a pointer Value from a dtype for GEP result.
    fn create_ptr_from_dtype(&mut self, dtype: &Dtype) -> Result<Value, Error> {
        let index = self.increment_virt_reg_index();
        match dtype {
            Dtype::Pointer { inner, .. } => match inner.as_ref() {
                Dtype::I32 => Ok(Value::Local(
                    LocalVariable::builder()
                        .dtype(Dtype::Pointer {
                            inner: Box::new(Dtype::I32),
                            length: 0,
                        })
                        .index(index)
                        .build(),
                )),
                Dtype::Struct { type_name } => Ok(Value::Local(
                    LocalVariable::builder()
                        .dtype(Dtype::Pointer {
                            inner: Box::new(Dtype::Struct {
                                type_name: type_name.clone(),
                            }),
                            length: 0,
                        })
                        .index(index)
                        .build(),
                )),
                _ => Err(Error::InvalidArrayExpression),
            },
            Dtype::Struct { type_name } => Ok(Value::Local(
                LocalVariable::builder()
                    .dtype(Dtype::Pointer {
                        inner: Box::new(Dtype::Struct {
                            type_name: type_name.clone(),
                        }),
                        length: 0,
                    })
                    .index(index)
                    .build(),
            )),
            _ => Err(Error::InvalidArrayExpression),
        }
    }

    /// Handles a struct member access expression.
    fn handle_member_expr(&mut self, expr: &ast::MemberExpr) -> Result<Value, Error> {
        let s = self.handle_left_val(&expr.struct_id)?;

        let type_name = s
            .dtype()
            .struct_type_name()
            .ok_or_else(|| Error::InvalidStructMemberExpression { expr: expr.clone() })?;

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

        let target = match &member.dtype {
            Dtype::I32 => Value::Local(
                LocalVariable::builder()
                    .dtype(Dtype::Pointer {
                        inner: Box::new(Dtype::I32),
                        length: 0,
                    })
                    .index(target_index)
                    .build(),
            ),
            Dtype::Pointer { inner, length } => match inner.as_ref() {
                Dtype::I32 => Value::Local(
                    LocalVariable::builder()
                        .dtype(Dtype::Pointer {
                            inner: Box::new(Dtype::I32),
                            length: *length,
                        })
                        .index(target_index)
                        .build(),
                ),
                Dtype::Struct { type_name } => Value::Local(
                    LocalVariable::builder()
                        .dtype(Dtype::Pointer {
                            inner: Box::new(Dtype::Struct {
                                type_name: type_name.clone(),
                            }),
                            length: *length,
                        })
                        .index(target_index)
                        .build(),
                ),
                _ => return Err(Error::InvalidStructMemberExpression { expr: expr.clone() }),
            },
            Dtype::Struct { type_name } => Value::Local(
                LocalVariable::builder()
                    .dtype(Dtype::Pointer {
                        inner: Box::new(Dtype::Struct {
                            type_name: type_name.clone(),
                        }),
                        length: 0,
                    })
                    .index(target_index)
                    .build(),
            ),
            Dtype::Void | Dtype::Undecided => {
                return Err(Error::InvalidStructMemberExpression { expr: expr.clone() })
            }
        };

        self.emit_gep(target.clone(), s, Value::from(member.offset));
        Ok(target)
    }

    /// Handles a left-value expression.
    fn handle_left_val(&mut self, val: &ast::LeftVal) -> Result<Value, Error> {
        match &val.inner {
            ast::LeftValInner::Id(id) => self.lookup_variable(id),
            ast::LeftValInner::ArrayExpr(expr) => self.handle_array_expr(expr),
            ast::LeftValInner::MemberExpr(expr) => self.handle_member_expr(expr),
        }
    }

    /// Handles a unary arithmetic expression (negation).
    fn handle_arith_uexpr(&mut self, expr: &ast::ArithUExpr) -> Result<Value, Error> {
        let expr_val = self.handle_expr_unit(expr.expr.as_ref())?;
        let val = self.ptr_deref(expr_val);
        let res = self.new_int_reg();
        self.emit_biop(ast::ArithBiOp::Sub, Value::from(0), val, res.clone());
        Ok(res)
    }

    /// Handles a binary arithmetic expression.
    fn handle_arith_biop_expr(&mut self, expr: &ast::ArithBiOpExpr) -> Result<Value, Error> {
        let left = self.handle_arith_expr(&expr.left)?;
        let right = self.handle_arith_expr(&expr.right)?;
        let dst = self.new_int_reg();
        self.emit_biop(expr.op.clone(), left, right, dst.clone());
        Ok(dst)
    }

    /// Handles an index expression for array access.
    fn handle_index_expr(&mut self, expr: &ast::IndexExpr) -> Result<Value, Error> {
        match &expr.inner {
            ast::IndexExprInner::Id(id) => {
                let src = self.lookup_variable(id)?;
                let idx = self.new_int_reg();
                self.emit_load(idx.clone(), src);
                Ok(idx)
            }
            ast::IndexExprInner::Num(num) => Ok(Value::from(*num as i32)),
        }
    }

    /// Dereferences a pointer value, loading its content if it's a scalar pointer.
    fn ptr_deref(&mut self, op: Value) -> Value {
        match op.dtype() {
            Dtype::Pointer { length, .. } if *length == 0 => {
                if op.is_addressable() {
                    let val = self.new_int_reg();
                    self.emit_load(val.clone(), op);
                    return val;
                }
            }
            Dtype::I32 => {
                if let Value::Global(_) = &op {
                    let val = self.new_int_reg();
                    self.emit_load(val.clone(), op);
                    return val;
                }
            }
            _ => {}
        }
        op
    }
}

// =============================================================================
// Boolean Expression Handlers
// =============================================================================

impl<'ir> FunctionGenerator<'ir> {
    /// Evaluates a boolean expression and returns its value as an i32 (0 or 1).
    fn handle_bool_expr_as_value(&mut self, expr: &ast::BoolExpr) -> Result<Value, Error> {
        let true_label = self.new_block_label();
        let false_label = self.new_block_label();
        let after_label = self.new_block_label();

        let bool_evaluated = self.new_int_ptr_reg(0);
        self.emit_alloca(bool_evaluated.clone());

        self.handle_bool_expr_as_branch(expr, true_label.clone(), false_label.clone())?;
        self.emit_bool_materialization(
            true_label,
            false_label,
            after_label,
            bool_evaluated.clone(),
        );

        let loaded = self.new_int_reg();
        self.emit_load(loaded.clone(), bool_evaluated);

        Ok(loaded)
    }

    /// Evaluates a boolean expression and branches to true_label or false_label.
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

    /// Emits code to materialize a boolean value after branch evaluation.
    fn emit_bool_materialization(
        &mut self,
        true_label: BlockLabel,
        false_label: BlockLabel,
        after_label: BlockLabel,
        bool_ptr: Value,
    ) {
        self.emit_label(true_label);
        self.emit_store(Value::from(1), bool_ptr.clone());
        self.emit_jump(after_label.clone());

        self.emit_label(false_label);
        self.emit_store(Value::from(0), bool_ptr);
        self.emit_jump(after_label.clone());

        self.emit_label(after_label);
    }

    /// Handles a boolean binary operator expression (AND/OR) with short-circuit evaluation.
    fn handle_bool_biop_expr(
        &mut self,
        expr: &ast::BoolBiOpExpr,
        true_label: BlockLabel,
        false_label: BlockLabel,
    ) -> Result<(), Error> {
        let eval_right_label = self.new_block_label();
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

    /// Converts a boolean value (i32) to a condition (i1).
    fn emit_bool_to_condition(&mut self, val: Value) -> Value {
        let cond = self.new_int_reg();
        self.emit_cmp(ast::ComOp::Ne, val, Value::from(0), cond.clone());
        cond
    }

    /// Handles a boolean unit expression.
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
                // NOT operator: swap true and false labels
                self.handle_bool_unit(&expr.cond, false_label, true_label)
            }
        }
    }
}
