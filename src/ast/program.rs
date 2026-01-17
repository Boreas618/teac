//! Top-level program structure.

use super::decl::{FnDeclStmt, FnDef, StructDef, VarDeclStmt};

/// Use statement for importing modules.
#[derive(Debug, Clone)]
pub struct UseStmt {
    pub module_name: String,
}

/// Program element variants.
#[derive(Debug, Clone)]
pub enum ProgramElementInner {
    VarDeclStmt(Box<VarDeclStmt>),
    StructDef(Box<StructDef>),
    FnDeclStmt(Box<FnDeclStmt>),
    FnDef(Box<FnDef>),
}

/// A top-level program element.
#[derive(Debug, Clone)]
pub struct ProgramElement {
    pub inner: ProgramElementInner,
}

/// List of program elements.
pub type ProgramElementList = Vec<ProgramElement>;

/// The root AST node representing an entire program.
#[derive(Debug, Clone)]
pub struct Program {
    pub use_stmts: Vec<UseStmt>,
    pub elements: ProgramElementList,
}
