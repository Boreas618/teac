//! IR generation from AST.
//!
//! This module provides the IR generation logic, split into:
//!
//! - [`module_gen`]: Top-level module generation (globals, structs, functions)
//! - [`static_eval`]: Static evaluation of constant expressions
//! - [`function_gen`]: Function body generation (expressions, statements)

mod function_gen;
mod module_gen;
mod static_eval;

use crate::ast;
use crate::ir::types::Dtype;

// =============================================================================
// Type Conversion Traits
// =============================================================================

/// Trait for extracting base dtype from AST declarations.
pub trait BaseDtype {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier>;

    fn base_dtype(&self) -> Dtype {
        match self.type_specifier().as_ref().as_ref().map(|t| &t.inner) {
            Some(ast::TypeSpecifierInner::Composite(name)) => Dtype::Struct {
                type_name: name.to_string(),
            },
            Some(ast::TypeSpecifierInner::BuiltIn(_)) | None => Dtype::I32,
        }
    }
}

impl BaseDtype for ast::VarDecl {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier> {
        &self.type_specifier
    }
}

impl BaseDtype for ast::VarDef {
    fn type_specifier(&self) -> &Option<ast::TypeSepcifier> {
        &self.type_specifier
    }
}

// =============================================================================
// Named Trait Implementation for AST Types
// =============================================================================

/// Trait for types that may have an identifier.
pub trait Named {
    fn identifier(&self) -> Option<String>;
}

impl Named for ast::VarDecl {
    fn identifier(&self) -> Option<String> {
        Some(self.identifier.clone())
    }
}

impl Named for ast::VarDef {
    fn identifier(&self) -> Option<String> {
        Some(self.identifier.clone())
    }
}

impl Named for ast::VarDeclStmt {
    fn identifier(&self) -> Option<String> {
        match &self.inner {
            ast::VarDeclStmtInner::Decl(d) => Some(d.identifier.clone()),
            ast::VarDeclStmtInner::Def(d) => Some(d.identifier.clone()),
        }
    }
}

// =============================================================================
// Type Conversions from AST
// =============================================================================

impl From<ast::TypeSepcifier> for Dtype {
    fn from(a: ast::TypeSepcifier) -> Self {
        Self::from(&a)
    }
}

impl From<&ast::TypeSepcifier> for Dtype {
    fn from(a: &ast::TypeSepcifier) -> Self {
        match &a.inner {
            ast::TypeSpecifierInner::BuiltIn(_) => Self::I32,
            ast::TypeSpecifierInner::Composite(name) => Self::Struct {
                type_name: name.to_string(),
            },
        }
    }
}

impl TryFrom<&ast::VarDecl> for Dtype {
    type Error = crate::ir::Error;

    fn try_from(decl: &ast::VarDecl) -> Result<Self, Self::Error> {
        let base_dtype = decl.base_dtype();
        match &decl.inner {
            ast::VarDeclInner::Array(decl) => Ok(Dtype::Pointer {
                inner: Box::new(base_dtype),
                length: decl.len,
            }),
            ast::VarDeclInner::Scalar(_) => Ok(decl.base_dtype()),
        }
    }
}

impl TryFrom<&ast::VarDef> for Dtype {
    type Error = crate::ir::Error;

    fn try_from(def: &ast::VarDef) -> Result<Self, Self::Error> {
        if let Dtype::Struct { .. } = &def.base_dtype() {
            return Err(crate::ir::Error::StructInitialization);
        }
        let base_dtype = def.base_dtype();
        match &def.inner {
            ast::VarDefInner::Array(def) => Ok(Dtype::Pointer {
                inner: Box::new(base_dtype),
                length: def.len,
            }),
            ast::VarDefInner::Scalar(_) => Ok(base_dtype),
        }
    }
}

impl TryFrom<&ast::VarDeclStmt> for Dtype {
    type Error = crate::ir::Error;

    fn try_from(value: &ast::VarDeclStmt) -> Result<Self, Self::Error> {
        match &value.inner {
            ast::VarDeclStmtInner::Decl(d) => Dtype::try_from(d.as_ref()),
            ast::VarDeclStmtInner::Def(d) => Dtype::try_from(d.as_ref()),
        }
    }
}

