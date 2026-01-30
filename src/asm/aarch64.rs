mod asm_printer;
mod function_generator;
mod inst;
mod register_allocator;
mod types;

pub(crate) use inst::Inst;
pub(crate) use types::{Addr, BinOp, Cond, Operand, Reg};

use crate::asm::common::{
    collect_alloca_ptrs, eliminate_phis, size_align_of_alloca, StackFrame, StructLayouts,
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

struct GeneratedGlobal {
    symbol: String,
    data: GlobalData,
}

enum GlobalData {
    // review: the types are hardcoded; array only supports i64?


    Word { value: i64 },
    Array { words: Vec<i64>, zero_bytes: i64 },
}

struct GeneratedFunction {
    symbol: String,
    frame_size: i64,
    insts: Vec<Inst>,
}

pub struct AArch64AsmGenerator<'a> {
    module: &'a ir::Module,
    registry: &'a ir::Registry,
    globals: Vec<GeneratedGlobal>,
    functions: Vec<GeneratedFunction>,
}

impl<'a> AArch64AsmGenerator<'a> {
    pub fn new(module: &'a ir::Module, registry: &'a ir::Registry) -> Self {
        Self {
            module,
            registry,
            globals: Vec::new(),
            functions: Vec::new(),
        }
    }
}

impl<'a> AsmGenerator for AArch64AsmGenerator<'a> {
    fn generate(&mut self) -> Result<(), Error> {
        let layouts = StructLayouts::from_struct_types(&self.registry.struct_types)?;

        self.globals.clear();
        for g in self.module.global_list.values() {
            self.globals.push(Self::handle_global(&layouts, g)?);
        }

        self.functions.clear();
        for func in self.module.function_list.values() {
            self.functions.push(Self::handle_function(&layouts, func)?);
        }

        Ok(())
    }

    fn output<W: Write>(&self, w: &mut W) -> Result<(), Error> {
        if !self.globals.is_empty() {
            writeln!(w, ".data")?;
            for g in &self.globals {
                Self::output_global(w, g)?;
            }
            writeln!(w)?;
        }

        writeln!(w, ".text")?;
        for func in &self.functions {
            Self::output_function(w, func)?;
            writeln!(w)?;
        }
        Ok(())
    }
}

impl<'a> AArch64AsmGenerator<'a> {
    fn gen_arg_moves(func: &ir::Function) -> Result<Vec<Inst>, Error> {
        let mut insts = Vec::new();

        for (i, arg) in func.arguments.iter().enumerate() {
            let v = arg.index;
            let size = dtype_to_regsize(&arg.dtype)?;

            if i < 8 {
                insts.push(Inst::Mov {
                    size,
                    dst: Reg::V(v),
                    src: Operand::Reg(Reg::P(i as u8)),
                });
            } else {
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

    fn handle_global(layouts: &StructLayouts, g: &ir::GlobalVariable) -> Result<GeneratedGlobal, Error> {
        let symbol = g.identifier.clone();


        // see review in GlobalData
        let data = match &g.dtype {
            ir::Dtype::I32 => {
                let value = g
                    .initializers
                    .as_ref()
                    .and_then(|v| v.first())
                    .copied()
                    .map(|v| v as i64)
                    .unwrap_or(0);
                GlobalData::Word { value }
            }
            ir::Dtype::Pointer { inner, length } => {
                if *length == 0 {
                    return Err(Error::UnsupportedDtype {
                        dtype: g.dtype.clone(),
                    });
                }
                let len = *length;

                let (elem_size, _) = layouts.size_align_of(inner.as_ref())?;

                if let Some(inits) = &g.initializers {
                    let words: Vec<i64> = inits.iter().take(len).map(|&v| v as i64).collect();
                    let remaining = len.saturating_sub(inits.len());
                    let zero_bytes = (remaining as i64) * elem_size;
                    GlobalData::Array { words, zero_bytes }
                } else {
                    let zero_bytes = (len as i64) * elem_size;
                    GlobalData::Array {
                        words: Vec::new(),
                        zero_bytes,
                    }
                }
            }
            _ => {
                return Err(Error::UnsupportedDtype {
                    dtype: g.dtype.clone(),
                })
            }
        };

        Ok(GeneratedGlobal { symbol, data })
    }

    fn output_global<W: Write>(w: &mut W, g: &GeneratedGlobal) -> Result<(), Error> {
        writeln!(w, ".globl {}", g.symbol)?;
        writeln!(w, ".p2align 2")?;
        writeln!(w, "{}:", g.symbol)?;
        match &g.data {
            GlobalData::Word { value } => {
                writeln!(w, "\t.word {value}")?;
            }
            GlobalData::Array { words, zero_bytes } => {
                for v in words {
                    writeln!(w, "\t.word {v}")?;
                }
                if *zero_bytes > 0 {
                    writeln!(w, "\t.zero {zero_bytes}")?;
                }
            }
        }
        Ok(())
    }

    fn handle_function(
        layouts: &StructLayouts,
        func: &ir::Function,
    ) -> Result<GeneratedFunction, Error> {
        let Some(blocks) = eliminate_phis(func) else {
            return Ok(GeneratedFunction {
                symbol: func.identifier.clone(),
                frame_size: 0,
                insts: Vec::new(),
            });
        };
        let blocks = &blocks;

        let mut frame = StackFrame::default();
        let alloca_ptrs = collect_alloca_ptrs(blocks)?;
        for (vreg, dtype) in alloca_ptrs.iter() {
            let (size, align) = size_align_of_alloca(dtype, layouts)?;
            frame.alloc_alloca(*vreg, align, size);
        }

        let mut next_vreg = func.next_vreg;

        let mut cond_map: HashMap<usize, Cond> = HashMap::new();
        let mut insts: Vec<Inst> = Vec::new();

        insts.extend(Self::gen_arg_moves(func)?);

        let mut ctx = FunctionGenerator {
            func_id: &func.identifier,
            frame: &frame,
            layouts,
            insts: &mut insts,
            next_vreg: &mut next_vreg,
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
                    Phi(_) => {
                        return Err(Error::Internal(
                            "phi node reached codegen without lowering".into(),
                        ))
                    }
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

        let insts = rewrite_insts(&insts, &alloc, &frame)?;
        let frame_size = frame.frame_size_aligned();

        Ok(GeneratedFunction {
            symbol: func.identifier.clone(),
            frame_size,
            insts,
        })
    }

    fn output_function<W: Write>(w: &mut W, func: &GeneratedFunction) -> Result<(), Error> {
        let mut printer = AsmPrinter::new(w);
        printer.emit_global(&func.symbol)?;
        printer.emit_align(2)?;
        printer.emit_label(&func.symbol)?;
        printer.emit_prologue(func.frame_size)?;
        printer.emit_insts(&func.insts)?;
        Ok(())
    }
}
