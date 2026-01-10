//! Function code generation for AArch64.
//!
//! This module provides instruction selection from IR to abstract machine
//! instructions (pre-register-allocation). The main entry point is
//! [`FunctionGenerator`], which processes IR statements and emits [`Inst`].
//!
//! # Architecture
//!
//! - **Instruction Generation** (`gen_*` methods): Convert IR statements to machine instructions
//! - **Operand Lowering** (`lower_*` methods): Convert IR operands to machine operands
//! - **Virtual Registers**: Fresh vregs are allocated via [`FunctionGenerator::fresh_vreg`]
//!
//! # Usage
//!
//! ```ignore
//! let mut gen = FunctionGenerator::new(...);
//! for stmt in ir_statements {
//!     gen.gen_stmt(stmt)?;
//! }
//! let insts = gen.into_insts();
//! ```

use super::inst::Inst;
use super::types::{Addr, BinOp, Cond, IndexOperand, Operand, Reg, RegSize};
use crate::asm::common::{
    align_up, size_align_of_dtype, vreg_from_value, StackFrame, StackSlot, StructLayouts, VReg,
    VRegKind,
};
use crate::asm::error::Error;
use crate::ast;
use crate::ir;
use std::collections::HashMap;

fn mangle_bb(func: &str, bb: usize) -> String {
    format!(".L{func}_bb{bb}")
}

// =============================================================================
// Pointer Classification
// =============================================================================

/// Pointer base classification for address lowering.
///
/// This enum categorizes pointer operands based on their origin,
/// which determines how they should be addressed in generated code.
#[derive(Debug, Clone)]
pub(crate) enum PtrBase {
    /// Stack-allocated via alloca. Requires `StackSlot` for the offset.
    Stack,
    /// Global symbol reference.
    Global(String),
    /// Pointer value held in a virtual register.
    Reg(VReg),
}

// =============================================================================
// Function Generator
// =============================================================================

pub struct FunctionGenerator<'a> {
    pub func_id: &'a str,
    pub frame: &'a StackFrame,
    pub layouts: &'a StructLayouts,
    pub insts: &'a mut Vec<Inst>,
    pub vreg_kinds: &'a mut HashMap<VReg, VRegKind>,
    pub cond_map: &'a mut HashMap<VReg, Cond>,
}

impl<'a> FunctionGenerator<'a> {
    pub fn fresh_vreg(&mut self, kind: VRegKind) -> VReg {
        let next = self.vreg_kinds.keys().map(|v| v.0).max().unwrap_or(100) + 1;
        let v = VReg(next);
        self.vreg_kinds.insert(v, kind);
        v
    }

    pub fn gen_label(&mut self, l: &ir::stmt::LabelStmt) {
        if let ir::BlockLabel::BasicBlock(n) = &l.label {
            self.insts.push(Inst::Label(mangle_bb(self.func_id, *n)));
        }
    }

    pub fn gen_store(&mut self, s: &ir::stmt::StoreStmt) -> Result<(), Error> {
        let (src, src_kind) = self.lower_value(&s.src)?;
        let addr = self.lower_ptr_as_addr(&s.ptr)?;
        let size = vreg_kind_to_size(src_kind);

        match src {
            Operand::Reg(r) => {
                self.insts.push(Inst::Str { size, src: r, addr });
            }
            Operand::Imm(imm) => {
                let tmp = self.fresh_vreg(src_kind);
                self.insts.push(Inst::Mov {
                    size,
                    dst: Reg::V(tmp),
                    src: Operand::Imm(imm),
                });
                self.insts.push(Inst::Str {
                    size,
                    src: Reg::V(tmp),
                    addr,
                });
            }
        }
        Ok(())
    }

    pub fn gen_load(&mut self, s: &ir::stmt::LoadStmt) -> Result<(), Error> {
        let dst = vreg_from_value(&s.dst)?;

        // Determine register size based on destination type
        let (kind, size) = match s.dst.dtype() {
            ir::Dtype::I32 => (VRegKind::Int32, RegSize::W32),
            ir::Dtype::Pointer { .. } => (VRegKind::Ptr64, RegSize::X64),
            _ => (VRegKind::Int32, RegSize::W32),
        };
        self.vreg_kinds.insert(dst, kind);

        let addr = self.lower_ptr_as_addr(&s.ptr)?;
        self.insts.push(Inst::Ldr {
            size,
            dst: Reg::V(dst),
            addr,
        });
        Ok(())
    }

