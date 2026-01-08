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
use super::value::{LocalVariable, Value};
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

    // =========================================================================
    // Virtual Register Helpers
    // =========================================================================

    /// Creates a new integer virtual register.
    pub fn new_int_reg(&mut self) -> Value {
        Value::Local(
            LocalVariable::builder()
                .dtype(Dtype::I32)
                .index(self.increment_virt_reg_index())
                .build(),
        )
    }

    /// Creates a new integer pointer virtual register.
    pub fn new_int_ptr_reg(&mut self, length: usize) -> Value {
        Value::Local(
            LocalVariable::builder()
                .dtype(Dtype::Pointer {
                    inner: Box::new(Dtype::I32),
                    length,
                })
                .index(self.increment_virt_reg_index())
                .build(),
        )
    }

    /// Creates a new struct virtual register.
    pub fn new_struct_reg(&mut self, type_name: &str) -> Value {
        Value::Local(
            LocalVariable::builder()
                .dtype(Dtype::Struct {
                    type_name: type_name.to_string(),
                })
                .index(self.increment_virt_reg_index())
                .build(),
        )
    }

    /// Creates a new struct pointer virtual register.
    pub fn new_struct_ptr_reg(&mut self, type_name: &str, length: usize) -> Value {
        Value::Local(
            LocalVariable::builder()
                .dtype(Dtype::Pointer {
                    inner: Box::new(Dtype::Struct {
                        type_name: type_name.to_string(),
                    }),
                    length,
                })
                .index(self.increment_virt_reg_index())
                .build(),
        )
    }

    /// Creates a new block label.
    pub fn new_block_label(&mut self) -> BlockLabel {
        BlockLabel::BasicBlock(self.increment_basic_block_index())
    }

    // =========================================================================
    // Variable Lookup
    // =========================================================================

    /// Looks up a variable by name, checking local variables first, then globals.
    pub fn lookup_variable(&self, id: &str) -> Result<Value, Error> {
        if let Some(local) = self.local_variables.get(id) {
            Ok(Value::Local(local.as_ref().clone()))
        } else if let Some(global) = self.module_generator.module.global_list.get(id) {
            Ok(Value::Global(global.clone()))
        } else {
            Err(Error::VariableNotDefined {
                symbol: id.to_string(),
            })
        }
    }

    // =========================================================================
    // Type-based Variable Creation
    // =========================================================================

    /// Creates a pointer variable appropriate for the given dtype.
    pub fn create_ptr_for_dtype(
        &mut self,
        dtype: &Dtype,
        length: usize,
    ) -> Result<LocalVariable, Error> {
        let index = self.increment_virt_reg_index();
        match dtype {
            Dtype::I32 => Ok(LocalVariable::builder()
                .dtype(Dtype::Pointer {
                    inner: Box::new(Dtype::I32),
                    length,
                })
                .index(index)
                .build()),
            Dtype::Struct { type_name } => Ok(LocalVariable::builder()
                .dtype(Dtype::Pointer {
                    inner: Box::new(Dtype::Struct {
                        type_name: type_name.clone(),
                    }),
                    length,
                })
                .index(index)
                .build()),
            Dtype::Pointer {
                inner,
                length: ptr_len,
            } => self.create_ptr_for_inner_dtype(inner, *ptr_len),
            _ => Err(Error::LocalVarTypeUnsupported),
        }
    }

    /// Creates a pointer variable for a pointer's inner type.
    fn create_ptr_for_inner_dtype(
        &mut self,
        inner: &Dtype,
        length: usize,
    ) -> Result<LocalVariable, Error> {
        let index = self.increment_virt_reg_index();
        match inner {
            Dtype::I32 => Ok(LocalVariable::builder()
                .dtype(Dtype::Pointer {
                    inner: Box::new(Dtype::I32),
                    length,
                })
                .index(index)
                .build()),
            Dtype::Struct { type_name } => Ok(LocalVariable::builder()
                .dtype(Dtype::Pointer {
                    inner: Box::new(Dtype::Struct {
                        type_name: type_name.clone(),
                    }),
                    length,
                })
                .index(index)
                .build()),
            _ => Err(Error::LocalVarTypeUnsupported),
        }
    }
}

// =============================================================================
// IR Builder - Instruction Emission Helpers
// =============================================================================

impl FunctionGenerator<'_> {
    /// Emits an alloca instruction.
    pub fn emit_alloca(&mut self, dst: Value) {
        self.irs.push(Stmt::as_alloca(dst));
    }

    /// Emits a load instruction and returns the destination.
    pub fn emit_load(&mut self, dst: Value, ptr: Value) -> Value {
        self.irs.push(Stmt::as_load(dst.clone(), ptr));
        dst
    }

    /// Emits a store instruction.
    pub fn emit_store(&mut self, src: Value, ptr: Value) {
        self.irs.push(Stmt::as_store(src, ptr));
    }

    /// Emits a GEP instruction.
    pub fn emit_gep(&mut self, new_ptr: Value, base_ptr: Value, index: Value) {
        self.irs.push(Stmt::as_gep(new_ptr, base_ptr, index));
    }

    /// Emits a binary operation instruction.
    pub fn emit_biop(&mut self, op: ast::ArithBiOp, left: Value, right: Value, dst: Value) {
        self.irs.push(Stmt::as_biop(op, left, right, dst));
    }

    /// Emits a comparison instruction.
    pub fn emit_cmp(&mut self, op: ast::ComOp, left: Value, right: Value, dst: Value) {
        self.irs.push(Stmt::as_cmp(op, left, right, dst));
    }

    /// Emits a conditional jump instruction.
    pub fn emit_cjump(&mut self, cond: Value, true_label: BlockLabel, false_label: BlockLabel) {
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
    pub fn emit_call(&mut self, func_name: String, result: Option<LocalVariable>, args: Vec<Value>) {
        self.irs.push(Stmt::as_call(func_name, result, args));
    }

    /// Emits a return instruction.
    pub fn emit_return(&mut self, val: Option<Value>) {
        self.irs.push(Stmt::as_return(val));
    }
}

