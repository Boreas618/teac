use std::io::Write;

use super::inst::Inst;
use super::types::{Addr, BinOp, Cond, IndexOperand, Operand, Reg, RegSize};
use crate::asm::error::Error;

pub trait AsmPrint {
    fn emit_inst(&mut self, inst: &Inst) -> Result<(), Error>;

    fn emit_insts(&mut self, insts: &[Inst]) -> Result<(), Error> {
        for inst in insts {
            self.emit_inst(inst)?;
        }
        Ok(())
    }

    fn emit_sub_sp(&mut self, imm: i64) -> Result<(), Error>;

    #[allow(dead_code)]
    fn emit_raw(&mut self, line: &str) -> Result<(), Error>;

    fn emit_global(&mut self, sym: &str) -> Result<(), Error>;

    fn emit_align(&mut self, power: u32) -> Result<(), Error>;

    fn emit_label(&mut self, name: &str) -> Result<(), Error>;

    fn emit_prologue(&mut self, frame_size: i64) -> Result<(), Error>;
}

pub struct AsmPrinter<W: Write> {
    writer: W,
}

impl<W: Write> AsmPrinter<W> {
    pub fn new(writer: W) -> Self {
        Self { writer }
    }

    #[allow(dead_code)]
    pub fn into_inner(self) -> W {
        self.writer
    }

    #[allow(dead_code)]
    pub fn writer_mut(&mut self) -> &mut W {
        &mut self.writer
    }

    fn reg_name(&self, r: Reg, size: RegSize) -> String {
        match r {
            Reg::SP => "sp".to_string(),
            Reg::P(31) => match size {
                RegSize::W32 => "wzr".to_string(),
                RegSize::X64 => "xzr".to_string(),
            },
            Reg::P(n) => match size {
                RegSize::W32 => format!("w{n}"),
                RegSize::X64 => format!("x{n}"),
            },
            Reg::V(_) => unreachable!("virtual regs should be eliminated before emission"),
        }
    }

