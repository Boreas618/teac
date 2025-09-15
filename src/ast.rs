use std::{
    fmt::{Display, Formatter, Error},
    ops::Deref, rc::Rc
};
use crate::util::ast_tree::*;

type Pos = usize;

#[derive(Debug, Clone)]
pub enum BuiltIn {
    Int,
}

#[derive(Debug, Clone)]
pub enum TypeSpecifierInner {
    BuiltIn(Box<BuiltIn>),
    Composite(Box<String>),
}

#[derive(Debug, Clone)]
pub struct TypeSepcifier {
    pub pos: Pos,
    pub inner: TypeSpecifierInner,
}

#[derive(Debug, Clone)]
pub struct RightValList {
    pub head: Box<RightVal>,
    pub next: Option<Box<RightValList>>,
}

impl RightValList {
    pub fn iter(&self) -> RightValListIterator<'_> {
        RightValListIterator {
            current: Some(self),
        }
    }
}

pub struct RightValListIterator<'a> {
    current: Option<&'a RightValList>,
}

impl<'a> Iterator for RightValListIterator<'a> {
    type Item = &'a RightVal;

    fn next(&mut self) -> Option<Self::Item> {
        self.current.take().map(|node| {
            self.current = node.next.as_ref().map(|next_node| &**next_node);
            &*node.head
        })
    }
}

#[derive(Debug, Clone)]
pub struct FnCall {
    pub pos: Pos,
    pub name: String,
    pub vals: Option<Box<RightValList>>,
}

#[derive(Debug, Clone)]
pub enum IndexExprInner {
    Num(usize),
    Id(String),
}

#[derive(Debug, Clone)]
pub struct IndexExpr {
    pub pos: Pos,
    pub inner: IndexExprInner,
}

#[derive(Debug, Clone)]
pub struct ArrayExpr {
    pub pos: Pos,
    pub arr: Box<LeftVal>,
    pub idx: Box<IndexExpr>,
}

#[derive(Debug, Clone)]
pub struct MemberExpr {
    pub pos: Pos,
    pub struct_id: Box<LeftVal>,
    pub member_id: String,
}

#[derive(Debug, Clone)]
pub enum ExprUnitInner {
    Num(i32),
    Id(String),
    ArithExpr(Box<ArithExpr>),
    FnCall(Box<FnCall>),
    ArrayExpr(Box<ArrayExpr>),
    MemberExpr(Box<MemberExpr>),
    ArithUExpr(Box<ArithUExpr>),
}

#[derive(Debug, Clone)]
pub struct ExprUnit {
    pub pos: Pos,
    pub inner: ExprUnitInner,
}

#[derive(Debug, PartialEq, Clone)]
pub enum ArithUOp {
    Neg,
}

#[derive(Debug, Clone)]
pub enum ArithBiOp {
    Add,
    Sub,
    Mul,
    Div,
}

#[derive(Debug, PartialEq, Clone)]
pub enum BoolUOp {
    Not,
}

#[derive(Debug, PartialEq, Clone)]
pub enum BoolBiOp {
    And,
    Or,
}

#[derive(Debug, Clone)]
pub enum ComOp {
    Lt,
    Le,
    Gt,
    Ge,
    Eq,
    Ne,
}

#[derive(Debug, Clone)]
pub struct ArithBiOpExpr {
    pub pos: Pos,
    pub op: ArithBiOp,
    pub left: Box<ArithExpr>,
    pub right: Box<ArithExpr>,
}

#[derive(Debug, Clone)]
pub struct ArithUExpr {
    pub pos: Pos,
    pub op: ArithUOp,
    pub expr: Box<ExprUnit>,
}

#[derive(Debug, Clone)]
pub enum ArithExprInner {
    ArithBiOpExpr(Box<ArithBiOpExpr>),
    ExprUnit(Box<ExprUnit>),
}

#[derive(Debug, Clone)]
pub struct ArithExpr {
    pub pos: Pos,
    pub inner: ArithExprInner,
}

#[derive(Debug, Clone)]
pub struct BoolBiOpExpr {
    pub pos: Pos,
    pub op: BoolBiOp,
    pub left: Box<BoolExpr>,
    pub right: Box<BoolExpr>,
}

#[derive(Debug, Clone)]
pub struct BoolUOpExpr {
    pub pos: Pos,
    pub op: BoolUOp,
    pub cond: Box<BoolUnit>,
}

