use crate::ast;
use crate::common::Translate;
use crate::ir;
use std::rc::Rc;

impl Translate<ast::Program> for ir::Generator {
    type Target = ir::Program;
    type Error = ir::Error;

    fn translate(&mut self, prog: &ast::Program) -> Result<Self::Target, Self::Error> {
        for elem in prog.elements.iter() {
            use ast::ProgramElementInner::*;
            match &elem.inner {
                VarDeclStmt(stmt) => {
                    self.handle_global_var_decl_stmt(stmt)?;
                }
                StructDef(_) => {
                    // handle_struct_def(struct_def, store);
                    todo!()
                }
                FnDeclStmt(fn_decl) => {
                    // handle_fn_decl(fn_decl, store);
                }
                FnDef(fn_def) => {
                    // handle_fn_def(fn_def, store);
                }
                _ => {
                    panic!("[Error] Unsupported program element: {:?}", elem);
                }
            }
        }
        Ok(ir::Program {})
    }
}

impl ir::Generator {
    fn handle_global_var_decl_stmt(
        &mut self,
        stmt: &Box<ast::VarDeclStmt>,
    ) -> Result<(), ir::Error> {
        let inner_stmt = &stmt.inner;
        let id = inner_stmt.identifier();
        let name = ir::BlockLabel::from_str(id);

        let base_dtype = match inner_stmt.dtype().as_ref() {
            Some(ast::Dtype {
                inner: ast::DtypeInner::Composite(name),
                ..
            }) => ir::Dtype::Struct {
                name: name.to_string(),
                is_const: false,
            },
            _ => ir::Dtype::I32 { is_const: false },
        };

        // If the statement declares an array or pointer
        let (extended_dtype, initializers) = match inner_stmt {
            ast::VarDeclStmtInner::Decl(decl) => {
                let dtype = match &decl.inner {
                    ast::VarDeclInner::Array(array_decl) => ir::Dtype::Pointer {
                        inner: Box::new(base_dtype),
                        is_const: false,
                        length: array_decl.len,
                    },
                    ast::VarDeclInner::Scalar(_) => base_dtype,
                };
                (dtype, None)
            }

            ast::VarDeclStmtInner::Def(def) => {
                if let ir::Dtype::Struct { .. } = &base_dtype {
                    return Err(ir::Error::StructInitialization);
                }

                match &def.inner {
                    ast::VarDefInner::Array(array_def) => {
                        let initializers = array_def
                            .vals
                            .iter()
                            .map(|val| self.handle_right_val_first(val))
                            .collect();

                        let dtype = ir::Dtype::Pointer {
                            inner: Box::new(base_dtype),
                            is_const: false,
                            length: array_def.len,
                        };
                        (dtype, Some(initializers))
                    }

                    ast::VarDefInner::Scalar(scalar) => {
                        let value = self.handle_right_val_first(scalar.val.as_ref());
                        (base_dtype, Some(vec![value]))
                    }
                }
            }
        };

        let definition = ir::VarDef {
            inner: Rc::new(ir::Operand::Global(Box::new(ir::GlobalVar {
                dtype: extended_dtype,
                name,
            }))),
            initializers,
        };

        self.global_variables.insert(id.clone(), definition);

        Ok(())
    }

    fn handle_right_val_first(&mut self, r: &ast::RightVal) -> i32 {
        match &r.inner {
            ast::RightValInner::ArithExpr(expr) => self.handle_arith_expr_first(&expr),
            ast::RightValInner::BoolExpr(expr) => self.handle_bool_expr_first(&expr),
        }
    }

