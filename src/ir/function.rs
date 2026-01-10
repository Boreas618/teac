#![allow(unused)]
//! IR function representation and generation context.
//!
//! This module provides:
//!
//! - [`Function`]: IR function representation
//! - [`BlockLabel`]: Basic block labels
//! - [`FunctionGenerator`]: Context for generating function IR

use super::error::Error;
use super::stmt::Stmt;
use super::types::Dtype;
use super::value::{LocalVariable, Operand};
use crate::ast;
use indexmap::IndexMap;
use std::fmt::{Display, Formatter};
use std::rc::Rc;

// =============================================================================
// Block Labels
// =============================================================================

/// A label for a basic block or function entry.
#[derive(Clone)]
pub enum BlockLabel {
    /// A numbered basic block within a function.
    BasicBlock(usize),
    /// The entry point of a function.
    Function(String),
}

impl Display for BlockLabel {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            BlockLabel::BasicBlock(index) => write!(f, "bb{}", index),
            BlockLabel::Function(identifier) => write!(f, "{}", identifier),
        }
    }
}

// =============================================================================
// Function
// =============================================================================

/// An IR function definition.
pub struct Function {
    /// Function identifier (name).
    pub identifier: String,
    /// Local variables defined in the function.
    pub local_variables: Option<IndexMap<String, Rc<LocalVariable>>>,
    /// Basic blocks containing statements.
    pub blocks: Option<Vec<Vec<Stmt>>>,
    /// Function arguments.
    pub arguments: Vec<LocalVariable>,
}

// =============================================================================
// Function Generator
// =============================================================================

/// Context for generating IR within a single function.
///
/// Provides virtual register allocation, block label generation,
/// variable lookup, and IR emission helpers.
pub struct FunctionGenerator<'ir> {
    /// Reference to the parent module generator.
    pub module_generator: &'ir mut super::module::ModuleGenerator,
    /// Local variables in scope.
    pub local_variables: IndexMap<String, Rc<LocalVariable>>,
    /// Generated IR statements.
    pub irs: Vec<Stmt>,
    /// Function arguments.
    pub arguments: Vec<LocalVariable>,
    /// Next virtual register index.
    virt_reg_index: usize,
    /// Next basic block index.
    basic_block_index: usize,
}

impl<'ir> FunctionGenerator<'ir> {
    /// Creates a new function generator.
    pub fn new(module_generator: &'ir mut super::module::ModuleGenerator) -> Self {
        Self {
            module_generator,
            local_variables: IndexMap::new(),
            irs: Vec::new(),
            arguments: Vec::new(),
            virt_reg_index: 100,
            basic_block_index: 1,
        }
    }

    /// Increments and returns the previous virtual register index.
    pub fn increment_virt_reg_index(&mut self) -> usize {
        self.virt_reg_index += 1;
        self.virt_reg_index - 1
    }

    /// Increments and returns the previous basic block index.
    pub fn increment_basic_block_index(&mut self) -> usize {
        self.basic_block_index += 1;
        self.basic_block_index - 1
    }

    /// Allocates a anonymous virtual register with the given type.
    pub fn alloc_temporary(&mut self, dtype: Dtype) -> Operand {
        Operand::Local(LocalVariable::new(
            dtype,
            self.increment_virt_reg_index(),
            None,
        ))
    }

    /// Allocates a new basic block label.
    pub fn alloc_basic_block(&mut self) -> BlockLabel {
        BlockLabel::BasicBlock(self.increment_basic_block_index())
    }

    /// Looks up a variable by name, checking local variables first, then globals.
    pub fn lookup_variable(&self, id: &str) -> Result<Operand, Error> {
        if let Some(local) = self.local_variables.get(id) {
            Ok(Operand::Local(local.as_ref().clone()))
        } else if let Some(global) = self.module_generator.module.global_list.get(id) {
            Ok(Operand::Global(global.clone()))
        } else {
            Err(Error::VariableNotDefined {
                symbol: id.to_string(),
            })
        }
    }
}

// =============================================================================
// IR Builder - Instruction Emission Helpers
// =============================================================================

impl FunctionGenerator<'_> {
    /// Emits an alloca instruction.
    pub fn emit_alloca(&mut self, dst: Operand) {
        self.irs.push(Stmt::as_alloca(dst));
    }

    /// Emits a load instruction and returns the destination.
    pub fn emit_load(&mut self, dst: Operand, ptr: Operand) -> Operand {
        self.irs.push(Stmt::as_load(dst.clone(), ptr));
        dst
    }

    /// Emits a store instruction.
    pub fn emit_store(&mut self, src: Operand, ptr: Operand) {
        self.irs.push(Stmt::as_store(src, ptr));
    }

    /// Emits a GEP instruction.
    pub fn emit_gep(&mut self, new_ptr: Operand, base_ptr: Operand, index: Operand) {
        self.irs.push(Stmt::as_gep(new_ptr, base_ptr, index));
    }

    /// Emits a binary operation instruction.
    pub fn emit_biop(&mut self, op: ast::ArithBiOp, left: Operand, right: Operand, dst: Operand) {
        self.irs.push(Stmt::as_biop(op, left, right, dst));
    }

    /// Emits a comparison instruction.
    pub fn emit_cmp(&mut self, op: ast::ComOp, left: Operand, right: Operand, dst: Operand) {
        self.irs.push(Stmt::as_cmp(op, left, right, dst));
    }

    /// Emits a conditional jump instruction.
    pub fn emit_cjump(&mut self, cond: Operand, true_label: BlockLabel, false_label: BlockLabel) {
        self.irs.push(Stmt::as_cjump(cond, true_label, false_label));
    }

    /// Emits an unconditional jump instruction.
    pub fn emit_jump(&mut self, target: BlockLabel) {
        self.irs.push(Stmt::as_jump(target));
    }

    /// Emits a label instruction.
    pub fn emit_label(&mut self, label: BlockLabel) {
        self.irs.push(Stmt::as_label(label));
    }

    /// Emits a call instruction.
    pub fn emit_call(&mut self, func_name: String, result: Option<Operand>, args: Vec<Operand>) {
        self.irs.push(Stmt::as_call(func_name, result, args));
    }

    /// Emits a return instruction.
    pub fn emit_return(&mut self, val: Option<Operand>) {
        self.irs.push(Stmt::as_return(val));
    }
}