    pub fn gen_biop(&mut self, s: &ir::stmt::BiOpStmt) -> Result<(), Error> {
        let dst = vreg_from_value(&s.dst)?;
        self.vreg_kinds.insert(dst, VRegKind::Int32);

        let lhs = self.lower_int_to_reg(&s.left)?;
        let rhs = self.lower_int(&s.right)?;
        let op = arith_op_to_binop(&s.kind);

        self.insts.push(Inst::BinOp {
            op,
            size: RegSize::W32,
            dst: Reg::V(dst),
            lhs,
            rhs,
        });
        Ok(())
    }

    /// Records condition code for use by subsequent conditional jumps.
    pub fn gen_cmp(&mut self, s: &ir::stmt::CmpStmt) -> Result<(), Error> {
        let dst = vreg_from_value(&s.dst)?;
        let lhs = self.lower_int_to_reg(&s.left)?;
        let rhs = self.lower_int(&s.right)?;
        let cond = cmp_op_to_cond(&s.kind);

        self.cond_map.insert(dst, cond);
        self.insts.push(Inst::Cmp {
            size: RegSize::W32,
            lhs,
            rhs,
        });
        Ok(())
    }

    pub fn gen_cjump(&mut self, s: &ir::stmt::CJumpStmt) -> Result<(), Error> {
        let cond_v = vreg_from_value(&s.dst)?;
        let cond = *self
            .cond_map
            .get(&cond_v)
            .ok_or_else(|| Error::MissingCond { vreg: cond_v.0 })?;

        let true_label = self.mangle_block_label(&s.true_label);
        let false_label = self.mangle_block_label(&s.false_label);

        self.insts.push(Inst::BCond {
            cond,
            label: true_label,
        });
        self.insts.push(Inst::B { label: false_label });
        Ok(())
    }

    pub fn gen_jump(&mut self, s: &ir::stmt::JumpStmt) {
        let target = self.mangle_block_label(&s.target);
        self.insts.push(Inst::B { label: target });
    }

    pub fn gen_gep(&mut self, s: &ir::stmt::GepStmt) -> Result<(), Error> {
        let new_ptr = vreg_from_value(&s.new_ptr)?;
        self.vreg_kinds.insert(new_ptr, VRegKind::Ptr64);

        let (base_kind, base_slot) = self.lower_ptr(&s.base_ptr)?;

        match s.base_ptr.dtype() {
            ir::Dtype::Pointer { inner, length } => {
                // For scalar pointer (length == 0): check if struct for member access
                if *length == 0 {
                    if let ir::Dtype::Struct { type_name } = inner.as_ref() {
                        return self
                            .gen_gep_struct(new_ptr, &s.index, type_name, base_kind, base_slot);
                    }
                }
                self.gen_gep_array(new_ptr, &s.index, inner.as_ref(), base_kind, base_slot)
            }
            other => Err(Error::UnsupportedDtype {
                dtype: other.clone(),
            }),
        }
    }

    pub fn gen_call(&mut self, s: &ir::stmt::CallStmt) -> Result<(), Error> {
        self.insts.push(Inst::SaveCallerRegs);

        let nargs = s.args.len();
        if nargs > 8 {
            let stack_bytes = align_up(((nargs - 8) as i64) * 8, 16);
            self.insts.push(Inst::SubSp { imm: stack_bytes });

            for (i, arg) in s.args.iter().enumerate().skip(8) {
                self.gen_call_stack_arg(arg, ((i - 8) as i64) * 8)?;
            }
        }

        for (i, arg) in s.args.iter().enumerate().take(8) {
            self.gen_call_reg_arg(arg, i as u8)?;
        }

        self.insts.push(Inst::Bl {
            func: s.func_name.clone(),
        });

        if nargs > 8 {
            let stack_bytes = align_up(((nargs - 8) as i64) * 8, 16);
            self.insts.push(Inst::AddSp { imm: stack_bytes });
        }

        self.insts.push(Inst::RestoreCallerRegs);

        if let Some(res) = &s.res {
            self.gen_call_result(res.as_local().unwrap())?;
        }
        Ok(())
    }

    pub fn gen_return(&mut self, s: &ir::stmt::ReturnStmt) -> Result<(), Error> {
        if let Some(v) = &s.val {
            let (op, kind) = self.lower_value(v)?;
            let size = vreg_kind_to_size(kind);
            self.insts.push(Inst::Mov {
                size,
                dst: Reg::P(0),
                src: op,
            });
        }
        self.insts.push(Inst::Ret);
        Ok(())
    }