#[derive(Debug, Clone)]
pub enum BoolExprInner {
    BoolBiOpExpr(Box<BoolBiOpExpr>),
    BoolUnit(Box<BoolUnit>),
}

#[derive(Debug, Clone)]
pub struct BoolExpr {
    pub pos: Pos,
    pub inner: BoolExprInner,
}

#[derive(Debug, Clone)]
pub struct ComExpr {
    pub pos: Pos,
    pub op: ComOp,
    pub left: Box<ExprUnit>,
    pub right: Box<ExprUnit>,
}

#[derive(Debug, Clone)]
pub enum BoolUnitInner {
    ComExpr(Box<ComExpr>),
    BoolExpr(Box<BoolExpr>),
    BoolUOpExpr(Box<BoolUOpExpr>),
}

#[derive(Debug, Clone)]
pub struct BoolUnit {
    pub pos: Pos,
    pub inner: BoolUnitInner,
}

#[derive(Debug, Clone)]
pub enum RightValInner {
    ArithExpr(Box<ArithExpr>),
    BoolExpr(Box<BoolExpr>),
}

#[derive(Debug, Clone)]
pub struct RightVal {
    pub pos: Pos,
    pub inner: RightValInner,
}

#[derive(Debug, Clone)]
pub enum LeftValInner {
    Id(String),
    ArrayExpr(Box<ArrayExpr>),
    MemberExpr(Box<MemberExpr>),
}

#[derive(Debug, Clone)]
pub struct LeftVal {
    pub pos: Pos,
    pub inner: LeftValInner,
}

#[derive(Debug, Clone)]
pub struct AssignmentStmt {
    pub pos: Pos,
    pub left_val: Box<LeftVal>,
    pub right_val: Box<RightVal>,
}

#[derive(Debug, Clone)]
pub struct VarDeclScalar {
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct VarDeclArray {
    pub pos: Pos,
    pub len: usize,
}

#[derive(Debug, Clone)]
pub enum VarDeclInner {
    Scalar(Box<VarDeclScalar>),
    Array(Box<VarDeclArray>),
}

#[derive(Debug, Clone)]
pub struct VarDecl {
    pub pos: Pos,
    pub identifier: String,
    pub type_specifier: Rc<Option<TypeSepcifier>>,
    pub inner: VarDeclInner,
}

#[derive(Debug, Clone)]
pub enum VarDefInner {
    Scalar(Box<VarDefScalar>),
    Array(Box<VarDefArray>),
}

#[derive(Debug, Clone)]
pub struct VarDef {
    pub pos: Pos,
    pub identifier: String,
    pub type_specifier: Rc<Option<TypeSepcifier>>,
    pub inner: VarDefInner,
}

#[derive(Debug, Clone)]
pub struct VarDefScalar {
    pub pos: Pos,
    pub val: Box<RightVal>,
}

#[derive(Debug, Clone)]
pub struct VarDefArray {
    pub pos: Pos,
    pub len: usize,
    pub vals: Box<RightValList>,
}

#[derive(Debug, Clone)]
pub enum VarDeclStmtInner {
    Decl(Box<VarDecl>),
    Def(Box<VarDef>),
}

#[derive(Debug, Clone)]
pub struct VarDeclStmt {
    pub pos: Pos,
    pub inner: VarDeclStmtInner,
}

#[derive(Debug, Clone)]
pub struct VarDeclList {
    pub head: Box<VarDecl>,
    pub next: Option<Box<VarDeclList>>,
}

pub struct VarDeclListIterator<'a> {
    current: Option<&'a VarDeclList>,
}

impl<'a> Iterator for VarDeclListIterator<'a> {
    type Item = &'a VarDecl;

    fn next(&mut self) -> Option<Self::Item> {
        self.current.take().map(|node| {
            self.current = node.next.as_ref().map(|next_node| &**next_node);
            &*node.head
        })
    }
}

impl VarDeclList {
    pub fn iter(&self) -> VarDeclListIterator<'_> {
        VarDeclListIterator {
            current: Some(self),
        }
    }
}

#[derive(Debug, Clone)]
pub struct StructDef {
    pub pos: Pos,
    pub identifier: String,
    pub decls: Box<VarDeclList>,
}

