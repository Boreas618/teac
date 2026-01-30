use crate::asm::error::Error;
use crate::ir;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub struct VReg(pub u32);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum VRegKind {
    Int32,
    Ptr64,
}

pub fn vreg_from_value(val: &ir::Operand) -> Result<VReg, Error> {
    val.as_local()
        .map(|local| VReg(local.index as u32))
        .ok_or_else(|| Error::UnsupportedOperand {
            what: format!("expected local variable, got: {}", val),
        })
}
