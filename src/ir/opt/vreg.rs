use crate::ir::stmt::{Stmt, StmtInner};
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Operand};

#[allow(dead_code)]
pub struct VRegCounter {
    next: usize,
}

#[allow(dead_code)]
impl VRegCounter {
    pub fn new(start: usize) -> Self {
        Self { next: start }
    }

    pub fn from_blocks(blocks: &[Vec<Stmt>], args: &[LocalVariable]) -> Self {
        let max_idx = Self::compute_max_vreg(blocks, args);
        Self { next: max_idx + 1 }
    }

    pub fn alloc(&mut self) -> usize {
        let idx = self.next;
        self.next += 1;
        idx
    }

    pub fn alloc_local(&mut self, dtype: Dtype) -> LocalVariable {
        LocalVariable::new(dtype, self.alloc(), None)
    }

    pub fn alloc_operand(&mut self, dtype: Dtype) -> Operand {
        Operand::Local(self.alloc_local(dtype))
    }

    fn compute_max_vreg(blocks: &[Vec<Stmt>], args: &[LocalVariable]) -> usize {
        let mut max_idx = 0;

        for arg in args {
            max_idx = max_idx.max(arg.index);
        }

        for stmt in blocks.iter().flatten() {
            Self::update_max_from_stmt(&mut max_idx, stmt);
        }

        max_idx
    }

    fn update_max_from_stmt(max_idx: &mut usize, stmt: &Stmt) {
        match &stmt.inner {
            StmtInner::Call(s) => {
                if let Some(res) = &s.res {
                    Self::update_max_from_operand(max_idx, res);
                }
                for a in &s.args {
                    Self::update_max_from_operand(max_idx, a);
                }
            }
            StmtInner::Load(s) => {
                Self::update_max_from_operand(max_idx, &s.dst);
                Self::update_max_from_operand(max_idx, &s.ptr);
            }
            StmtInner::Phi(s) => {
                Self::update_max_from_operand(max_idx, &s.dst);
                for (_, val) in &s.incomings {
                    Self::update_max_from_operand(max_idx, val);
                }
            }
            StmtInner::BiOp(s) => {
                Self::update_max_from_operand(max_idx, &s.left);
                Self::update_max_from_operand(max_idx, &s.right);
                Self::update_max_from_operand(max_idx, &s.dst);
            }
            StmtInner::Alloca(s) => {
                Self::update_max_from_operand(max_idx, &s.dst);
            }
            StmtInner::Cmp(s) => {
                Self::update_max_from_operand(max_idx, &s.left);
                Self::update_max_from_operand(max_idx, &s.right);
                Self::update_max_from_operand(max_idx, &s.dst);
            }
            StmtInner::CJump(s) => {
                Self::update_max_from_operand(max_idx, &s.dst);
            }
            StmtInner::Store(s) => {
                Self::update_max_from_operand(max_idx, &s.src);
                Self::update_max_from_operand(max_idx, &s.ptr);
            }
            StmtInner::Gep(s) => {
                Self::update_max_from_operand(max_idx, &s.new_ptr);
                Self::update_max_from_operand(max_idx, &s.base_ptr);
                Self::update_max_from_operand(max_idx, &s.index);
            }
            StmtInner::Return(s) => {
                if let Some(val) = &s.val {
                    Self::update_max_from_operand(max_idx, val);
                }
            }
            StmtInner::Label(_) | StmtInner::Jump(_) => {}
        }
    }

    fn update_max_from_operand(max_idx: &mut usize, op: &Operand) {
        if let Some(idx) = local_index(op) {
            *max_idx = (*max_idx).max(idx);
        }
    }
}

pub fn local_index(op: &Operand) -> Option<usize> {
    op.as_local().map(|l| l.index)
}