#[derive(Debug, Clone)]
pub struct FnDecl {
    pub pos: Pos,
    pub identifier: String,
    pub param_decl: Option<Box<ParamDecl>>,
    pub return_dtype: Rc<Option<TypeSepcifier>>,
}

#[derive(Debug, Clone)]
pub struct ParamDecl {
    pub decls: Box<VarDeclList>,
}

#[derive(Debug, Clone)]
pub struct FnDef {
    pub pos: Pos,
    pub fn_decl: Box<FnDecl>,
    pub stmts: Box<CodeBlockStmtList>,
}

#[derive(Debug, Clone)]
pub struct IfStmt {
    pub pos: Pos,
    pub bool_unit: Box<BoolUnit>,
    pub if_stmts: Box<CodeBlockStmtList>,
    pub else_stmts: Option<Box<CodeBlockStmtList>>,
}

#[derive(Debug, Clone)]
pub struct WhileStmt {
    pub pos: Pos,
    pub bool_unit: Box<BoolUnit>,
    pub stmts: Box<CodeBlockStmtList>,
}

#[derive(Debug, Clone)]
pub struct CallStmt {
    pub pos: Pos,
    pub fn_call: Box<FnCall>,
}

#[derive(Debug, Clone)]
pub struct ReturnStmt {
    pub pos: Pos,
    pub val: Option<Box<RightVal>>,
}

#[derive(Debug, Clone)]
pub struct ContinueStmt {
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct BreakStmt {
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct NullStmt {
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub enum CodeBlockStmtInner {
    VarDecl(Box<VarDeclStmt>),
    Assignment(Box<AssignmentStmt>),
    Call(Box<CallStmt>),
    If(Box<IfStmt>),
    While(Box<WhileStmt>),
    Return(Box<ReturnStmt>),
    Continue(Box<ContinueStmt>),
    Break(Box<BreakStmt>),
    Null(Box<NullStmt>),
}

#[derive(Debug, Clone)]
pub struct CodeBlockStmt {
    pub pos: Pos,
    pub inner: CodeBlockStmtInner,
}

#[derive(Debug, Clone)]
pub struct CodeBlockStmtList {
    pub head: Box<CodeBlockStmt>,
    pub next: Option<Box<CodeBlockStmtList>>,
}

impl CodeBlockStmtList {
    pub fn iter(&self) -> CodeBlockStmtListIterator<'_> {
        CodeBlockStmtListIterator {
            current: Some(self),
        }
    }
}

pub struct CodeBlockStmtListIterator<'a> {
    current: Option<&'a CodeBlockStmtList>,
}

impl<'a> Iterator for CodeBlockStmtListIterator<'a> {
    type Item = &'a CodeBlockStmt;

    fn next(&mut self) -> Option<Self::Item> {
        self.current.take().map(|node| {
            self.current = node.next.as_ref().map(|next_node| &**next_node);
            &*node.head
        })
    }
}

#[derive(Debug, Clone)]
pub struct FnDeclStmt {
    pub pos: Pos,
    pub fn_decl: Box<FnDecl>,
}

impl Deref for FnDeclStmt {
    type Target = FnDecl;

    fn deref(&self) -> &Self::Target {
        &self.fn_decl
    }
}

#[derive(Debug, Clone)]
pub struct Program {
    pub elements: Box<ProgramElementList>,
}

#[derive(Debug, Clone)]
pub struct ProgramElementList {
    pub element: Box<ProgramElement>,
    pub next: Option<Box<ProgramElementList>>,
}

impl ProgramElementList {
    pub fn iter(&self) -> ProgramElementListIterator<'_> {
        ProgramElementListIterator {
            current: Some(self),
        }
    }
}

pub struct ProgramElementListIterator<'a> {
    current: Option<&'a ProgramElementList>,
}

impl<'a> Iterator for ProgramElementListIterator<'a> {
    type Item = &'a ProgramElement;

    fn next(&mut self) -> Option<Self::Item> {
        self.current.take().map(|node| {
            self.current = node.next.as_ref().map(|next_node| &**next_node);
            &*node.element
        })
    }
}

#[derive(Debug, Clone)]
pub enum ProgramElementInner {
    VarDeclStmt(Box<VarDeclStmt>),
    StructDef(Box<StructDef>),
    FnDeclStmt(Box<FnDeclStmt>),
    FnDef(Box<FnDef>),
}

