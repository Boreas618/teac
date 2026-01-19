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
    /// Generates assembly from the IR module.
    ///
    /// This performs instruction selection, register allocation, and prepares
    /// the final assembly representation without writing it out.
    fn generate(&mut self) -> Result<(), Error>;

    /// Writes the generated assembly to the given writer.
    ///
    /// Must be called after `generate()`.
    fn output<W: Write>(&self, w: &mut W) -> Result<(), Error>;
}
