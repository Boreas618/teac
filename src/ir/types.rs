#![allow(unused)]

use crate::ast;
use std::fmt::{self, Display, Formatter};

#[derive(Clone, PartialEq, PartialOrd, Debug)]
pub enum Dtype {
    Void,
    I32,
    Struct { type_name: String },
    /// `length == 0`: scalar pointer, `length > 0`: array
    Pointer { inner: Box<Dtype>, length: usize },
    Undecided,
}

impl Dtype {
    pub fn ptr_to(inner: Self) -> Self {
        Self::Pointer {
            inner: Box::new(inner),
            length: 0,
        }
    }

    pub fn array_of(elem: Self, len: usize) -> Self {
        Self::Pointer {
            inner: Box::new(elem),
            length: len,
        }
    }

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

pub struct StructMember {
    pub offset: i32,
    pub dtype: Dtype,
}

pub struct StructType {
    pub elements: Vec<(String, StructMember)>,
}

#[derive(Clone, PartialEq)]
pub struct FunctionType {
    pub return_dtype: Dtype,
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
