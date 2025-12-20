//! Virtual register representation.
use crate::asm::error::Error;
use crate::ir;

/// Virtual register identifier.
///
/// Virtual registers are assigned during instruction selection and later
/// mapped to physical registers (or spilled) by the register allocator.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub struct VReg(pub u32);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum VRegKind {
    Int32,
    Ptr64,
}

/// Extracts a virtual register from an IR Value.
///
/// # Errors
///
/// Returns [`Error::UnsupportedOperand`] if the value is not a local variable.
pub fn vreg_from_value(val: &ir::Value) -> Result<VReg, Error> {
    val.as_local()
        .map(|local| VReg(local.index as u32))
        .ok_or_else(|| Error::UnsupportedOperand {
            what: format!("expected local variable, got: {}", val),
        })
}