    fn handle_arith_expr_first(&mut self, expr: &ast::ArithExpr) -> i32 {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => self.handle_arith_biop_expr_first(&expr),
            ast::ArithExprInner::ExprUnit(unit) => self.handle_expr_unit_first(&unit),
        }
    }

    fn handle_bool_expr_first(&mut self, expr: &ast::BoolExpr) -> i32 {
        match &expr.inner {
            ast::BoolExprInner::BoolBiOpExpr(expr) => self.handle_bool_biop_expr_first(&expr),
            ast::BoolExprInner::BoolUnit(unit) => self.handle_bool_unit_first(&unit),
        }
    }

    fn handle_arith_biop_expr_first(&mut self, expr: &ast::ArithBiOpExpr) -> i32 {
        let left = self.handle_arith_expr_first(&expr.left);
        let right = self.handle_arith_expr_first(&expr.right);
        match &expr.op {
            ast::ArithBiOp::Add => left + right,
            ast::ArithBiOp::Sub => left - right,
            ast::ArithBiOp::Mul => left * right,
            ast::ArithBiOp::Div => left / right,
        }
    }

    fn handle_expr_unit_first(&mut self, expr: &ast::ExprUnit) -> i32 {
        match &expr.inner {
            ast::ExprUnitInner::Num(num) => *num,
            ast::ExprUnitInner::ArithExpr(expr) => self.handle_arith_expr_first(&expr),
            ast::ExprUnitInner::ArithUExpr(expr) => self.handle_arith_uexpr_first(&expr),
            _ => panic!("[Error] Not supported expr unit."),
        }
    }

    fn handle_bool_biop_expr_first(&mut self, expr: &ast::BoolBiOpExpr) -> i32 {
        let left = self.handle_bool_expr_first(&expr.left) != 0;
        let right = self.handle_bool_expr_first(&expr.right) != 0;
        if expr.op == ast::BoolBiOp::And {
            (left && right) as i32
        } else {
            (left || right) as i32
        }
    }

    fn handle_bool_unit_first(&mut self, unit: &ast::BoolUnit) -> i32 {
        match &unit.inner {
            ast::BoolUnitInner::ComExpr(expr) => self.handle_com_op_expr(&expr),
            ast::BoolUnitInner::BoolExpr(expr) => self.handle_bool_expr_first(&expr),
            ast::BoolUnitInner::BoolUOpExpr(expr) => self.handle_bool_uop_expr(&expr),
        }
    }

    fn handle_arith_uexpr_first(&mut self, u: &ast::ArithUExpr) -> i32 {
        if u.op == ast::ArithUOp::Neg {
            -self.handle_expr_unit_first(&u.expr)
        } else {
            0
        }
    }

    fn handle_com_op_expr(&mut self, expr: &ast::ComExpr) -> i32 {
        let left = self.handle_expr_unit(&expr.left);
        let right = self.handle_expr_unit(&expr.right);
        let _ = self.ptr_deref(left).as_ref();
        let _ = self.ptr_deref(right).as_ref();
        return 0;
    }

    fn handle_expr_unit(&mut self, unit: &ast::ExprUnit) -> Rc<ir::Operand> {
        match &unit.inner {
            ast::ExprUnitInner::Num(num) => Rc::new(ir::Operand::Interger(*num)),
            ast::ExprUnitInner::Id(id) => {
                if let Some(def) = self.local_vars.get(id) {
                    Rc::clone(&def.inner)
                } else if let Some(def) = self.global_variables.get(id) {
                    Rc::clone(&def.inner)
                } else {
                    panic!("[Error] {} undefined.", id);
                }
            }
            ast::ExprUnitInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::ExprUnitInner::FnCall(fn_call) => {
                let name = fn_call.name.clone();
                let res = if let Some(_) = self.ret_types.get(&name) {
                    match self.ret_types[&name].ret_type {
                        ir::RetType::Int => ir::Operand::Local(Box::new(ir::LocalVar::create_int(
                            self.get_next_vreg_index(),
                        ))),
                        ir::RetType::Struct => {
                            let type_name = self.ret_types[&name].struct_name.clone();
                            ir::Operand::Local(Box::new(ir::LocalVar::create_struct(
                                self.get_next_vreg_index(),
                                type_name,
                            )))
                        }
                        ir::RetType::Void => {
                            panic!("[Error] invalid expr unit");
                        }
                    }
                } else {
                    panic!("[Error] {} undefined.", name);
                };
                let res_op = Rc::new(res);

                let mut args: Vec<Rc<ir::Operand>> = Vec::new();
                for arg in fn_call.vals.as_ref().unwrap().iter() {
                    let rval = self.handle_right_val(&arg);
                    args.push(self.ptr_deref(rval));
                }
                self.emit_irs
                    .push(ir::stmt::Stmt::as_call(name, Rc::clone(&res_op), args));

                res_op
            }
            ast::ExprUnitInner::ArrayExpr(expr) => self.handle_array_expr(&expr),
            ast::ExprUnitInner::MemberExpr(expr) => self.handle_member_expr(&expr),
            ast::ExprUnitInner::ArithUExpr(expr) => self.handle_arith_uexpr(&expr),
        }
    }

    fn handle_arith_expr(&mut self, expr: &ast::ArithExpr) -> Rc<ir::Operand> {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => self.handle_arith_biop_expr(&expr),
            ast::ArithExprInner::ExprUnit(unit) => self.handle_expr_unit(&unit),
        }
    }

    fn handle_right_val(&mut self, val: &ast::RightVal) -> Rc<ir::Operand> {
        match &val.inner {
            ast::RightValInner::ArithExpr(expr) => self.handle_arith_expr(expr),
            ast::RightValInner::BoolExpr(expr) => {
                let true_label = ir::BlockLabel::from_index(self.get_next_label_index());
                let false_label = ir::BlockLabel::from_index(self.get_next_label_index());
                let after_label = ir::BlockLabel::from_index(self.get_next_label_index());

                let bool_evaluated = ir::LocalVar::create_int_ptr(self.get_next_vreg_index(), 0);

                let alloca_dst = Rc::new(ir::Operand::Local(Box::new(bool_evaluated)));
                self.emit_irs
                    .push(ir::stmt::Stmt::as_alloca(Rc::clone(&alloca_dst)));
                self.handle_bool_expr(expr, Some(true_label.clone()), Some(false_label.clone()));

                self.produce_bool_val(
                    true_label.clone(),
                    false_label.clone(),
                    after_label,
                    Rc::clone(&alloca_dst),
                );

                let bool_val = ir::LocalVar::create_int(self.get_next_vreg_index());
                let dst = Rc::new(ir::Operand::Local(Box::new(bool_val)));
                let ptr = Rc::clone(&alloca_dst);
                self.emit_irs
                    .push(ir::stmt::Stmt::as_load(Rc::clone(&dst), ptr));

                dst
            }
        }
    }

    fn handle_bool_uop_expr(&mut self, expr: &ast::BoolUOpExpr) -> i32 {
        if expr.op == ast::BoolUOp::Not {
            (self.handle_bool_unit_first(&expr.cond) == 0) as i32
        } else {
            0
        }
    }

    fn handle_array_expr(&mut self, expr: &ast::ArrayExpr) -> Rc<ir::Operand> {
        let arr = self.handle_left_val(&expr.arr);
        let target = match arr.as_ref() {
            ir::Operand::Interger(_) => panic!("[Error] Invalid array expression"),
            ir::Operand::Local(inner) | ir::Operand::Global(inner) => {
                if let ir::Dtype::Pointer { .. } = inner.dtype() {
                    Rc::new(ir::Operand::Local(Box::new(ir::LocalVar::create_int_ptr(
                        self.get_next_vreg_index(),
                        0,
                    ))))
                } else {
                    let id = match inner.dtype() {
                        ir::Dtype::Struct { name, .. } => name,
                        _ => panic!("[Error]"),
                    };

                    Rc::new(ir::Operand::Local(Box::new(
                        ir::LocalVar::create_struct_ptr(self.get_next_vreg_index(), 0, id.clone()),
                    )))
                }
            }
        };

        let index = self.handle_index_expr(expr.idx.as_ref());
        self.emit_irs
            .push(ir::stmt::Stmt::as_gep(Rc::clone(&target), arr, index));

        target
    }

    fn handle_member_expr(&mut self, expr: &ast::MemberExpr) -> Rc<ir::Operand> {
        let s = self.handle_left_val(&expr.struct_id);
        let type_name = match s.as_ref() {
            ir::Operand::Interger(_) => panic!("[Error]: Invalid Left value."),
            ir::Operand::Local(inner) | ir::Operand::Global(inner) => {
                if let ir::Dtype::Struct { name, .. } = inner.dtype() {
                    name
                } else {
                    panic!("[Error] TODO")
                }
            }
        }
        .clone();

        let member = self
            .struct_props
            .get(&type_name)
            .unwrap()
            .member_props
            .get(&expr.member_id)
            .unwrap();

        let target = match member.def.inner.as_ref() {
            ir::Operand::Interger(_) => panic!("Invalid member"),
            ir::Operand::Local(inner) | ir::Operand::Global(inner) => match inner.dtype() {
                ir::Dtype::I32 { .. } => Rc::new(ir::Operand::Local(Box::new(
                    ir::LocalVar::create_int_ptr(self.get_next_vreg_index(), 0),
                ))),
                ir::Dtype::Pointer { inner, length, .. } => match inner.as_ref() {
                    ir::Dtype::I32 { .. } => Rc::new(ir::Operand::Local(Box::new(
                        ir::LocalVar::create_int_ptr(self.get_next_vreg_index(), *length),
                    ))),
                    ir::Dtype::Struct { name, .. } => Rc::new(ir::Operand::Local(Box::new(
                        ir::LocalVar::create_struct_ptr(
                            self.get_next_vreg_index(),
                            *length,
                            name.clone(),
                        ),
                    ))),
                    _ => todo!("not supported"),
                },
                ir::Dtype::Struct { name, .. } => Rc::new(ir::Operand::Local(Box::new(
                    ir::LocalVar::create_struct_ptr(self.get_next_vreg_index(), 0, name.clone()),
                ))),
                _ => todo!("not supported"),
            },
        };

        self.emit_irs.push(ir::stmt::Stmt::as_gep(
            Rc::clone(&target),
            s,
            Rc::new(ir::Operand::Interger(member.offset)),
        ));

        target
    }

    fn handle_left_val(&mut self, val: &ast::LeftVal) -> Rc<ir::Operand> {
        match &val.inner {
            ast::LeftValInner::Id(id) => {
                let lval;
                if self.local_vars.get(id).is_some() {
                    lval = Rc::clone(&self.local_vars.get(id).unwrap().inner)
                } else if self.global_variables.get(id).is_some() {
                    lval = Rc::clone(&self.global_variables.get(id).unwrap().inner)
                } else {
                    panic!("[Error] {} not found.", &id);
                }
                lval
            }
            ast::LeftValInner::ArrayExpr(expr) => self.handle_array_expr(expr),
            ast::LeftValInner::MemberExpr(expr) => self.handle_member_expr(expr),
        }
    }

    fn handle_arith_uexpr(&mut self, expr: &ast::ArithUExpr) -> Rc<ir::Operand> {
        let expr = self.handle_expr_unit(expr.expr.as_ref());
        let val = self.ptr_deref(expr);
        let res = ir::LocalVar::create_int(self.get_next_vreg_index());
        let res_op = Rc::new(ir::Operand::Local(Box::new(res)));
        self.emit_irs.push(ir::stmt::Stmt::as_biop(
            ir::BiOpKind::Minus,
            Rc::new(ir::Operand::Interger(0)),
            val,
            Rc::clone(&res_op),
        ));

        res_op
    }

    fn handle_arith_biop_expr(&mut self, expr: &ast::ArithBiOpExpr) -> Rc<ir::Operand> {
        let left = self.handle_arith_expr(&expr.left);
        let right = self.handle_arith_expr(&expr.right);
        let dst = Rc::new(ir::Operand::Local(Box::new(ir::LocalVar::create_int(
            self.get_next_vreg_index(),
        ))));

        let kind = match expr.op {
            ast::ArithBiOp::Add => ir::BiOpKind::Plus,
            ast::ArithBiOp::Sub => ir::BiOpKind::Minus,
            ast::ArithBiOp::Mul => ir::BiOpKind::Mul,
            ast::ArithBiOp::Div => ir::BiOpKind::Div,
        };

        let biop_stmt = ir::stmt::Stmt::as_biop(kind, left, right, Rc::clone(&dst));
        self.emit_irs.push(biop_stmt);

        dst
    }

    fn handle_bool_expr(
        &mut self,
        expr: &ast::BoolExpr,
        true_label: Option<ir::BlockLabel>,
        false_label: Option<ir::BlockLabel>,
    ) -> Option<Rc<ir::Operand>> {
        if true_label.is_none() && false_label.is_none() {
            let true_label = ir::BlockLabel::from_index(self.get_next_label_index());
            let false_label = ir::BlockLabel::from_index(self.get_next_label_index());
            let after_label = ir::BlockLabel::from_index(self.get_next_label_index());

            let bool_evaluated = ir::LocalVar::create_int_ptr(self.get_next_vreg_index(), 0);

            let alloca_dst = Rc::new(ir::Operand::Local(Box::new(bool_evaluated)));
            self.emit_irs
                .push(ir::stmt::Stmt::as_alloca(Rc::clone(&alloca_dst)));

            match &expr.inner {
                ast::BoolExprInner::BoolBiOpExpr(expr) => self.handle_bool_biop_expr(
                    expr,
                    Some(true_label.clone()),
                    Some(false_label.clone()),
                ),
                ast::BoolExprInner::BoolUnit(unit) => {
                    self.handle_bool_unit(unit, Some(true_label.clone()), Some(false_label.clone()))
                }
            }

            self.produce_bool_val(true_label, false_label, after_label, Rc::clone(&alloca_dst));

            let truncated = ir::LocalVar::create_int(self.get_next_vreg_index());
            let bool_val = ir::LocalVar::create_int(self.get_next_vreg_index());

            let dst = Rc::new(ir::Operand::Local(Box::new(bool_val)));
            let ptr = Rc::clone(&alloca_dst);
            let retval = Rc::new(ir::Operand::Local(Box::new(truncated)));

            self.emit_irs
                .push(ir::stmt::Stmt::as_load(Rc::clone(&dst), Rc::clone(&ptr)));

            self.emit_irs.push(ir::stmt::Stmt::as_cmp(
                ir::RelOpKind::Ne,
                Rc::clone(&dst),
                Rc::new(ir::Operand::Interger(0)),
                Rc::clone(&retval),
            ));

            return Some(retval);
        } else if true_label.is_none() || false_label.is_none() {
            panic!("[Error] one of the jump target is null.");
        }

        match &expr.inner {
            ast::BoolExprInner::BoolBiOpExpr(expr) => {
                self.handle_bool_biop_expr(expr, true_label, false_label)
            }
            ast::BoolExprInner::BoolUnit(unit) => {
                self.handle_bool_unit(unit, true_label, false_label)
            }
        }

        return None;
    }

    fn produce_bool_val(
        &mut self,
        true_label: ir::BlockLabel,
        false_label: ir::BlockLabel,
        after_label: ir::BlockLabel,
        bool_evaluated: Rc<ir::Operand>,
    ) {
        let store_src_true = Rc::new(ir::Operand::Interger(1));
        let store_src_false = Rc::new(ir::Operand::Interger(0));
        let store_ptr = Rc::clone(&bool_evaluated);

        self.emit_irs.push(ir::stmt::Stmt::as_label(true_label));
        self.emit_irs.push(ir::stmt::Stmt::as_store(
            store_src_true,
            Rc::clone(&store_ptr),
        ));
        self.emit_irs
            .push(ir::stmt::Stmt::as_jump(after_label.clone()));

        self.emit_irs.push(ir::stmt::Stmt::as_label(false_label));
        self.emit_irs.push(ir::stmt::Stmt::as_store(
            store_src_false,
            Rc::clone(&store_ptr),
        ));

        self.emit_irs.push(ir::stmt::Stmt::as_jump(after_label));
    }

    fn handle_index_expr(&mut self, expr: &ast::IndexExpr) -> Rc<ir::Operand> {
        match &expr.inner {
            ast::IndexExprInner::Id(id) => {
                let idx = ir::LocalVar::create_int(self.get_next_vreg_index());
                let retval = Rc::new(ir::Operand::Local(Box::new(idx)));
                if self.local_vars.get(id).is_some() {
                    let src = self.local_vars.get(id).unwrap();
                    self.emit_irs.push(ir::stmt::Stmt::as_load(
                        Rc::clone(&retval),
                        Rc::clone(&src.inner),
                    ));
                } else if self.global_variables.get(id).is_some() {
                    let src = self.global_variables.get(id).unwrap();
                    self.emit_irs.push(ir::stmt::Stmt::as_load(
                        Rc::clone(&retval),
                        Rc::clone(&src.inner),
                    ));
                } else {
                    panic!("[Errpr] {} undefined.", id);
                }

                retval
            }
            ast::IndexExprInner::Num(num) => Rc::new(ir::Operand::Interger(*num as i32)),
        }
    }

    fn handle_bool_biop_expr(
        &mut self,
        expr: &ast::BoolBiOpExpr,
        true_label: Option<ir::BlockLabel>,
        false_label: Option<ir::BlockLabel>,
    ) {
        let eval_right_label = ir::BlockLabel::from_index(self.get_next_label_index());
        let lhs = self.handle_bool_expr(&expr.left, None, None);

        let false_label_unwrapped = false_label.unwrap().clone();
        let true_label_unwrapped = true_label.unwrap().clone();

        match &expr.op {
            ir::BoolBiOp::And => {
                self.emit_irs.push(ir::stmt::Stmt::as_cjump(
                    lhs.unwrap(),
                    eval_right_label.clone(),
                    false_label_unwrapped.clone(),
                ));
                self.emit_irs
                    .push(ir::stmt::Stmt::as_label(eval_right_label));

                let rhs = self.handle_bool_expr(&expr.right, None, None);
                self.emit_irs.push(ir::stmt::Stmt::as_cjump(
                    rhs.unwrap(),
                    true_label_unwrapped,
                    false_label_unwrapped,
                ))
            }
            ir::BoolBiOp::Or => {
                self.emit_irs.push(ir::stmt::Stmt::as_cjump(
                    lhs.unwrap(),
                    true_label_unwrapped.clone(),
                    eval_right_label.clone(),
                ));
                self.emit_irs
                    .push(ir::stmt::Stmt::as_label(eval_right_label));

                let rhs = self.handle_bool_expr(&expr.right, None, None);
                self.emit_irs.push(ir::stmt::Stmt::as_cjump(
                    rhs.unwrap(),
                    true_label_unwrapped,
                    false_label_unwrapped,
                ))
            }
        }
    }

    fn handle_bool_unit(
        &mut self,
        unit: &ast::BoolUnit,
        true_label: Option<ir::BlockLabel>,
        false_label: Option<ir::BlockLabel>,
    ) {
        match &unit.inner {
            ast::BoolUnitInner::ComExpr(expr) => {
                let _ = self.handle_com_op_expr(expr);
            }
            ast::BoolUnitInner::BoolExpr(expr) => {
                let _ = self.handle_bool_expr(expr, true_label, false_label);
            }
            ast::BoolUnitInner::BoolUOpExpr(expr) => {
                let _ = self.handle_bool_unit(&expr.cond, false_label, true_label);
            }
        }
    }

    fn ptr_deref(&mut self, op: Rc<ir::Operand>) -> Rc<ir::Operand> {
        match op.as_ref() {
            ir::Operand::Interger(_) => op,
            ir::Operand::Local(inner) | ir::Operand::Global(inner) => {
                if let ir::Dtype::Pointer { length, .. } = inner.dtype() {
                    if *length == 0 {
                        let val = ir::LocalVar::create_int(self.get_next_vreg_index());
                        let dst = Rc::new(ir::Operand::Local(Box::new(val)));
                        let stmt = ir::stmt::Stmt::as_load(Rc::clone(&dst), op);
                        self.emit_irs.push(stmt);

                        return dst;
                    } else {
                        return op;
                    }
                } else if let ir::Dtype::I32 { .. } = inner.dtype() {
                    op
                } else {
                    op
                }
            }
        }
    }
}
