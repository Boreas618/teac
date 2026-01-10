//! Core AArch64 type definitions.
//!
//! This module contains the fundamental types used throughout the AArch64
//! backend: registers, operands, addresses, and related enums.

use crate::asm::common::VReg;
use crate::asm::error::Error;
use crate::ir;

// =============================================================================
// Register Types
// =============================================================================

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Reg {
    V(VReg),
    P(u8),
    SP,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum RegSize {
    W32,
    X64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BinOp {
    Add,
    Sub,
    Mul,
    SDiv,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Cond {
    Eq,
    Ne,
    Lt,
    Le,
    Gt,
    Ge,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Operand {
    Reg(Reg),
    Imm(i64),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Addr {
    BaseOff { base: Reg, offset: i64 },
    Global(String),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum IndexOperand {
    Reg(Reg),
    Imm(i64),
}

pub fn dtype_to_regsize(dtype: &ir::Dtype) -> Result<RegSize, Error> {
    match dtype {
        ir::Dtype::I32 => Ok(RegSize::W32),
        ir::Dtype::Pointer { .. } => Ok(RegSize::X64),
        _ => Err(Error::UnsupportedDtype {
            dtype: dtype.clone(),
        }),
    }
}