    fn cond_suffix(&self, c: Cond) -> &'static str {
        match c {
            Cond::Eq => "eq",
            Cond::Ne => "ne",
            Cond::Lt => "lt",
            Cond::Le => "le",
            Cond::Gt => "gt",
            Cond::Ge => "ge",
        }
    }

    fn is_addsub_imm_encodable(&self, imm: i64) -> bool {
        if imm < 0 {
            return false;
        }
        if imm <= 4095 {
            return true;
        }
        // 12-bit shifted by 12 (multiple of 4096).
        imm % 4096 == 0 && (imm / 4096) <= 4095
    }

    fn is_mem_offset_encodable(&self, offset: i64) -> bool {
        // Signed 9-bit range (ldur/stur).
        (-256..=255).contains(&offset)
    }

    fn scale_to_shift(&self, scale: i64) -> Option<u8> {
        match scale {
            1 => Some(0),
            2 => Some(1),
            4 => Some(2),
            8 => Some(3),
            _ => None,
        }
    }

    fn emit_mov(&mut self, size: RegSize, dst: Reg, src: Operand) -> Result<(), Error> {
        let dst_s = self.reg_name(dst, size);
        match src {
            Operand::Imm(imm) => {
                writeln!(self.writer, "\tmov {dst_s}, #{imm}")?;
            }
            Operand::Reg(r) => {
                let src_s = self.reg_name(r, size);
                writeln!(self.writer, "\tmov {dst_s}, {src_s}")?;
            }
        }
        Ok(())
    }

    fn emit_binop(
        &mut self,
        op: BinOp,
        size: RegSize,
        dst: Reg,
        lhs: Reg,
        rhs: Operand,
    ) -> Result<(), Error> {
        let dst_s = self.reg_name(dst, size);
        let lhs_s = self.reg_name(lhs, size);

        match op {
            BinOp::Add | BinOp::Sub => {
                match rhs {
                    Operand::Imm(imm) => {
                        let (op_mn, imm_abs) = match (op, imm < 0) {
                            (BinOp::Add, true) => ("sub", -imm),
                            (BinOp::Sub, true) => ("add", -imm),
                            (BinOp::Add, false) => ("add", imm),
                            (BinOp::Sub, false) => ("sub", imm),
                            _ => unreachable!(),
                        };
                        if self.is_addsub_imm_encodable(imm_abs) {
                            writeln!(self.writer, "\t{op_mn} {dst_s}, {lhs_s}, #{imm_abs}")?;
                        } else {
                            // Use x16/w16 as scratch.
                            let scratch = self.reg_name(Reg::P(16), size);
                            self.emit_mov_imm(&scratch, imm_abs as u64)?;
                            writeln!(self.writer, "\t{op_mn} {dst_s}, {lhs_s}, {scratch}")?;
                        }
                    }
                    Operand::Reg(r) => {
                        let rhs_s = self.reg_name(r, size);
                        let op_mn = match op {
                            BinOp::Add => "add",
                            BinOp::Sub => "sub",
                            _ => unreachable!(),
                        };
                        writeln!(self.writer, "\t{op_mn} {dst_s}, {lhs_s}, {rhs_s}")?;
                    }
                }
            }
            BinOp::Mul => {
                let rhs_s = match rhs {
                    Operand::Reg(r) => self.reg_name(r, size),
                    Operand::Imm(imm) => {
                        let scratch = self.reg_name(Reg::P(16), size);
                        self.emit_mov_imm(&scratch, imm as u64)?;
                        scratch
                    }
                };
                writeln!(self.writer, "\tmul {dst_s}, {lhs_s}, {rhs_s}")?;
            }
            BinOp::SDiv => {
                let rhs_s = match rhs {
                    Operand::Reg(r) => self.reg_name(r, size),
                    Operand::Imm(imm) => {
                        let scratch = self.reg_name(Reg::P(16), size);
                        self.emit_mov_imm(&scratch, imm as u64)?;
                        scratch
                    }
                };
                writeln!(self.writer, "\tsdiv {dst_s}, {lhs_s}, {rhs_s}")?;
            }
        }

        Ok(())
    }

    fn emit_load(&mut self, size: RegSize, dst: Reg, addr: &Addr) -> Result<(), Error> {
        self.emit_mem_access("ldr", size, dst, addr)
    }

    fn emit_store(&mut self, size: RegSize, src: Reg, addr: &Addr) -> Result<(), Error> {
        self.emit_mem_access("str", size, src, addr)
    }

    fn emit_mem_access(
        &mut self,
        mnemonic: &str,
        size: RegSize,
        reg: Reg,
        addr: &Addr,
    ) -> Result<(), Error> {
        let reg_s = self.reg_name(reg, size);

        // Choose scratch register that doesn't conflict with the data register.
        let scratch = if matches!(reg, Reg::P(16)) { Reg::P(17) } else { Reg::P(16) };
        let scratch_s = self.reg_name(scratch, RegSize::X64);

        match addr {
            Addr::BaseOff { base, offset } => {
                let base_s = self.reg_name(*base, RegSize::X64);
                if *offset == 0 {
                    writeln!(self.writer, "\t{mnemonic} {reg_s}, [{base_s}]")?;
                } else if self.is_mem_offset_encodable(*offset) {
                    writeln!(self.writer, "\t{mnemonic} {reg_s}, [{base_s}, #{offset}]")?;
                } else {
                    self.emit_add_x_imm(scratch, *base, *offset)?;
                    writeln!(self.writer, "\t{mnemonic} {reg_s}, [{scratch_s}]")?;
                }
            }
            Addr::Global(sym) => {
                self.emit_adrp_add(scratch, sym)?;
                writeln!(self.writer, "\t{mnemonic} {reg_s}, [{scratch_s}]")?;
            }
        }
        Ok(())
    }

    fn emit_lea(&mut self, dst: Reg, addr: &Addr) -> Result<(), Error> {
        match addr {
            Addr::Global(sym) => self.emit_adrp_add(dst, sym),
            Addr::BaseOff { base, offset: 0 } => {
                writeln!(
                    self.writer,
                    "\tmov {}, {}",
                    self.reg_name(dst, RegSize::X64),
                    self.reg_name(*base, RegSize::X64)
                )?;
                Ok(())
            }
            Addr::BaseOff { base, offset } => self.emit_add_x_imm(dst, *base, *offset),
        }
    }

    /// dst = base + index * scale
    fn emit_gep(&mut self, dst: Reg, base: Reg, index: IndexOperand, scale: i64) -> Result<(), Error> {
        let dst_s = self.reg_name(dst, RegSize::X64);
        let base_s = self.reg_name(base, RegSize::X64);

        match index {
            IndexOperand::Imm(i) => {
                let off = i * scale;
                if off == 0 {
                    writeln!(self.writer, "\tmov {dst_s}, {base_s}")?;
                } else {
                    self.emit_add_x_imm(dst, base, off)?;
                }
            }
            IndexOperand::Reg(r) => {
                let idx_s = self.reg_name(r, RegSize::W32);

                // Optimize for power-of-two scales.
                if let Some(shift) = self.scale_to_shift(scale) {
                    writeln!(self.writer, "\tadd {dst_s}, {base_s}, {idx_s}, sxtw #{shift}")?;
                } else {
                    // General case: sign-extend, multiply, add.
                    writeln!(self.writer, "\tsxtw x16, {idx_s}")?;
                    self.emit_mov_imm("x17", scale as u64)?;
                    writeln!(self.writer, "\tmul x16, x16, x17")?;
                    writeln!(self.writer, "\tadd {dst_s}, {base_s}, x16")?;
                }
            }
        }
        Ok(())
    }

    fn emit_cmp(&mut self, size: RegSize, lhs: Reg, rhs: Operand) -> Result<(), Error> {
        let lhs_s = self.reg_name(lhs, size);
        match rhs {
            Operand::Reg(r) => writeln!(self.writer, "\tcmp {lhs_s}, {}", self.reg_name(r, size))?,
            Operand::Imm(imm) if self.is_addsub_imm_encodable(imm) => {
                writeln!(self.writer, "\tcmp {lhs_s}, #{imm}")?
            }
            Operand::Imm(imm) => {
                let scratch = self.reg_name(Reg::P(16), size);
                self.emit_mov_imm(&scratch, imm as u64)?;
                writeln!(self.writer, "\tcmp {lhs_s}, {scratch}")?;
            }
        }
        Ok(())
    }

    fn emit_adrp_add(&mut self, dst: Reg, sym: &str) -> Result<(), Error> {
        let dst_s = self.reg_name(dst, RegSize::X64);
        writeln!(self.writer, "\tadrp {dst_s}, {sym}")?;
        writeln!(self.writer, "\tadd  {dst_s}, {dst_s}, :lo12:{sym}")?;
        Ok(())
    }

    /// Uses movz + movk sequence for values that don't fit in 16 bits.
    fn emit_mov_imm(&mut self, reg: &str, value: u64) -> Result<(), Error> {
        let is_32bit = reg.starts_with('w');
        let value = if is_32bit { value & 0xFFFF_FFFF } else { value };

        if value <= 0xFFFF {
            writeln!(self.writer, "\tmov {reg}, #{value}")?;
            return Ok(());
        }

        let chunk0 = (value & 0xFFFF) as u16;
        let chunk1 = ((value >> 16) & 0xFFFF) as u16;
        let chunk2 = ((value >> 32) & 0xFFFF) as u16;
        let chunk3 = ((value >> 48) & 0xFFFF) as u16;

        // Find the first non-zero chunk to use movz
        let mut first = true;
        if chunk0 != 0 || (chunk1 == 0 && chunk2 == 0 && chunk3 == 0) {
            writeln!(self.writer, "\tmovz {reg}, #{chunk0}")?;
            first = false;
        }
        if chunk1 != 0 {
            if first {
                writeln!(self.writer, "\tmovz {reg}, #{chunk1}, lsl #16")?;
                first = false;
            } else {
                writeln!(self.writer, "\tmovk {reg}, #{chunk1}, lsl #16")?;
            }
        }
        if !is_32bit {
            if chunk2 != 0 {
                if first {
                    writeln!(self.writer, "\tmovz {reg}, #{chunk2}, lsl #32")?;
                    first = false;
                } else {
                    writeln!(self.writer, "\tmovk {reg}, #{chunk2}, lsl #32")?;
                }
            }
            if chunk3 != 0 {
                if first {
                    writeln!(self.writer, "\tmovz {reg}, #{chunk3}, lsl #48")?;
                } else {
                    writeln!(self.writer, "\tmovk {reg}, #{chunk3}, lsl #48")?;
                }
            }
        }

        Ok(())
    }

    fn emit_add_x_imm(&mut self, dst: Reg, base: Reg, offset: i64) -> Result<(), Error> {
        let dst_s = self.reg_name(dst, RegSize::X64);
        let base_s = self.reg_name(base, RegSize::X64);

        match offset {
            0 => writeln!(self.writer, "\tmov {dst_s}, {base_s}")?,
            off if off > 0 && self.is_addsub_imm_encodable(off) => {
                writeln!(self.writer, "\tadd {dst_s}, {base_s}, #{off}")?
            }
            off if off < 0 && self.is_addsub_imm_encodable(-off) => {
                writeln!(self.writer, "\tsub {dst_s}, {base_s}, #{}", -off)?
            }
            off => {
                self.emit_mov_imm("x16", off.unsigned_abs())?;
                if off > 0 {
                    writeln!(self.writer, "\tadd {dst_s}, {base_s}, x16")?;
                } else {
                    writeln!(self.writer, "\tsub {dst_s}, {base_s}, x16")?;
                }
            }
        }
        Ok(())
    }

    fn emit_add_sp(&mut self, imm: i64) -> Result<(), Error> {
        if imm == 0 {
            return Ok(());
        }
        if self.is_addsub_imm_encodable(imm) {
            writeln!(self.writer, "\tadd sp, sp, #{imm}")?;
        } else {
            self.emit_mov_imm("x16", imm as u64)?;
            writeln!(self.writer, "\tadd sp, sp, x16")?;
        }
        Ok(())
    }

    fn emit_save_caller_regs(&mut self) -> Result<(), Error> {
        writeln!(self.writer, "\tstr x15, [sp, #-16]!")?;
        writeln!(self.writer, "\tstp x13, x14, [sp, #-16]!")?;
        writeln!(self.writer, "\tstp x11, x12, [sp, #-16]!")?;
        writeln!(self.writer, "\tstp x9,  x10, [sp, #-16]!")?;
        Ok(())
    }

    fn emit_restore_caller_regs(&mut self) -> Result<(), Error> {
        writeln!(self.writer, "\tldp x9,  x10, [sp], #16")?;
        writeln!(self.writer, "\tldp x11, x12, [sp], #16")?;
        writeln!(self.writer, "\tldp x13, x14, [sp], #16")?;
        writeln!(self.writer, "\tldr x15, [sp], #16")?;
        Ok(())
    }
}

