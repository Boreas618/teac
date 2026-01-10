//! Type-related AST nodes.

use std::rc::Rc;

/// Source position (byte offset).
pub type Pos = usize;

/// Built-in primitive types.
#[derive(Debug, Clone)]
pub enum BuiltIn {
    Int,
}

/// Type specifier variants.
#[derive(Debug, Clone)]
pub enum TypeSpecifierInner {
    BuiltIn(BuiltIn),
    Composite(String),
}

/// A type specifier with source position.
#[derive(Debug, Clone)]
pub struct TypeSepcifier {
    pub pos: Pos,
    pub inner: TypeSpecifierInner,
}

/// Shared optional type specifier (used for type inference).
pub type SharedTypeSpec = Rc<Option<TypeSepcifier>>;
