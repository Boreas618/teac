//! AArch64 (ARM64) code generation backend.
//!
//! Provides instruction selection, register allocation integration, and
//! assembly emission for the AArch64 architecture.

mod asm_printer;
mod function_generator;
mod inst;
mod register_allocator;
mod types;

// Re-export types for internal use within the aarch64 module
pub(crate) use inst::Inst;
pub(crate) use types::{Addr, BinOp, Cond, Operand, Reg};

use crate::asm::common::{
    collect_alloca_ptrs, compute_struct_layouts, size_align_of_alloca,
    size_align_of_dtype, StackFrame, StructLayouts, VReg, VRegKind,
};
use crate::asm::error::Error;
use crate::asm::AsmGenerator;
use crate::ir;
use asm_printer::{AsmPrint, AsmPrinter};
use function_generator::FunctionGenerator;
use register_allocator::rewrite_insts;
use std::collections::HashMap;
use std::io::Write;
use types::dtype_to_regsize;

// =============================================================================
// AArch64 Code Generator
// =============================================================================

/// AArch64 assembly code generator.
pub struct AArch64AsmGenerator<'a> {
    module: &'a ir::Module,
    registry: &'a ir::Registry,
}

impl<'a> AArch64AsmGenerator<'a> {
    pub fn new(module: &'a ir::Module, registry: &'a ir::Registry) -> Self {
        Self { module, registry }
    }
}

impl<'a> AsmGenerator for AArch64AsmGenerator<'a> {
    fn output<W: Write>(&self, w: &mut W) -> Result<(), Error> {
        let layouts: StructLayouts = compute_struct_layouts(&self.registry.struct_types)?;

        if !self.module.global_list.is_empty() {
            writeln!(w, ".data")?;
            for g in self.module.global_list.values() {
                Self::gen_global(w, &layouts, g)?;
            }
            writeln!(w)?;
        }

        writeln!(w, ".text")?;
        for func in self.module.function_list.values() {
            if func.blocks.is_some() {
                Self::gen_function(w, &layouts, func)?;
                writeln!(w)?;
            }
        }
        Ok(())
    }
}

impl<'a> AArch64AsmGenerator<'a> {
    fn gen_arg_moves(func: &ir::Function) -> Result<Vec<Inst>, Error> {
        let mut insts = Vec::new();

        for (i, arg) in func.arguments.iter().enumerate() {
            let v = VReg(arg.index as u32);
            let size = dtype_to_regsize(&arg.dtype)?;

            if i < 8 {
                // First 8 args in registers x0-x7.
                insts.push(Inst::Mov {
                    size,
                    dst: Reg::V(v),
                    src: Operand::Reg(Reg::P(i as u8)),
                });
            } else {
                // Stack args at [fp + 16 + (i-8)*8].
                let offset = 16 + ((i - 8) as i64) * 8;
                insts.push(Inst::Ldr {
                    size,
                    dst: Reg::V(v),
                    addr: Addr::BaseOff {
                        base: Reg::P(29),
                        offset,
                    },
                });
            }
        }

        Ok(insts)
    }