impl<W: Write> AsmPrint for AsmPrinter<W> {
    fn emit_inst(&mut self, inst: &Inst) -> Result<(), Error> {
        match inst {
            Inst::Label(name) => writeln!(self.writer, "{name}:")?,
            Inst::Mov { size, dst, src } => self.emit_mov(*size, *dst, *src)?,
            Inst::BinOp { op, size, dst, lhs, rhs } => self.emit_binop(*op, *size, *dst, *lhs, *rhs)?,
            Inst::Ldr { size, dst, addr } => self.emit_load(*size, *dst, addr)?,
            Inst::Str { size, src, addr } => self.emit_store(*size, *src, addr)?,
            Inst::Lea { dst, addr } => self.emit_lea(*dst, addr)?,
            Inst::Gep { dst, base, index, scale } => self.emit_gep(*dst, *base, *index, *scale)?,
            Inst::Cmp { size, lhs, rhs } => self.emit_cmp(*size, *lhs, *rhs)?,
            Inst::B { label } => writeln!(self.writer, "\tb {label}")?,
            Inst::BCond { cond, label } => {
                writeln!(self.writer, "\tb.{} {label}", self.cond_suffix(*cond))?
            }
            Inst::Bl { func } => writeln!(self.writer, "\tbl {func}")?,
            Inst::SaveCallerRegs => self.emit_save_caller_regs()?,
            Inst::RestoreCallerRegs => self.emit_restore_caller_regs()?,
            Inst::SubSp { imm } => self.emit_sub_sp(*imm)?,
            Inst::AddSp { imm } => self.emit_add_sp(*imm)?,
            Inst::Ret => {
                writeln!(self.writer, "\tmov sp, x29")?;
                writeln!(self.writer, "\tldp x29, x30, [sp], #16")?;
                writeln!(self.writer, "\tret")?;
            }
        }
        Ok(())
    }

