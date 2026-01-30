#![allow(unused)]

use super::error::Error;
use super::stmt::Stmt;
use super::types::Dtype;
use super::value::{LocalVariable, Operand};
use crate::ast;
use indexmap::IndexMap;
use std::fmt::{Display, Formatter};
use std::rc::Rc;

#[derive(Clone)]
pub enum BlockLabel {
    BasicBlock(usize),
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

impl BlockLabel {
    /// Returns a unique string key for this label (used for CFG lookups)
    pub fn key(&self) -> String {
        format!("{}", self)
    }
}

pub struct Function {
    pub identifier: String,
    pub local_variables: Option<IndexMap<String, Rc<LocalVariable>>>,
    pub blocks: Option<Vec<Vec<Stmt>>>,
    pub arguments: Vec<LocalVariable>,
}

pub struct FunctionGenerator<'ir> {
    pub module_generator: &'ir mut super::module::ModuleGenerator,
    pub local_variables: IndexMap<String, Rc<LocalVariable>>,
    pub irs: Vec<Stmt>,
    pub arguments: Vec<LocalVariable>,
    virt_reg_index: usize,
    basic_block_index: usize,
}

impl<'ir> FunctionGenerator<'ir> {
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

    pub fn increment_virt_reg_index(&mut self) -> usize {
        self.virt_reg_index += 1;
        self.virt_reg_index - 1
    }

    pub fn increment_basic_block_index(&mut self) -> usize {
        self.basic_block_index += 1;
        self.basic_block_index - 1
    }

    pub fn alloc_temporary(&mut self, dtype: Dtype) -> Operand {
        Operand::Local(LocalVariable::new(
            dtype,
            self.increment_virt_reg_index(),
            None,
        ))
    }

    pub fn alloc_basic_block(&mut self) -> BlockLabel {
        BlockLabel::BasicBlock(self.increment_basic_block_index())
    }

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

impl FunctionGenerator<'_> {
    pub fn emit_alloca(&mut self, dst: Operand) {
        self.irs.push(Stmt::as_alloca(dst));
    }

    pub fn emit_load(&mut self, dst: Operand, ptr: Operand) -> Operand {
        self.irs.push(Stmt::as_load(dst.clone(), ptr));
        dst
    }

    pub fn emit_store(&mut self, src: Operand, ptr: Operand) {
        self.irs.push(Stmt::as_store(src, ptr));
    }

    pub fn emit_gep(&mut self, new_ptr: Operand, base_ptr: Operand, index: Operand) {
        self.irs.push(Stmt::as_gep(new_ptr, base_ptr, index));
    }

    pub fn emit_biop(&mut self, op: ast::ArithBiOp, left: Operand, right: Operand, dst: Operand) {
        self.irs.push(Stmt::as_biop(op, left, right, dst));
    }

    pub fn emit_cmp(&mut self, op: ast::ComOp, left: Operand, right: Operand, dst: Operand) {
        self.irs.push(Stmt::as_cmp(op, left, right, dst));
    }

    pub fn emit_cjump(&mut self, cond: Operand, true_label: BlockLabel, false_label: BlockLabel) {
        self.irs.push(Stmt::as_cjump(cond, true_label, false_label));
    }

    pub fn emit_jump(&mut self, target: BlockLabel) {
        self.irs.push(Stmt::as_jump(target));
    }

    pub fn emit_label(&mut self, label: BlockLabel) {
        self.irs.push(Stmt::as_label(label));
    }

    pub fn emit_call(&mut self, func_name: String, result: Option<Operand>, args: Vec<Operand>) {
        self.irs.push(Stmt::as_call(func_name, result, args));
    }

    pub fn emit_return(&mut self, val: Option<Operand>) {
        self.irs.push(Stmt::as_return(val));
    }
}
