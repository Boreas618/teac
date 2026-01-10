#![allow(unused)]
//! IR data types and type-related structures.
//!
//! This module provides the core type system for the IR:
//!
//! - [`Dtype`]: Data type representation (i32, void, struct, pointer)
//! - [`StructMember`] / [`StructType`]: Struct type definitions
//! - [`FunctionType`]: Function signatures

use crate::ast;
use std::fmt::{self, Display, Formatter};

// =============================================================================
// Data Types
// =============================================================================

/// IR data type representation.
#[derive(Clone, PartialEq, PartialOrd, Debug)]
pub enum Dtype {
    /// Void type (no value).
    Void,
    /// 32-bit signed integer.
    I32,
    /// Struct type with a named definition.
    Struct { type_name: String },
    /// Pointer to an element type, with array length.
    /// - `length == 0`: scalar pointer (points to a single element)
    /// - `length > 0`: array of `length` elements
    Pointer { inner: Box<Dtype>, length: usize },
    /// Placeholder for type inference.
    Undecided,
}

impl Dtype {
    /// Creates a scalar pointer type (points to a single element).
    pub fn ptr_to(inner: Self) -> Self {
        Self::Pointer {
            inner: Box::new(inner),
            length: 0,
        }
    }

    /// Creates an array type with the given number of elements.
    pub fn array_of(elem: Self, len: usize) -> Self {
        Self::Pointer {
            inner: Box::new(elem),
            length: len,
        }
    }

    /// Extracts the struct type name, looking through pointers if needed.
    pub fn struct_type_name(&self) -> Option<&String> {
        match self {
            Dtype::Struct { type_name } => Some(type_name),
            Dtype::Pointer { inner, .. } => inner.struct_type_name(),
            _ => None,
        }
    }
}

impl Display for Dtype {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Dtype::I32 => write!(f, "i32"),
            Dtype::Void => write!(f, "void"),
            Dtype::Struct { type_name } => write!(f, "%{}", type_name),
            Dtype::Pointer { inner, length } => {
                if *length == 0 {
                    write!(f, "{}", inner.as_ref())
                } else {
                    write!(f, "[{} x {}]", length, inner.as_ref())
                }
            }
            Dtype::Undecided => write!(f, "?"),
        }
    }
}

// =============================================================================
// Struct Types
// =============================================================================

/// A member field of a struct type.
pub struct StructMember {
    /// Byte offset from the start of the struct.
    pub offset: i32,
    /// Data type of the member.
    pub dtype: Dtype,
}

/// A struct type definition.
pub struct StructType {
    /// List of (field_name, member) pairs in declaration order.
    pub elements: Vec<(String, StructMember)>,
}

// =============================================================================
// Function Types
// =============================================================================

/// A function type (signature).
#[derive(Clone, PartialEq)]
pub struct FunctionType {
    /// Return type of the function.
    pub return_dtype: Dtype,
    /// List of (parameter_name, parameter_type) pairs.
    pub arguments: Vec<(String, Dtype)>,
}

impl PartialEq<ast::FnDecl> for FunctionType {
    fn eq(&self, rhs: &ast::FnDecl) -> bool {
        let rhs_dtype = match rhs
            .return_dtype
            .as_ref()
            .as_ref()
            .and_then(|ty| Some(Dtype::from(ty)))
        {
            Some(dtype) => dtype,
            None => Dtype::Void,
        };

        if self.return_dtype != rhs_dtype {
            return false;
        }

        let mut rhs_args = Vec::new();
        if let Some(params) = &rhs.param_decl {
            for decl in params.decls.iter() {
                let identifier = decl.identifier.clone();
                let dtype = match Dtype::try_from(decl) {
                    Ok(t) => t,
                    Err(_) => return false,
                };

                rhs_args.push((identifier, dtype));
            }
        }

        let num_args = self.arguments.len();
        if rhs_args.len() != num_args {
            return false;
        }

        for ((lhs_id, lhs_dtype), (rhs_id, rhs_dtype)) in self.arguments.iter().zip(rhs_args) {
            if lhs_id != &rhs_id || lhs_dtype != &rhs_dtype {
                return false;
            }
        }

        true
    }
}