    fn emit_sub_sp(&mut self, imm: i64) -> Result<(), Error> {
        if imm == 0 {
            return Ok(());
        }
        if self.is_addsub_imm_encodable(imm) {
            writeln!(self.writer, "\tsub sp, sp, #{imm}")?;
        } else {
            self.emit_mov_imm("x16", imm as u64)?;
            writeln!(self.writer, "\tsub sp, sp, x16")?;
        }
        Ok(())
    }

    fn emit_raw(&mut self, line: &str) -> Result<(), Error> {
        writeln!(self.writer, "{}", line)?;
        Ok(())
    }

    fn emit_global(&mut self, sym: &str) -> Result<(), Error> {
        writeln!(self.writer, ".globl {sym}")?;
        Ok(())
    }

    fn emit_align(&mut self, power: u32) -> Result<(), Error> {
        writeln!(self.writer, ".p2align {power}")?;
        Ok(())
    }

    fn emit_label(&mut self, name: &str) -> Result<(), Error> {
        writeln!(self.writer, "{name}:")?;
        Ok(())
    }

    fn emit_prologue(&mut self, frame_size: i64) -> Result<(), Error> {
        writeln!(self.writer, "\tstp x29, x30, [sp, #-16]!")?;
        writeln!(self.writer, "\tmov x29, sp")?;
        if frame_size > 0 {
            self.emit_sub_sp(frame_size)?;
        }
        Ok(())
    }
}
