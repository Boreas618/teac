pub mod aarch64;
pub mod common;
pub mod error;

pub use aarch64::AArch64AsmGenerator;
pub use error::Error;
use std::io::Write;

// =============================================================================
// Code Generator Trait
// =============================================================================

/// Trait for target-specific assembly code generators.
///
/// This trait defines the interface that all backend code generators must implement.
/// Each backend (e.g., AArch64, x86_64) provides its own implementation.
pub trait AsmGenerator {
    /// Emits assembly code for the entire module to the given writer.
    fn output<W: Write>(&self, w: &mut W) -> Result<(), Error>;
}
