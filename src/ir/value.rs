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
// Value Enum
// =============================================================================

/// A unified value type representing all possible IR operands.
/// This replaces the previous `dyn Operand` pattern with type-safe enum dispatch.
#[derive(Clone)]
pub enum Value {
    /// Constant integer value.
    Integer(Integer),
    /// Local variable (virtual register).
    Local(LocalVariable),
    /// Global variable reference.
    Global(GlobalVariable),
}

impl Value {
    /// Returns the data type of this value.
    pub fn dtype(&self) -> &Dtype {
        match self {
            Value::Integer(i) => i.dtype(),
            Value::Local(l) => l.dtype(),
            Value::Global(g) => g.dtype(),
        }
    }

    /// Returns the identifier if this value has one.
    pub fn identifier(&self) -> Option<String> {
        match self {
            Value::Integer(i) => i.identifier(),
            Value::Local(l) => l.identifier(),
            Value::Global(g) => g.identifier(),
        }
    }

    /// Attempts to get this value as a LocalVariable.
    pub fn as_local(&self) -> Option<&LocalVariable> {
        match self {
            Value::Local(l) => Some(l),
            _ => None,
        }
    }

    /// Attempts to get this value as a GlobalVariable.
    pub fn as_global(&self) -> Option<&GlobalVariable> {
        match self {
            Value::Global(g) => Some(g),
            _ => None,
        }
    }

    /// Attempts to get this value as an Integer.
    pub fn as_integer(&self) -> Option<&Integer> {
        match self {
            Value::Integer(i) => Some(i),
            _ => None,
        }
    }

    /// Returns true if this is an addressable value (local or global variable).
    pub fn is_addressable(&self) -> bool {
        matches!(self, Value::Local(_) | Value::Global(_))
    }

    /// Returns the virtual register index if this is a local variable.
    pub fn vreg_index(&self) -> Option<usize> {
        self.as_local().map(|l| l.index)
    }
}

impl Display for Value {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Value::Integer(i) => write!(f, "{}", i),
            Value::Local(l) => write!(f, "{}", l),
            Value::Global(g) => write!(f, "{}", g),
        }
    }
}

impl From<Integer> for Value {
    fn from(i: Integer) -> Self {
        Value::Integer(i)
    }
}

impl From<LocalVariable> for Value {
    fn from(l: LocalVariable) -> Self {
        Value::Local(l)
    }
}

impl From<GlobalVariable> for Value {
    fn from(g: GlobalVariable) -> Self {
        Value::Global(g)
    }
}

impl From<i32> for Value {
    fn from(v: i32) -> Self {
        Value::Integer(Integer::from(v))
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
    /// Creates a new builder for constructing a LocalVariable.
    pub fn builder() -> LocalVariableBuilder {
        LocalVariableBuilder::new()
    }
}


#[derive(Default)]
pub struct LocalVariableBuilder {
    dtype: Option<Dtype>,
    identifier: Option<String>,
    index: Option<usize>,
}

impl LocalVariableBuilder {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn dtype(mut self, dtype: Dtype) -> Self {
        self.dtype = Some(dtype);
        self
    }

    pub fn identifier(mut self, identifier: impl Into<String>) -> Self {
        self.identifier = Some(identifier.into());
        self
    }

    pub fn index(mut self, index: usize) -> Self {
        self.index = Some(index);
        self
    }

    pub fn build(self) -> LocalVariable {
        LocalVariable {
            dtype: self.dtype.expect("dtype is required"),
            identifier: self.identifier,
            index: self.index.expect("index is required"),
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