    fn gen_gep_struct(
        &mut self,
        new_ptr: VReg,
        idx: &ir::Operand,
        type_name: &str,
        base_kind: PtrBase,
        base_slot: Option<StackSlot>,
    ) -> Result<(), Error> {
        let field_index = self.lower_index_imm(idx)?;
        let layout = self
            .layouts
            .get(type_name)
            .ok_or_else(|| Error::MissingStructLayout {
                name: type_name.to_string(),
            })?;

        let fi = field_index as usize;
        if fi >= layout.field_offsets.len() {
            return Err(Error::InvalidStructFieldIndex {
                name: type_name.to_string(),
                index: field_index,
            });
        }
        let offset = layout.field_offsets[fi];

        self.emit_ptr_offset(new_ptr, base_kind, base_slot, offset)
    }

    fn gen_gep_array(
        &mut self,
        new_ptr: VReg,
        idx: &ir::Operand,
        inner: &ir::Dtype,
        base_kind: PtrBase,
        base_slot: Option<StackSlot>,
    ) -> Result<(), Error> {
        let (elem_size, _) = size_align_of_dtype(inner, self.layouts)?;
        let index = self.lower_index(idx)?;

        match (base_kind, base_slot) {
            (PtrBase::Stack, Some(slot)) => {
                self.insts.push(Inst::Lea {
                    dst: Reg::V(new_ptr),
                    addr: Addr::BaseOff {
                        base: Reg::P(29),
                        offset: slot.offset_from_fp,
                    },
                });
                self.insts.push(Inst::Gep {
                    dst: Reg::V(new_ptr),
                    base: Reg::V(new_ptr),
                    index,
                    scale: elem_size,
                });
            }
            (PtrBase::Stack, None) => {
                return Err(Error::Internal(
                    "missing stack slot for stack pointer".into(),
                ));
            }
            (PtrBase::Global(sym), _) => {
                self.insts.push(Inst::Lea {
                    dst: Reg::V(new_ptr),
                    addr: Addr::Global(sym),
                });
                self.insts.push(Inst::Gep {
                    dst: Reg::V(new_ptr),
                    base: Reg::V(new_ptr),
                    index,
                    scale: elem_size,
                });
            }
            (PtrBase::Reg(base_v), _) => {
                self.insts.push(Inst::Gep {
                    dst: Reg::V(new_ptr),
                    base: Reg::V(base_v),
                    index,
                    scale: elem_size,
                });
            }
        }
        Ok(())
    }

    fn emit_ptr_offset(
        &mut self,
        dst: VReg,
        base_kind: PtrBase,
        base_slot: Option<StackSlot>,
        offset: i64,
    ) -> Result<(), Error> {
        match (base_kind, base_slot) {
            (PtrBase::Stack, Some(slot)) => {
                self.insts.push(Inst::Lea {
                    dst: Reg::V(dst),
                    addr: Addr::BaseOff {
                        base: Reg::P(29),
                        offset: slot.offset_from_fp + offset,
                    },
                });
            }
            (PtrBase::Stack, None) => {
                return Err(Error::Internal(
                    "missing stack slot for stack pointer".into(),
                ));
            }
            (PtrBase::Global(sym), _) => {
                self.insts.push(Inst::Lea {
                    dst: Reg::V(dst),
                    addr: Addr::Global(sym),
                });
                if offset != 0 {
                    self.insts.push(Inst::BinOp {
                        op: BinOp::Add,
                        size: RegSize::X64,
                        dst: Reg::V(dst),
                        lhs: Reg::V(dst),
                        rhs: Operand::Imm(offset),
                    });
                }
            }
            (PtrBase::Reg(base_v), _) => {
                self.insts.push(Inst::Lea {
                    dst: Reg::V(dst),
                    addr: Addr::BaseOff {
                        base: Reg::V(base_v),
                        offset,
                    },
                });
            }
        }
        Ok(())
    }

    fn gen_call_stack_arg(&mut self, arg: &ir::Operand, stack_offset: i64) -> Result<(), Error> {
        if matches!(arg.dtype(), ir::Dtype::Pointer { .. }) {
            self.emit_ptr_to_reg(arg, Reg::P(16))?;
            self.insts.push(Inst::Str {
                size: RegSize::X64,
                src: Reg::P(16),
                addr: Addr::BaseOff {
                    base: Reg::SP,
                    offset: stack_offset,
                },
            });
        } else {
            let (op, _kind) = self.lower_value(arg)?;
            match op {
                Operand::Imm(imm) => {
                    self.insts.push(Inst::Mov {
                        size: RegSize::W32,
                        dst: Reg::P(16),
                        src: Operand::Imm(imm),
                    });
                    self.insts.push(Inst::Str {
                        size: RegSize::W32,
                        src: Reg::P(16),
                        addr: Addr::BaseOff {
                            base: Reg::SP,
                            offset: stack_offset,
                        },
                    });
                }
                Operand::Reg(r) => {
                    self.insts.push(Inst::Str {
                        size: RegSize::W32,
                        src: r,
                        addr: Addr::BaseOff {
                            base: Reg::SP,
                            offset: stack_offset,
                        },
                    });
                }
            }
        }
        Ok(())
    }

