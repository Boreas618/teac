//! Intermediate Representation (IR) module.
//!
//! This module provides the IR data structures and generation logic:
//!
//! ## Core Types
//!
//! - [`types`]: Data types (Dtype, StructType, FunctionType)
//! - [`value`]: Values and operands (Value, Integer, LocalVariable, GlobalVariable)
//! - [`function`]: Function representation and generation context
//! - [`module`]: Module and registry
//! - [`stmt`]: IR statements
//! - [`error`]: Error types
//!
//! ## Code Generation
//!
//! - [`gen`]: IR generation from AST
//!
//! ## Quick Reference
//!
//! The IR is a simple SSA-like representation with:
//! - Basic blocks labeled with `BlockLabel`
//! - Virtual registers (`LocalVariable`)
//! - Statements for arithmetic, memory, and control flow

pub mod error;
pub mod function;
mod gen;
pub mod module;
pub mod stmt;
pub mod types;
pub mod value;

pub use error::Error;
pub use function::{BlockLabel, Function};
pub use module::{Module, ModuleGenerator, Registry};
pub use types::{Dtype, StructType};
pub use value::{GlobalVariable, LocalVariable, Operand};
