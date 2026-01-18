//! Abstract Syntax Tree (AST) definitions.
//!
//! This module defines all AST node types used by the parser.
//! The types are organized into submodules by category:
//!
//! - [`types`]: Type-related nodes (BuiltIn, TypeSpecifier)
//! - [`ops`]: Operator enums (ArithBiOp, BoolBiOp, ComOp, etc.)
//! - [`expr`]: Expression nodes (ArithExpr, BoolExpr, etc.)
//! - [`stmt`]: Statement nodes (IfStmt, WhileStmt, etc.)
//! - [`decl`]: Declaration nodes (VarDecl, FnDecl, StructDef, etc.)
//! - [`program`]: Top-level program structure
//! - [`display`]: Display implementations
//! - [`tree`]: Tree-formatted display

pub mod decl;
pub mod display;
pub mod expr;
pub mod ops;
pub mod program;
pub mod stmt;
pub mod tree;
pub mod types;

// =============================================================================
// Re-exports for backward compatibility with `ast::TypeName` usage
// =============================================================================

// Types
pub use types::{BuiltIn, TypeSepcifier, TypeSpecifierInner};

// Operators
pub use ops::{ArithBiOp, ArithUOp, BoolBiOp, BoolUOp, ComOp};

// Expressions
pub use expr::{
    ArithBiOpExpr, ArithExpr, ArithExprInner, ArithUExpr, ArrayExpr, BoolBiOpExpr, BoolExpr,
    BoolExprInner, BoolUOpExpr, BoolUnit, BoolUnitInner, ComExpr, ExprUnit, ExprUnitInner, FnCall,
    IndexExpr, IndexExprInner, LeftVal, LeftValInner, MemberExpr, RightVal, RightValInner,
    RightValList,
};

// Statements
pub use stmt::{
    AssignmentStmt, BreakStmt, CallStmt, CodeBlockStmt, CodeBlockStmtInner,
    ContinueStmt, IfStmt, NullStmt, ReturnStmt, WhileStmt,
};

// Declarations
pub use decl::{
    FnDecl, FnDeclStmt, FnDef, ParamDecl, StructDef, VarDecl, VarDeclArray, VarDeclInner, VarDeclStmt, VarDeclStmtInner, VarDef, VarDefArray, VarDefInner, VarDefScalar,
};

// Program
pub use program::{Program, ProgramElement, ProgramElementInner, UseStmt};