    fn gen_call_reg_arg(&mut self, arg: &ir::Operand, reg_idx: u8) -> Result<(), Error> {
        if matches!(arg.dtype(), ir::Dtype::Pointer { .. }) {
            self.emit_ptr_to_reg(arg, Reg::P(reg_idx))?;
        } else {
            let (op, _kind) = self.lower_value(arg)?;
            self.insts.push(Inst::Mov {
                size: RegSize::W32,
                dst: Reg::P(reg_idx),
                src: op,
            });
        }
        Ok(())
    }

    fn gen_call_result(&mut self, res: &ir::LocalVariable) -> Result<(), Error> {
        let dst = VReg(res.index as u32);
        match &res.dtype {
            ir::Dtype::I32 => {
                self.vreg_kinds.insert(dst, VRegKind::Int32);
                self.insts.push(Inst::Mov {
                    size: RegSize::W32,
                    dst: Reg::V(dst),
                    src: Operand::Reg(Reg::P(0)),
                });
                Ok(())
            }
            other => Err(Error::UnsupportedDtype {
                dtype: other.clone(),
            }),
        }
    }

    fn emit_ptr_to_reg(&mut self, arg: &ir::Operand, dst: Reg) -> Result<(), Error> {
        let (base_kind, slot) = self.lower_ptr(arg)?;
        match base_kind {
            PtrBase::Reg(v) => {
                self.insts.push(Inst::Mov {
                    size: RegSize::X64,
                    dst,
                    src: Operand::Reg(Reg::V(v)),
                });
            }
            PtrBase::Stack => {
                let slot = slot.ok_or_else(|| Error::Internal("missing stack slot".into()))?;
                self.insts.push(Inst::Lea {
                    dst,
                    addr: Addr::BaseOff {
                        base: Reg::P(29),
                        offset: slot.offset_from_fp,
                    },
                });
            }
            PtrBase::Global(sym) => {
                self.insts.push(Inst::Lea {
                    dst,
                    addr: Addr::Global(sym),
                });
            }
        }
        Ok(())
    }

    fn lower_int(&self, val: &ir::Operand) -> Result<Operand, Error> {
        match val {
            ir::Operand::Integer(i) => Ok(Operand::Imm(i.value as i64)),
            ir::Operand::Local(l) => {
                if !matches!(l.dtype, ir::Dtype::I32) {
                    return Err(Error::UnsupportedDtype {
                        dtype: l.dtype.clone(),
                    });
                }
                if self.frame.has_alloca(VReg(l.index as u32)) {
                    return Err(Error::UnsupportedOperand {
                        what: format!("int operand references alloca pointer %r{}", l.index),
                    });
                }
                Ok(Operand::Reg(Reg::V(VReg(l.index as u32))))
            }
            ir::Operand::Global(_) => Err(Error::UnsupportedOperand {
                what: format!("unsupported int operand: {}", val),
            }),
        }
    }

    fn lower_int_to_reg(&mut self, val: &ir::Operand) -> Result<Reg, Error> {
        match self.lower_int(val)? {
            Operand::Reg(r) => Ok(r),
            Operand::Imm(imm) => {
                let tmp = self.fresh_vreg(VRegKind::Int32);
                self.insts.push(Inst::Mov {
                    size: RegSize::W32,
                    dst: Reg::V(tmp),
                    src: Operand::Imm(imm),
                });
                Ok(Reg::V(tmp))
            }
        }
    }

    fn lower_value(&self, val: &ir::Operand) -> Result<(Operand, VRegKind), Error> {
        match val {
            ir::Operand::Integer(i) => Ok((Operand::Imm(i.value as i64), VRegKind::Int32)),
            ir::Operand::Local(l) => {
                let kind = match &l.dtype {
                    ir::Dtype::I32 => VRegKind::Int32,
                    ir::Dtype::Pointer { .. } => {
                        if self.frame.has_alloca(VReg(l.index as u32)) {
                            return Err(Error::UnsupportedOperand {
                                what: format!(
                                    "value operand uses alloca pointer %r{} directly (need address-of)",
                                    l.index
                                ),
                            });
                        }
                        VRegKind::Ptr64
                    }
                    other => {
                        return Err(Error::UnsupportedDtype {
                            dtype: other.clone(),
                        })
                    }
                };
                Ok((Operand::Reg(Reg::V(VReg(l.index as u32))), kind))
            }
            ir::Operand::Global(_) => Err(Error::UnsupportedOperand {
                what: "unexpected global variable in value position".into(),
            }),
        }
    }

