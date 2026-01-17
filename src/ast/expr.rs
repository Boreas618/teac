//! Expression AST nodes.

use super::ops::*;
use super::types::Pos;

// =============================================================================
// Forward declarations (to break circular deps)
// =============================================================================

/// Left-value expression (assignable).
#[derive(Debug, Clone)]
pub struct LeftVal {
    pub pos: Pos,
    pub inner: LeftValInner,
}

/// Left-value variants.
#[derive(Debug, Clone)]
pub enum LeftValInner {
    Id(String),
    ArrayExpr(Box<ArrayExpr>),
    MemberExpr(Box<MemberExpr>),
}

// =============================================================================
// Index and Access Expressions
// =============================================================================

/// Index expression variants.
#[derive(Debug, Clone)]
pub enum IndexExprInner {
    Num(usize),
    Id(String),
}

/// An index expression (array subscript).
#[derive(Debug, Clone)]
pub struct IndexExpr {
    pub inner: IndexExprInner,
}

/// Array access expression.
#[derive(Debug, Clone)]
pub struct ArrayExpr {
    pub arr: Box<LeftVal>,
    pub idx: Box<IndexExpr>,
}

/// Member access expression (struct field).
#[derive(Debug, Clone)]
pub struct MemberExpr {
    pub struct_id: Box<LeftVal>,
    pub member_id: String,
}

// =============================================================================
// Arithmetic Expressions
// =============================================================================

/// Unary arithmetic expression.
#[derive(Debug, Clone)]
pub struct ArithUExpr {
    pub op: ArithUOp,
    pub expr: Box<ExprUnit>,
}

/// Binary arithmetic expression.
#[derive(Debug, Clone)]
pub struct ArithBiOpExpr {
    pub op: ArithBiOp,
    pub left: Box<ArithExpr>,
    pub right: Box<ArithExpr>,
}

/// Arithmetic expression variants.
#[derive(Debug, Clone)]
pub enum ArithExprInner {
    ArithBiOpExpr(Box<ArithBiOpExpr>),
    ExprUnit(Box<ExprUnit>),
}

/// An arithmetic expression.
#[derive(Debug, Clone)]
pub struct ArithExpr {
    pub pos: Pos,
    pub inner: ArithExprInner,
}

// =============================================================================
// Boolean Expressions
// =============================================================================

/// Comparison expression.
#[derive(Debug, Clone)]
pub struct ComExpr {
    pub op: ComOp,
    pub left: Box<ExprUnit>,
    pub right: Box<ExprUnit>,
}

/// Unary boolean expression.
#[derive(Debug, Clone)]
pub struct BoolUOpExpr {
    pub op: BoolUOp,
    pub cond: Box<BoolUnit>,
}

/// Binary boolean expression.
#[derive(Debug, Clone)]
pub struct BoolBiOpExpr {
    pub op: BoolBiOp,
    pub left: Box<BoolExpr>,
    pub right: Box<BoolExpr>,
}

/// Boolean expression variants.
#[derive(Debug, Clone)]
pub enum BoolExprInner {
    BoolBiOpExpr(Box<BoolBiOpExpr>),
    BoolUnit(Box<BoolUnit>),
}

/// A boolean expression.
#[derive(Debug, Clone)]
pub struct BoolExpr {
    pub pos: Pos,
    pub inner: BoolExprInner,
}

/// Boolean unit variants.
#[derive(Debug, Clone)]
pub enum BoolUnitInner {
    ComExpr(Box<ComExpr>),
    BoolExpr(Box<BoolExpr>),
    BoolUOpExpr(Box<BoolUOpExpr>),
}

/// A boolean unit (atomic boolean expression).
#[derive(Debug, Clone)]
pub struct BoolUnit {
    pub pos: Pos,
    pub inner: BoolUnitInner,
}

// =============================================================================
// Expression Units and Values
// =============================================================================

/// Function call expression.
#[derive(Debug, Clone)]
pub struct FnCall {
    pub name: String,
    pub vals: RightValList,
}

/// Expression unit variants.
#[derive(Debug, Clone)]
pub enum ExprUnitInner {
    Num(i32),
    Id(String),
    ArithExpr(Box<ArithExpr>),
    FnCall(Box<FnCall>),
    ArrayExpr(Box<ArrayExpr>),
    MemberExpr(Box<MemberExpr>),
    #[allow(dead_code)]
    ArithUExpr(Box<ArithUExpr>),
}

/// An expression unit (atomic expression).
#[derive(Debug, Clone)]
pub struct ExprUnit {
    pub pos: Pos,
    pub inner: ExprUnitInner,
}

/// Right-value variants.
#[derive(Debug, Clone)]
pub enum RightValInner {
    ArithExpr(Box<ArithExpr>),
    BoolExpr(Box<BoolExpr>),
}

/// A right-value expression.
#[derive(Debug, Clone)]
pub struct RightVal {
    pub inner: RightValInner,
}

/// List of right-values (e.g., function arguments, array initializers).
pub type RightValList = Vec<RightVal>;
