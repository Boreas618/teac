use crate::ast::{self};
use crate::common::Translate;
use crate::ir::{self, Dtype};
use std::rc::Rc;

pub trait BaseDtype {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier>;

    fn base_dtype(&self) -> Dtype {
        match self.type_specifier().as_ref().as_ref().map(|t| &t.inner) {
            Some(ast::TypeSpecifierInner::Composite(name)) => Dtype::Struct {
                name: name.to_string(),
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

impl ast::VarDef {
    fn initializers(&self) -> Vec<i32> {
        match &self.inner {
            ast::VarDefInner::Array(def) => {
                let initializers = def
                    .vals
                    .iter()
                    .map(|val| ir::Generator::handle_right_val_static(val))
                    .collect();

                initializers
            }

            // Global variable should be statically assigned
            ast::VarDefInner::Scalar(scalar) => {
                let value = ir::Generator::handle_right_val_static(&scalar.val);
                vec![value]
            }
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
                name: name.to_string(),
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
                FnDeclStmt(fn_decl) => {
                    self.handle_fn_decl(fn_decl);
                }
                FnDef(fn_def) => {
                    self.handle_fn_def(fn_def);
                }
                StructDef(_) => {
                    todo!();
                }
            }
        }
        Ok(ir::Program {})
    }
}

impl ir::Generator {
    /// Static methods used during IR generation for static evaluation.
    ///
    /// Some parts of the program, such as global variable initializations,
    /// must be evaluated statically rather than at runtime. Also, we expose
    /// these static evaluation functions publicly. This won't be probelmatic,
    /// as they do not produce side effects on the internal state of the IR
    /// generator.
    pub fn handle_right_val_static(r: &ast::RightVal) -> i32 {
        match &r.inner {
            ast::RightValInner::ArithExpr(expr) => Self::handle_arith_expr_static(&expr),
            ast::RightValInner::BoolExpr(expr) => Self::handle_bool_expr_static(&expr),
        }
    }

    pub fn handle_arith_expr_static(expr: &ast::ArithExpr) -> i32 {
        match &expr.inner {
            ast::ArithExprInner::ArithBiOpExpr(expr) => Self::handle_arith_biop_expr_static(&expr),
            ast::ArithExprInner::ExprUnit(unit) => Self::handle_expr_unit_static(&unit),
        }
    }

    pub fn handle_bool_expr_static(expr: &ast::BoolExpr) -> i32 {
        match &expr.inner {
            ast::BoolExprInner::BoolBiOpExpr(expr) => Self::handle_bool_biop_expr_static(&expr),
            ast::BoolExprInner::BoolUnit(unit) => Self::handle_bool_unit_static(&unit),
        }
    }

    pub fn handle_arith_biop_expr_static(expr: &ast::ArithBiOpExpr) -> i32 {
        let left = Self::handle_arith_expr_static(&expr.left);
        let right = Self::handle_arith_expr_static(&expr.right);
        match &expr.op {
            ast::ArithBiOp::Add => left + right,
            ast::ArithBiOp::Sub => left - right,
            ast::ArithBiOp::Mul => left * right,
            ast::ArithBiOp::Div => left / right,
        }
    }

    pub fn handle_expr_unit_static(expr: &ast::ExprUnit) -> i32 {
        match &expr.inner {
            ast::ExprUnitInner::Num(num) => *num,
            ast::ExprUnitInner::ArithExpr(expr) => Self::handle_arith_expr_static(&expr),
            ast::ExprUnitInner::ArithUExpr(expr) => Self::handle_arith_uexpr_static(&expr),
            _ => panic!("[Error] Not supported expr unit."),
        }
    }

    pub fn handle_bool_biop_expr_static(expr: &ast::BoolBiOpExpr) -> i32 {
        let left = Self::handle_bool_expr_static(&expr.left) != 0;
        let right = Self::handle_bool_expr_static(&expr.right) != 0;
        if expr.op == ast::BoolBiOp::And {
            (left && right) as i32
        } else {
            (left || right) as i32
        }
    }

    pub fn handle_bool_unit_static(unit: &ast::BoolUnit) -> i32 {
        match &unit.inner {
            ast::BoolUnitInner::ComExpr(expr) => Self::handle_com_op_expr_static(&expr),
            ast::BoolUnitInner::BoolExpr(expr) => Self::handle_bool_expr_static(&expr),
            ast::BoolUnitInner::BoolUOpExpr(expr) => Self::handle_bool_uop_expr_static(&expr),
        }
    }

    pub fn handle_arith_uexpr_static(u: &ast::ArithUExpr) -> i32 {
        if u.op == ast::ArithUOp::Neg {
            -Self::handle_expr_unit_static(&u.expr)
        } else {
            0
        }
    }

    pub fn handle_com_op_expr_static(expr: &ast::ComExpr) -> i32 {
        let left = Self::handle_expr_unit_static(&expr.left);
        let right = Self::handle_expr_unit_static(&expr.right);
        match expr.op {
            ast::ComOp::Lt => (left < right) as i32,
            ast::ComOp::Eq => (left == right) as i32,
            ast::ComOp::Ge => (left >= right) as i32,
            ast::ComOp::Gt => (left > right) as i32,
            ast::ComOp::Le => (left <= right) as i32,
            ast::ComOp::Ne => (left != right) as i32,
        }
    }

    pub fn handle_bool_uop_expr_static(expr: &ast::BoolUOpExpr) -> i32 {
        if expr.op == ast::BoolUOp::Not {
            (Self::handle_bool_unit_static(&expr.cond) == 0) as i32
        } else {
            0
        }
    }

    fn handle_global_var_decl_stmt(&mut self, stmt: &ast::VarDeclStmt) -> Result<(), ir::Error> {
        let identifier = match stmt.identifier() {
            Some(id) => id,
            None => return Err(ir::Error::SymbolMissing),
        };

        let dtype = ir::Dtype::try_from(stmt)?;
        let initializers = if let ast::VarDeclStmtInner::Def(d) = &stmt.inner {
            Some(d.initializers())
        } else {
            None
        };

        let definition = ir::VarDef {
            inner: Rc::new(ir::Operand::make_global(dtype, identifier.clone())),
            initializers,
        };

        self.definitions
            .insert(identifier, ir::GlobalDef::Variable(definition));

        Ok(())
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
                if let Some(def) = self.local_variables.get(id) {
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
                let res = if let Some(_) = self.return_dtypes.get(&name) {
                    match self.return_dtypes[&name].return_dtype {
                        ir::RetType::Int => ir::Operand::Local(Box::new(ir::LocalVar::create_int(
                            self.get_next_vreg_index(),
                        ))),
                        ir::RetType::Struct => {
                            let type_name = self.return_dtypes[&name].struct_name.clone();
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
                if self.local_variables.get(id).is_some() {
                    lval = Rc::clone(&self.local_variables.get(id).unwrap().inner)
                } else if self.definitions.get(id).is_some() {
                    lval = Rc::clone(&self.definitions.get(id).unwrap().inner)
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
                if self.local_variables.get(id).is_some() {
                    let src = self.local_variables.get(id).unwrap();
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

    fn handle_fn_decl(&mut self, decl: &ast::FnDecl) -> Result<(), ir::Error> {
        let identifier = decl.identifier.clone();

        let mut args: Vec<ir::VarDef> = Vec::new();
        if let Some(params) = &decl.param_decl {
            for decl in params.decls.iter() {
                let identifier = decl.identifier();
                let dtype = ir::Dtype::try_from(decl)?;
                let index = self.get_next_vreg_index();

                args.push(ir::VarDef {
                    initializers: None,
                    inner: Rc::new(ir::Operand::Local(Box::new(ir::LocalVar {
                        dtype,
                        identifier,
                        index,
                    }))),
                });
            }
        }

        self.definitions.insert(
            identifier.clone(),
            ir::GlobalDef::Func(ir::FnDecl {
                identifier,
                args: args,
                return_dtype: match decl.return_dtype.as_ref() {
                    Some(type_specifier) => type_specifier.into(),
                    None => ir::Dtype::Void,
                },
            }),
        );

        Ok(())
    }

    fn handle_fn_def(&mut self, stmt: &ast::FnDef) -> Result<(), ir::Error> {
        let identifier = stmt.fn_decl.identifier.clone();
        match self.definitions.get(&identifier) {
            None => self.handle_fn_decl(&stmt.fn_decl)?,

            Some(decl) => match decl {
                ir::GlobalDef::Struct(_) | ir::GlobalDef::Variable(_) => {
                    return Err(ir::Error::RedefinedSymbol {
                        symbol: identifier.clone(),
                    })
                }
                ir::GlobalDef::Func(f) => {
                    if f != stmt.fn_decl.as_ref() {
                        return Err(ir::Error::DeclDefMismatch {
                            symbol: identifier.clone(),
                        });
                    }
                }
            },
        }

        Ok(())
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