    fn lower_ptr_as_addr(&self, val: &ir::Operand) -> Result<Addr, Error> {
        let (base_kind, slot) = self.lower_ptr(val)?;
        match base_kind {
            PtrBase::Stack => {
                let slot = slot.ok_or_else(|| Error::Internal("missing stack slot".into()))?;
                Ok(Addr::BaseOff {
                    base: Reg::P(29),
                    offset: slot.offset_from_fp,
                })
            }
            PtrBase::Global(sym) => Ok(Addr::Global(sym)),
            PtrBase::Reg(v) => Ok(Addr::BaseOff {
                base: Reg::V(v),
                offset: 0,
            }),
        }
    }

    fn lower_ptr(&self, val: &ir::Operand) -> Result<(PtrBase, Option<StackSlot>), Error> {
        match val {
            ir::Operand::Local(l) => {
                let v = VReg(l.index as u32);
                if let Some(slot) = self.frame.alloca_slot(v) {
                    return Ok((PtrBase::Stack, Some(slot)));
                }
                if matches!(l.dtype, ir::Dtype::Pointer { .. }) {
                    return Ok((PtrBase::Reg(v), None));
                }
                Err(Error::UnsupportedDtype {
                    dtype: l.dtype.clone(),
                })
            }
            ir::Operand::Global(g) => Ok((PtrBase::Global(g.identifier.clone()), None)),
            ir::Operand::Integer(_) => Err(Error::UnsupportedOperand {
                what: format!("unsupported pointer operand: {}", val),
            }),
        }
    }

    fn lower_index(&self, val: &ir::Operand) -> Result<IndexOperand, Error> {
        match val {
            ir::Operand::Integer(i) => Ok(IndexOperand::Imm(i.value as i64)),
            ir::Operand::Local(l) => {
                if !matches!(l.dtype, ir::Dtype::I32) {
                    return Err(Error::UnsupportedDtype {
                        dtype: l.dtype.clone(),
                    });
                }
                if self.frame.has_alloca(VReg(l.index as u32)) {
                    return Err(Error::UnsupportedOperand {
                        what: format!("index operand references alloca pointer %r{}", l.index),
                    });
                }
                Ok(IndexOperand::Reg(Reg::V(VReg(l.index as u32))))
            }
            ir::Operand::Global(_) => Err(Error::UnsupportedOperand {
                what: format!("unsupported index operand: {}", val),
            }),
        }
    }

    fn lower_index_imm(&self, val: &ir::Operand) -> Result<i64, Error> {
        match val {
            ir::Operand::Integer(i) => Ok(i.value as i64),
            _ => Err(Error::UnsupportedOperand {
                what: format!("expected immediate struct field index, got: {}", val),
            }),
        }
    }

    fn mangle_block_label(&self, label: &ir::BlockLabel) -> String {
        match label {
            ir::BlockLabel::BasicBlock(n) => mangle_bb(self.func_id, *n),
            ir::BlockLabel::Function(name) => name.clone(),
        }
    }
}

fn vreg_kind_to_size(kind: VRegKind) -> RegSize {
    match kind {
        VRegKind::Int32 => RegSize::W32,
        VRegKind::Ptr64 => RegSize::X64,
    }
}

fn arith_op_to_binop(op: &ast::ArithBiOp) -> BinOp {
    match op {
        ast::ArithBiOp::Add => BinOp::Add,
        ast::ArithBiOp::Sub => BinOp::Sub,
        ast::ArithBiOp::Mul => BinOp::Mul,
        ast::ArithBiOp::Div => BinOp::SDiv,
    }
}

fn cmp_op_to_cond(op: &ast::ComOp) -> Cond {
    match op {
        ast::ComOp::Eq => Cond::Eq,
        ast::ComOp::Ne => Cond::Ne,
        ast::ComOp::Lt => Cond::Lt,
        ast::ComOp::Le => Cond::Le,
        ast::ComOp::Gt => Cond::Gt,
        ast::ComOp::Ge => Cond::Ge,
    }
}
