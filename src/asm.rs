pub mod aarch64;
pub mod common;
pub mod error;

pub use aarch64::AArch64AsmGenerator;
pub use error::Error;
use std::io::Write;

pub trait AsmGenerator {
    fn generate(&mut self) -> Result<(), Error>;
    fn output<W: Write>(&self, w: &mut W) -> Result<(), Error>;
}