#[derive(Debug, Clone)]
pub struct ProgramElement {
    pub inner: ProgramElementInner,
}

impl Display for BuiltIn {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            BuiltIn::Int => write!(f, "int"),
        }
    }
}

impl Display for TypeSpecifierInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            TypeSpecifierInner::BuiltIn(b) => write!(f, "{}", b),
            TypeSpecifierInner::Composite(name) => write!(f, "{}", name),
        }
    }
}

impl Display for TypeSepcifier {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}@{}", self.inner, self.pos)
    }
}

impl Display for ArithBiOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let op = match self {
            ArithBiOp::Add => "+",
            ArithBiOp::Sub => "-",
            ArithBiOp::Mul => "*",
            ArithBiOp::Div => "/",
        };
        write!(f, "{}", op)
    }
}

impl Display for ArithBiOpExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "({} {} {})", self.left, self.op, self.right)
    }
}

impl Display for ArithUOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            ArithUOp::Neg => write!(f, "-"),
        }
    }
}

impl Display for ArithUExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "({}{})", self.op, self.expr)
    }
}

impl Display for ArithExprInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            ArithExprInner::ArithBiOpExpr(expr) => write!(f, "{}", expr),
            ArithExprInner::ExprUnit(unit) => write!(f, "{}", unit),
        }
    }
}

impl Display for ArithExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

impl Display for BoolUOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            BoolUOp::Not => write!(f, "!"),
        }
    }
}

impl Display for BoolBiOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let op = match self {
            BoolBiOp::And => "&&",
            BoolBiOp::Or => "||",
        };
        write!(f, "{}", op)
    }
}

impl Display for ComOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let op = match self {
            ComOp::Lt => "<",
            ComOp::Le => "<=",
            ComOp::Gt => ">",
            ComOp::Ge => ">=",
            ComOp::Eq => "==",
            ComOp::Ne => "!=",
        };
        write!(f, "{}", op)
    }
}

impl Display for ComExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "({} {} {})", self.left, self.op, self.right)
    }
}

impl Display for BoolUOpExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "({}{})", self.op, self.cond)
    }
}

impl Display for BoolBiOpExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "({} {} {})", self.left, self.op, self.right)
    }
}

impl Display for BoolExprInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            BoolExprInner::BoolUnit(b) => write!(f, "{}", b),
            BoolExprInner::BoolBiOpExpr(b) => write!(f, "{}", b),
        }
    }
}

impl Display for BoolExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

impl Display for BoolUnitInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            BoolUnitInner::ComExpr(c) => write!(f, "{}", c),
            BoolUnitInner::BoolExpr(b) => write!(f, "{}", b),
            BoolUnitInner::BoolUOpExpr(u) => write!(f, "{}", u),
        }
    }
}

impl Display for BoolUnit {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

// --- RightVal ---
impl Display for RightValInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            RightValInner::ArithExpr(a) => write!(f, "{}", a),
            RightValInner::BoolExpr(b) => write!(f, "{}", b),
        }
    }
}

impl Display for RightVal {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

// --- LeftVal ---
impl Display for LeftValInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            LeftValInner::Id(id) => write!(f, "{}", id),
            LeftValInner::ArrayExpr(ae) => write!(f, "{}", ae),
            LeftValInner::MemberExpr(me) => write!(f, "{}", me),
        }
    }
}

impl Display for LeftVal {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

// --- Index / Array / Member / FnCall ---
impl Display for IndexExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match &self.inner {
            IndexExprInner::Num(n) => write!(f, "{}", n),
            IndexExprInner::Id(id) => write!(f, "{}", id),
        }
    }
}

impl Display for ArrayExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}[{}]", self.arr, self.idx)
    }
}

impl Display for MemberExpr {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}.{}", self.struct_id, self.member_id)
    }
}

impl Display for FnCall {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        if let Some(vals) = &self.vals {
            let args: Vec<String> = vals.iter().map(|v| format!("{}", v)).collect();
            write!(f, "{}({})", self.name, args.join(", "))
        } else {
            write!(f, "{}()", self.name)
        }
    }
}

