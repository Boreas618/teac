use std::fmt::{Display, Formatter};
use std::{ops::Deref, rc::Rc};
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

impl Display for ExprUnit {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        write!(f, "{:?}", self)
    }
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
