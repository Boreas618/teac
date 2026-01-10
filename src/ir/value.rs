#![allow(unused)]
//! IR values and operands.
//!
//! This module provides the value types that can be used as operands in IR statements:
//!
//! - [`Value`]: Unified value enum (integer, local variable, global variable)
//! - [`Integer`]: Constant integer value
//! - [`LocalVariable`]: Function-local virtual register
//! - [`GlobalVariable`]: Global variable reference
//! - [`Typed`]: Trait for values with types

use super::types::Dtype;
use std::fmt::{Display, Formatter};

// =============================================================================
// Typed Trait
// =============================================================================

/// Trait for values that have a data type.
pub trait Typed {
    fn dtype(&self) -> &Dtype;
}

// =============================================================================
// Named Trait
// =============================================================================

/// Trait for values that may have an identifier.
pub trait Named {
    fn identifier(&self) -> Option<String>;
}

// =============================================================================
// Operand Enum
// =============================================================================

/// A unified type representing all possible IR operands.
#[derive(Clone)]
pub enum Operand {
    /// Constant integer value.
    Integer(Integer),
    /// Local variable (virtual register).
    Local(LocalVariable),
    /// Global variable reference.
    Global(GlobalVariable),
}

impl Operand {
    /// Returns the data type of this value.
    pub fn dtype(&self) -> &Dtype {
        match self {
            Operand::Integer(i) => i.dtype(),
            Operand::Local(l) => l.dtype(),
            Operand::Global(g) => g.dtype(),
        }
    }

    /// Returns the identifier if this value has one.
    pub fn identifier(&self) -> Option<String> {
        match self {
            Operand::Integer(i) => i.identifier(),
            Operand::Local(l) => l.identifier(),
            Operand::Global(g) => g.identifier(),
        }
    }

    /// Attempts to get this value as a LocalVariable.
    pub fn as_local(&self) -> Option<&LocalVariable> {
        match self {
            Operand::Local(l) => Some(l),
            _ => None,
        }
    }

    /// Attempts to get this value as a GlobalVariable.
    pub fn as_global(&self) -> Option<&GlobalVariable> {
        match self {
            Operand::Global(g) => Some(g),
            _ => None,
        }
    }

    /// Attempts to get this value as an Integer.
    pub fn as_integer(&self) -> Option<&Integer> {
        match self {
            Operand::Integer(i) => Some(i),
            _ => None,
        }
    }

    /// Returns true if this is an addressable value (local or global variable).
    pub fn is_addressable(&self) -> bool {
        matches!(self, Operand::Local(_) | Operand::Global(_))
    }

    /// Returns the virtual register index if this is a local variable.
    pub fn vreg_index(&self) -> Option<usize> {
        self.as_local().map(|l| l.index)
    }
}

impl Display for Operand {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Operand::Integer(i) => write!(f, "{}", i),
            Operand::Local(l) => write!(f, "{}", l),
            Operand::Global(g) => write!(f, "{}", g),
        }
    }
}

impl From<Integer> for Operand {
    fn from(i: Integer) -> Self {
        Operand::Integer(i)
    }
}

impl From<LocalVariable> for Operand {
    fn from(l: LocalVariable) -> Self {
        Operand::Local(l)
    }
}

impl From<GlobalVariable> for Operand {
    fn from(g: GlobalVariable) -> Self {
        Operand::Global(g)
    }
}

impl From<i32> for Operand {
    fn from(v: i32) -> Self {
        Operand::Integer(Integer::from(v))
    }
}

// =============================================================================
// Integer Constant
// =============================================================================

/// A constant integer value.
#[derive(Clone)]
pub struct Integer {
    _dtype: Dtype,
    /// The integer value.
    pub value: i32,
}

impl From<i32> for Integer {
    fn from(value: i32) -> Self {
        Self {
            _dtype: Dtype::I32,
            value,
        }
    }
}

impl Typed for Integer {
    fn dtype(&self) -> &Dtype {
        &Dtype::I32
    }
}

impl Named for Integer {
    fn identifier(&self) -> Option<String> {
        None
    }
}

impl Display for Integer {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.value)
    }
}

// =============================================================================
// Local Variable
// =============================================================================

/// A local variable (virtual register) within a function.
#[derive(Clone)]
pub struct LocalVariable {
    /// Data type of the variable.
    pub dtype: Dtype,
    /// Optional source-level identifier.
    pub identifier: Option<String>,
    /// Virtual register index.
    pub index: usize,
}

impl Typed for LocalVariable {
    fn dtype(&self) -> &Dtype {
        &self.dtype
    }
}

impl Named for LocalVariable {
    fn identifier(&self) -> Option<String> {
        self.identifier.clone()
    }
}

impl Display for LocalVariable {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "%r{}", self.index)
    }
}

impl LocalVariable {
    /// Creates a new LocalVariable without an identifier.
    pub fn new(dtype: Dtype, index: usize, identifier: Option<String>) -> Self {
        Self {
            dtype,
            identifier,
            index,
        }
    }
}

// =============================================================================
// Global Variable
// =============================================================================

/// A global variable definition.
#[derive(Clone)]
pub struct GlobalVariable {
    /// Data type of the variable.
    pub dtype: Dtype,
    /// Identifier (symbol name).
    pub identifier: String,
    /// Optional static initializers.
    pub initializers: Option<Vec<i32>>,
}

impl Typed for GlobalVariable {
    fn dtype(&self) -> &Dtype {
        &self.dtype
    }
}

impl Named for GlobalVariable {
    fn identifier(&self) -> Option<String> {
        Some(self.identifier.clone())
    }
}

impl Display for GlobalVariable {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "@{}", self.identifier)
    }
}
