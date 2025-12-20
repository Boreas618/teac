//! Statement AST nodes.

use super::decl::VarDeclStmt;
use super::expr::{BoolUnit, FnCall, LeftVal, RightVal};
use super::types::Pos;

// =============================================================================
// Simple Statements
// =============================================================================

/// An assignment statement.
#[derive(Debug, Clone)]
pub struct AssignmentStmt {
    pub pos: Pos,
    pub left_val: Box<LeftVal>,
    pub right_val: Box<RightVal>,
}

/// A function call statement.
#[derive(Debug, Clone)]
pub struct CallStmt {
    pub pos: Pos,
    pub fn_call: Box<FnCall>,
}

/// A return statement.
#[derive(Debug, Clone)]
pub struct ReturnStmt {
    pub pos: Pos,
    pub val: Option<Box<RightVal>>,
}

/// A continue statement.
#[derive(Debug, Clone)]
pub struct ContinueStmt {
    pub pos: Pos,
}

/// A break statement.
#[derive(Debug, Clone)]
pub struct BreakStmt {
    pub pos: Pos,
}

/// A null (empty) statement.
#[derive(Debug, Clone)]
pub struct NullStmt {
    pub pos: Pos,
}

// =============================================================================
// Control Flow Statements
// =============================================================================

/// An if statement.
#[derive(Debug, Clone)]
pub struct IfStmt {
    pub pos: Pos,
    pub bool_unit: Box<BoolUnit>,
    pub if_stmts: CodeBlockStmtList,
    pub else_stmts: Option<CodeBlockStmtList>,
}

/// A while loop statement.
#[derive(Debug, Clone)]
pub struct WhileStmt {
    pub pos: Pos,
    pub bool_unit: Box<BoolUnit>,
    pub stmts: CodeBlockStmtList,
}

// =============================================================================
// Code Block
// =============================================================================

/// Code block statement variants.
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

/// A statement within a code block.
#[derive(Debug, Clone)]
pub struct CodeBlockStmt {
    pub pos: Pos,
    pub inner: CodeBlockStmtInner,
}

/// List of statements in a code block.
pub type CodeBlockStmtList = Vec<CodeBlockStmt>;

