//! Operator definitions for AST expressions.

/// Unary arithmetic operator.
#[derive(Debug, PartialEq, Clone)]
pub enum ArithUOp {
    Neg,
}

/// Binary arithmetic operator.
#[derive(Debug, Clone)]
pub enum ArithBiOp {
    Add,
    Sub,
    Mul,
    Div,
}

/// Unary boolean operator.
#[derive(Debug, PartialEq, Clone)]
pub enum BoolUOp {
    Not,
}

/// Binary boolean operator.
#[derive(Debug, PartialEq, Clone)]
pub enum BoolBiOp {
    And,
    Or,
}

/// Comparison operator.
#[derive(Debug, Clone)]
pub enum ComOp {
    Lt,
    Le,
    Gt,
    Ge,
    Eq,
    Ne,
}

