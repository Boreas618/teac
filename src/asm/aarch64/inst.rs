use std::collections::HashSet;

use super::types::{Addr, BinOp, Cond, IndexOperand, Operand, Reg, RegSize};

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Inst {
    Label(String),

    Mov {
        size: RegSize,
        dst: Reg,
        src: Operand,
    },

    BinOp {
        op: BinOp,
        size: RegSize,
        dst: Reg,
        lhs: Reg,
        rhs: Operand,
    },

    Ldr {
        size: RegSize,
        dst: Reg,
        addr: Addr,
    },

    Str {
        size: RegSize,
        src: Reg,
        addr: Addr,
    },

    Lea {
        dst: Reg,
        addr: Addr,
    },

    Gep {
        dst: Reg,
        base: Reg,
        index: IndexOperand,
        scale: i64,
    },

    Cmp {
        size: RegSize,
        lhs: Reg,
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

        let add_reg = |s: &mut HashSet<usize>, r: &Reg| {
            if let Reg::V(v) = r {
                s.insert(*v);
            }
        };

        let add_operand = |s: &mut HashSet<usize>, op: &Operand| {
            if let Operand::Reg(Reg::V(v)) = op {
                s.insert(*v);
            }
        };

        let add_addr = |s: &mut HashSet<usize>, addr: &Addr| {
            if let Addr::BaseOff {
                base: Reg::V(v), ..
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
                if let Reg::V(v) = dst {
                    defined.insert(*v);
                }
            }
            _ => {}
        }
        defined
    }
}
