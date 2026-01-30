use std::collections::HashSet;

use super::types::{Addr, BinOp, Cond, IndexOperand, Operand, Register, RegSize};

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Inst {
    Label(String),

    Mov {
        size: RegSize,
        dst: Register,
        src: Operand,
    },

    BinOp {
        op: BinOp,
        size: RegSize,
        dst: Register,
        lhs: Register,
        rhs: Operand,
    },

    Ldr {
        size: RegSize,
        dst: Register,
        addr: Addr,
    },

    Str {
        size: RegSize,
        src: Register,
        addr: Addr,
    },

    Lea {
        dst: Register,
        addr: Addr,
    },

    Gep {
        dst: Register,
        base: Register,
        index: IndexOperand,
        scale: i64,
    },

    Cmp {
        size: RegSize,
        lhs: Register,
        rhs: Operand,
    },

    B {
        label: String,
    },
    BCond {
        cond: Cond,
        label: String,
    },
    Bl {
        func: String,
    },

    SaveCallerRegs,
    RestoreCallerRegs,

    SubSp {
        imm: i64,
    },
    AddSp {
        imm: i64,
    },

    Ret,
}

impl Inst {
    pub fn used_vregs(&self) -> HashSet<usize> {
        let mut used = HashSet::new();

        let add_reg = |s: &mut HashSet<usize>, r: &Register| {
            if let Register::Virtual(v) = r {
                s.insert(*v);
            }
        };

        let add_operand = |s: &mut HashSet<usize>, op: &Operand| {
            if let Operand::Register(Register::Virtual(v)) = op {
                s.insert(*v);
            }
        };

        let add_addr = |s: &mut HashSet<usize>, addr: &Addr| {
            if let Addr::BaseOff {
                base: Register::Virtual(v), ..
            } = addr
            {
                s.insert(*v);
            }
        };

        match self {
            Inst::Mov { src, .. } => add_operand(&mut used, src),
            Inst::BinOp { lhs, rhs, .. } => {
                add_reg(&mut used, lhs);
                add_operand(&mut used, rhs);
            }
            Inst::Ldr { addr, .. } => add_addr(&mut used, addr),
            Inst::Str { src, addr, .. } => {
                add_reg(&mut used, src);
                add_addr(&mut used, addr);
            }
            Inst::Lea { addr, .. } => add_addr(&mut used, addr),
            Inst::Gep { base, index, .. } => {
                add_reg(&mut used, base);
                if let IndexOperand::Reg(r) = index {
                    add_reg(&mut used, r);
                }
            }
            Inst::Cmp { lhs, rhs, .. } => {
                add_reg(&mut used, lhs);
                add_operand(&mut used, rhs);
            }
            Inst::Label(_)
            | Inst::B { .. }
            | Inst::BCond { .. }
            | Inst::Bl { .. }
            | Inst::SaveCallerRegs
            | Inst::RestoreCallerRegs
            | Inst::SubSp { .. }
            | Inst::AddSp { .. }
            | Inst::Ret => {}
        }
        used
    }

    pub fn defined_vregs(&self) -> HashSet<usize> {
        let mut defined = HashSet::new();
        match self {
            Inst::Mov { dst, .. }
            | Inst::BinOp { dst, .. }
            | Inst::Ldr { dst, .. }
            | Inst::Lea { dst, .. }
            | Inst::Gep { dst, .. } => {
                if let Register::Virtual(v) = dst {
                    defined.insert(*v);
                }
            }
            _ => {}
        }
        defined
    }
}