// --- ExprUnit ---
impl Display for ExprUnitInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            ExprUnitInner::Num(n) => write!(f, "{}", n),
            ExprUnitInner::Id(id) => write!(f, "{}", id),
            ExprUnitInner::ArithExpr(a) => write!(f, "{}", a),
            ExprUnitInner::FnCall(fc) => write!(f, "{}", fc),
            ExprUnitInner::ArrayExpr(ae) => write!(f, "{}", ae),
            ExprUnitInner::MemberExpr(me) => write!(f, "{}", me),
            ExprUnitInner::ArithUExpr(ue) => write!(f, "{}", ue),
        }
    }
}

impl Display for ExprUnit {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

impl Display for RightValList {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let vals: Vec<String> = self.iter().map(|v| format!("{}", v)).collect();
        write!(f, "{}", vals.join(", "))
    }
}

// --- VarDecl ---
impl Display for VarDecl {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let type_str = if let Some(ts) = self.type_specifier.as_ref() {
            format!("{}", ts)
        } else {
            "unknown".to_string()
        };
        write!(f, "{} {};", type_str, self.identifier)
    }
}

// --- AssignmentStmt ---
impl Display for AssignmentStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{} = {};", self.left_val, self.right_val)
    }
}

impl Display for CodeBlockStmtInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            CodeBlockStmtInner::Assignment(a) => write!(f, "{}", a),
            CodeBlockStmtInner::VarDecl(v) => write!(f, "{}", v),
            CodeBlockStmtInner::Call(c) => write!(f, "{};", c.fn_call),
            CodeBlockStmtInner::Return(r) => {
                if let Some(val) = &r.val {
                    write!(f, "return {};", val)
                } else {
                    write!(f, "return;")
                }
            }
            CodeBlockStmtInner::Continue(_) => write!(f, "continue;"),
            CodeBlockStmtInner::Break(_) => write!(f, "break;"),
            CodeBlockStmtInner::Null(_) => write!(f, ";"),
            CodeBlockStmtInner::If(i) => {
                if let Some(else_stmts) = &i.else_stmts {
                    write!(
                        f,
                        "if ({}) {{\n{}\n}} else {{\n{}\n}}",
                        i.bool_unit, i.if_stmts, else_stmts
                    )
                } else {
                    write!(f, "if ({}) {{\n{}\n}}", i.bool_unit, i.if_stmts)
                }
            }
            CodeBlockStmtInner::While(w) => {
                write!(f, "while ({}) {{\n{}\n}}", w.bool_unit, w.stmts)
            }
        }
    }
}

impl Display for CodeBlockStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

impl Display for CodeBlockStmtList {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let stmts: Vec<String> = self.iter().map(|s| format!("{}", s)).collect();
        write!(f, "{}", stmts.join("\n"))
    }
}

impl Display for ProgramElementInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            ProgramElementInner::VarDeclStmt(v) => write!(f, "{}", v),
            ProgramElementInner::StructDef(s) => write!(f, "struct {} {{\n{}\n}}", s.identifier, s.decls),
            ProgramElementInner::FnDeclStmt(d) => write!(f, "fn {}(...);", d.identifier),
            ProgramElementInner::FnDef(fdef) => write!(f, "fn {} {{\n{}\n}}", fdef.fn_decl.identifier, fdef.stmts),
        }
    }
}

impl Display for ProgramElement {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

impl Display for ProgramElementList {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let elements: Vec<String> = self.iter().map(|e| format!("{}", e)).collect();
        write!(f, "{}", elements.join("\n"))
    }
}

impl Display for Program {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        //write!(f, "{}", self.elements)
        self.fmt_tree_root(f)
    }
}

impl Display for VarDeclStmtInner {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        match self {
            VarDeclStmtInner::Decl(var_decl) => write!(f, "{}", var_decl),
            VarDeclStmtInner::Def(var_def) => match &var_def.inner {
                VarDefInner::Scalar(s) => write!(f, "{} = {};", var_def.identifier, s.val),
                VarDefInner::Array(a) => write!(f, "{} = [{}];", var_def.identifier, a.vals),
            },
        }
    }
}

// VarDeclStmt
impl Display for VarDeclStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        write!(f, "{}", self.inner)
    }
}

impl Display for VarDeclList {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {
        let decls: Vec<String> = self.iter().map(|v| format!("{}", v)).collect();
        write!(f, "{}", decls.join("\n"))
    }
}