    fn gen_global<W: Write>(
        w: &mut W,
        layouts: &StructLayouts,
        g: &ir::GlobalVariable,
    ) -> Result<(), Error> {
        let sym = g.identifier.clone();

        match &g.dtype {
            ir::Dtype::I32 => {
                let init = g
                    .initializers
                    .as_ref()
                    .and_then(|v| v.first())
                    .copied()
                    .unwrap_or(0);
                writeln!(w, ".globl {sym}")?;
                writeln!(w, ".p2align 2")?;
                writeln!(w, "{sym}:")?;
                writeln!(w, "\t.word {init}")?;
            }
            ir::Dtype::Pointer { inner, length } => {
                let len = if *length == usize::MAX { 0 } else { *length };
                if len == 0 {
                    return Err(Error::UnsupportedDtype {
                        dtype: g.dtype.clone(),
                    });
                }

                let (elem_size, _) = size_align_of_dtype(inner.as_ref(), layouts)?;
                let total_bytes = (len as i64) * elem_size;

                writeln!(w, ".globl {sym}")?;
                writeln!(w, ".p2align 2")?;
                writeln!(w, "{sym}:")?;

                if let Some(inits) = &g.initializers {
                    for v in inits.iter().take(len) {
                        writeln!(w, "\t.word {v}")?;
                    }
                    let remaining = len.saturating_sub(inits.len());
                    if remaining > 0 {
                        writeln!(w, "\t.zero {}", (remaining as i64) * elem_size)?;
                    }
                } else {
                    writeln!(w, "\t.zero {total_bytes}")?;
                }
            }
            _ => {
                return Err(Error::UnsupportedDtype {
                    dtype: g.dtype.clone(),
                })
            }
        }
        Ok(())
    }

    fn gen_function<W: Write>(
        w: &mut W,
        layouts: &StructLayouts,
        func: &ir::Function,
    ) -> Result<(), Error> {
        let Some(blocks) = &func.blocks else {
            return Ok(());
        };

        let mut frame = StackFrame::default();
        let alloca_ptrs = collect_alloca_ptrs(blocks)?;
        for (vreg, dtype) in alloca_ptrs.iter() {
            let (size, align) = size_align_of_alloca(dtype, layouts)?;
            frame.alloc_alloca(*vreg, align, size);
        }

        let mut vreg_kinds: HashMap<VReg, VRegKind> = HashMap::new();
        for arg in func.arguments.iter() {
            let kind = match &arg.dtype {
                ir::Dtype::I32 => VRegKind::Int32,
                ir::Dtype::Pointer { .. } => VRegKind::Ptr64,
                _ => {
                    return Err(Error::UnsupportedDtype {
                        dtype: arg.dtype.clone(),
                    })
                }
            };
            vreg_kinds.insert(VReg(arg.index as u32), kind);
        }

        let mut cond_map: HashMap<VReg, Cond> = HashMap::new();
        let mut insts: Vec<Inst> = Vec::new();

        insts.extend(Self::gen_arg_moves(func)?);

        let mut ctx = FunctionGenerator {
            func_id: &func.identifier,
            frame: &frame,
            layouts,
            insts: &mut insts,
            vreg_kinds: &mut vreg_kinds,
            cond_map: &mut cond_map,
        };

        for block in blocks.iter() {
            for stmt in block.iter() {
                use ir::stmt::StmtInner::*;
                match &stmt.inner {
                    Label(l) => ctx.gen_label(l),
                    Alloca(_) => { /* Stack slots handled by frame layout */ }
                    Store(s) => ctx.gen_store(s)?,
                    Load(s) => ctx.gen_load(s)?,
                    BiOp(s) => ctx.gen_biop(s)?,
                    Cmp(s) => ctx.gen_cmp(s)?,
                    CJump(s) => ctx.gen_cjump(s)?,
                    Jump(s) => ctx.gen_jump(s),
                    Gep(s) => ctx.gen_gep(s)?,
                    Call(s) => ctx.gen_call(s)?,
                    Return(s) => ctx.gen_return(s)?,
                }
            }
        }

        let alloc = register_allocator::allocate(&insts);

        for v in alloc.spilled.iter().copied() {
            frame.alloc_spill(v, 8, 8);
        }

        let insts_final = rewrite_insts(&insts, &alloc, &frame, &vreg_kinds)?;

        let sym = func.identifier.clone();
        let mut printer = AsmPrinter::new(w);
        printer.emit_global(&sym)?;
        printer.emit_align(2)?;
        printer.emit_label(&sym)?;
        let frame_size = frame.frame_size_aligned();
        printer.emit_prologue(frame_size)?;
        printer.emit_insts(&insts_final)?;

        Ok(())
    }
}
