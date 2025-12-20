//! Declaration AST nodes.

use super::expr::{RightVal, RightValList};
use super::stmt::CodeBlockStmtList;
use super::types::{Pos, SharedTypeSpec};
use std::ops::Deref;

// =============================================================================
// Variable Declarations
// =============================================================================

/// Scalar variable declaration marker.
#[derive(Debug, Clone)]
pub struct VarDeclScalar {
    pub pos: Pos,
}

/// Array variable declaration.
#[derive(Debug, Clone)]
pub struct VarDeclArray {
    pub pos: Pos,
    pub len: usize,
}

/// Variable declaration variants.
#[derive(Debug, Clone)]
pub enum VarDeclInner {
    Scalar(Box<VarDeclScalar>),
    Array(Box<VarDeclArray>),
}

/// A variable declaration (without initialization).
#[derive(Debug, Clone)]
pub struct VarDecl {
    pub pos: Pos,
    pub identifier: String,
    pub type_specifier: SharedTypeSpec,
    pub inner: VarDeclInner,
}

/// List of variable declarations.
pub type VarDeclList = Vec<VarDecl>;

// =============================================================================
// Variable Definitions
// =============================================================================

/// Scalar variable definition.
#[derive(Debug, Clone)]
pub struct VarDefScalar {
    pub pos: Pos,
    pub val: Box<RightVal>,
}

/// Array variable definition.
#[derive(Debug, Clone)]
pub struct VarDefArray {
    pub pos: Pos,
    pub len: usize,
    pub vals: RightValList,
}

/// Variable definition variants.
#[derive(Debug, Clone)]
pub enum VarDefInner {
    Scalar(Box<VarDefScalar>),
    Array(Box<VarDefArray>),
}

/// A variable definition (with initialization).
#[derive(Debug, Clone)]
pub struct VarDef {
    pub pos: Pos,
    pub identifier: String,
    pub type_specifier: SharedTypeSpec,
    pub inner: VarDefInner,
}

// =============================================================================
// Declaration Statements
// =============================================================================

/// Variable declaration statement variants.
#[derive(Debug, Clone)]
pub enum VarDeclStmtInner {
    Decl(Box<VarDecl>),
    Def(Box<VarDef>),
}

/// A variable declaration statement.
#[derive(Debug, Clone)]
pub struct VarDeclStmt {
    pub pos: Pos,
    pub inner: VarDeclStmtInner,
}

// =============================================================================
// Struct Definition
// =============================================================================

/// A struct type definition.
#[derive(Debug, Clone)]
pub struct StructDef {
    pub pos: Pos,
    pub identifier: String,
    pub decls: VarDeclList,
}

// =============================================================================
// Function Declarations and Definitions
// =============================================================================

/// Function parameter declaration.
#[derive(Debug, Clone)]
pub struct ParamDecl {
    pub decls: VarDeclList,
}

/// A function declaration (signature).
#[derive(Debug, Clone)]
pub struct FnDecl {
    pub pos: Pos,
    pub identifier: String,
    pub param_decl: Option<Box<ParamDecl>>,
    pub return_dtype: SharedTypeSpec,
}

/// A function definition (signature + body).
#[derive(Debug, Clone)]
pub struct FnDef {
    pub pos: Pos,
    pub fn_decl: Box<FnDecl>,
    pub stmts: CodeBlockStmtList,
}

/// A function declaration statement.
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

