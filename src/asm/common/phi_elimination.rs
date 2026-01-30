//! PHI node elimination for codegen.
//!
//! Transforms SSA PHI nodes into explicit load/store operations through
//! stack slots, making the IR suitable for instruction selection.

use crate::ir::function::BlockLabel;
use crate::ir::stmt::{PhiStmt, Stmt, StmtInner};
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Operand};
use crate::ir::Function;
use std::collections::HashMap;

pub fn eliminate_phis(func: &Function) -> Option<Vec<Vec<Stmt>>> {
    let blocks = func.blocks.as_ref()?;

    if !has_phis(blocks) {
        return Some(blocks.clone());
    }

    Some(PhiEliminator::new(blocks, func.next_vreg).run())
}

fn has_phis(blocks: &[Vec<Stmt>]) -> bool {
    blocks
        .iter()
        .flatten()
        .any(|s| matches!(s.inner, StmtInner::Phi(_)))
}

struct PhiEliminator<'a> {
    blocks: &'a [Vec<Stmt>],
    next_vreg: usize,
}

impl<'a> PhiEliminator<'a> {
    fn new(blocks: &'a [Vec<Stmt>], next_vreg: usize) -> Self {
        Self { blocks, next_vreg }
    }

    fn run(mut self) -> Vec<Vec<Stmt>> {
        let mut parsed = self.parse_blocks();
        let cfg = Cfg::build(&parsed);

        let mut slots = SlotAllocator::new();
        let phi_loads = self.build_phi_loads(&parsed, &mut slots);

        let mut edges = EdgeSplitter::new(cfg.next_block_id);
        self.place_phi_stores(&parsed, &cfg, &slots, &mut edges);
        edges.patch_terminators(&mut parsed, &cfg.labels);

        self.assemble(parsed, cfg.labels, slots, phi_loads, edges)
    }

    fn parse_blocks(&self) -> Vec<ParsedBlock> {
        self.blocks.iter().map(|b| ParsedBlock::from_stmts(b)).collect()
    }

    fn build_phi_loads(
        &mut self,
        parsed: &[ParsedBlock],
        slots: &mut SlotAllocator,
    ) -> Vec<Vec<Stmt>> {
        parsed
            .iter()
            .map(|block| {
                block
                    .phis
                    .iter()
                    .map(|phi| {
                        let slot = slots.get_or_alloc(&phi.dst, &mut self.next_vreg);
                        Stmt::as_load(phi.dst.clone(), slot)
                    })
                    .collect()
            })
            .collect()
    }

    fn place_phi_stores(
        &mut self,
        parsed: &[ParsedBlock],
        cfg: &Cfg,
        slots: &SlotAllocator,
        edges: &mut EdgeSplitter,
    ) {
        for (block_idx, block) in parsed.iter().enumerate() {
            if block.phis.is_empty() {
                continue;
            }

            for &pred_idx in &cfg.preds[block_idx] {
                let stores = slots.build_stores(&block.phis, &cfg.labels[pred_idx]);
                if stores.is_empty() {
                    continue;
                }

                if cfg.succs[pred_idx].len() == 1 {
                    edges.insert_at_pred(pred_idx, stores);
                } else {
                    edges.split(pred_idx, block_idx, stores);
                }
            }
        }
    }

    fn assemble(
        self,
        parsed: Vec<ParsedBlock>,
        labels: Vec<BlockLabel>,
        slots: SlotAllocator,
        phi_loads: Vec<Vec<Stmt>>,
        edges: EdgeSplitter,
    ) -> Vec<Vec<Stmt>> {
        let entry_idx = labels
            .iter()
            .position(|l| matches!(l, BlockLabel::Function(_)))
            .unwrap_or(0);

        let allocas = slots.into_allocas();
        let split_count = edges.split_count();
        let mut result = Vec::with_capacity(parsed.len() + split_count);

        for (idx, block) in parsed.into_iter().enumerate() {
            let mut stmts = Vec::new();
            stmts.push(block.label_stmt);

            if idx == entry_idx {
                stmts.extend(allocas.iter().cloned());
            }

            stmts.extend(phi_loads[idx].iter().cloned());

            if let Some(inserts) = edges.pending_inserts.get(&idx) {
                insert_before_terminator(&mut stmts, block.body, inserts.clone());
            } else {
                stmts.extend(block.body);
            }

            result.push(stmts);
        }

        result.extend(edges.materialize_splits(&labels));
        result
    }
}

fn insert_before_terminator(out: &mut Vec<Stmt>, body: Vec<Stmt>, inserts: Vec<Stmt>) {
    let term_pos = body.iter().rposition(|s| {
        matches!(
            s.inner,
            StmtInner::Jump(_) | StmtInner::CJump(_) | StmtInner::Return(_)
        )
    });

    match term_pos {
        Some(pos) => {
            out.extend(body[..pos].iter().cloned());
            out.extend(inserts);
            out.extend(body[pos..].iter().cloned());
        }
        None => {
            out.extend(body);
            out.extend(inserts);
        }
    }
}

// === Internal data structures ===

struct ParsedBlock {
    label: BlockLabel,
    label_stmt: Stmt,
    phis: Vec<PhiStmt>,
    body: Vec<Stmt>,
}

impl ParsedBlock {
    fn from_stmts(stmts: &[Stmt]) -> Self {
        let mut label = None;
        let mut label_stmt = None;
        let mut phis = Vec::new();
        let mut body = Vec::new();

        for stmt in stmts {
            match &stmt.inner {
                StmtInner::Label(l) if label.is_none() => {
                    label = Some(l.label.clone());
                    label_stmt = Some(stmt.clone());
                }
                StmtInner::Phi(p) => phis.push(p.clone()),
                _ => body.push(stmt.clone()),
            }
        }

        Self {
            label: label.expect("block missing label"),
            label_stmt: label_stmt.expect("block missing label"),
            phis,
            body,
        }
    }
}

struct Cfg {
    labels: Vec<BlockLabel>,
    succs: Vec<Vec<usize>>,
    preds: Vec<Vec<usize>>,
    next_block_id: usize,
}

impl Cfg {
    fn build(blocks: &[ParsedBlock]) -> Self {
        let labels: Vec<_> = blocks.iter().map(|b| b.label.clone()).collect();
        let label_map: HashMap<String, usize> = labels
            .iter()
            .enumerate()
            .map(|(i, l)| (l.key(), i))
            .collect();

        let n = blocks.len();
        let mut succs = vec![Vec::new(); n];
        let mut preds = vec![Vec::new(); n];

        for (i, block) in blocks.iter().enumerate() {
            succs[i] = Self::successors_of(&block.body, i, n, &label_map);
        }

        for (i, s) in succs.iter().enumerate() {
            for &succ in s {
                preds[succ].push(i);
            }
        }

        let next_block_id = labels
            .iter()
            .filter_map(|l| match l {
                BlockLabel::BasicBlock(n) => Some(*n + 1),
                _ => None,
            })
            .max()
            .unwrap_or(1);

        Self {
            labels,
            succs,
            preds,
            next_block_id,
        }
    }

    fn successors_of(
        body: &[Stmt],
        idx: usize,
        n: usize,
        label_map: &HashMap<String, usize>,
    ) -> Vec<usize> {
        let term = body
            .iter()
            .rev()
            .find(|s| !matches!(s.inner, StmtInner::Label(_)));

        match term.map(|s| &s.inner) {
            Some(StmtInner::Jump(j)) => vec![label_map[&j.target.key()]],
            Some(StmtInner::CJump(j)) => {
                vec![label_map[&j.true_label.key()], label_map[&j.false_label.key()]]
            }
            Some(StmtInner::Return(_)) => vec![],
            _ if idx + 1 < n => vec![idx + 1],
            _ => vec![],
        }
    }
}

struct SlotAllocator {
    slots: HashMap<usize, Operand>,
    allocas: Vec<Stmt>,
}

impl SlotAllocator {
    fn new() -> Self {
        Self {
            slots: HashMap::new(),
            allocas: Vec::new(),
        }
    }

    fn get_or_alloc(&mut self, phi_dst: &Operand, next_vreg: &mut usize) -> Operand {
        let vreg = phi_dst.vreg_index().expect("phi dest must be local");

        self.slots
            .entry(vreg)
            .or_insert_with(|| {
                let idx = *next_vreg;
                *next_vreg += 1;
                let ptr = LocalVariable::new(Dtype::ptr_to(phi_dst.dtype().clone()), idx, None);
                let slot = Operand::Local(ptr);
                self.allocas.push(Stmt::as_alloca(slot.clone()));
                slot
            })
            .clone()
    }

    fn build_stores(&self, phis: &[PhiStmt], pred_label: &BlockLabel) -> Vec<Stmt> {
        let pred_key = pred_label.key();

        phis.iter()
            .filter_map(|phi| {
                let vreg = phi.dst.vreg_index().expect("phi dest must be local");
                let slot = self.slots.get(&vreg)?;

                let value = phi
                    .incomings
                    .iter()
                    .find(|(label, _)| label.key() == pred_key)
                    .map(|(_, v)| v.clone())
                    .unwrap_or_else(|| Operand::from(0));

                Some(Stmt::as_store(value, slot.clone()))
            })
            .collect()
    }

    fn into_allocas(self) -> Vec<Stmt> {
        self.allocas
    }
}

struct EdgeSplitter {
    splits: HashMap<(usize, usize), BlockLabel>,
    split_stores: HashMap<(usize, usize), Vec<Stmt>>,
    pending_inserts: HashMap<usize, Vec<Stmt>>,
    next_block_id: usize,
}

impl EdgeSplitter {
    fn new(next_block_id: usize) -> Self {
        Self {
            splits: HashMap::new(),
            split_stores: HashMap::new(),
            pending_inserts: HashMap::new(),
            next_block_id,
        }
    }

    fn split(&mut self, pred: usize, succ: usize, stores: Vec<Stmt>) {
        let label = BlockLabel::BasicBlock(self.next_block_id);
        self.next_block_id += 1;
        self.splits.insert((pred, succ), label);
        self.split_stores.insert((pred, succ), stores);
    }

    fn insert_at_pred(&mut self, pred: usize, stores: Vec<Stmt>) {
        self.pending_inserts.entry(pred).or_default().extend(stores);
    }

    fn split_count(&self) -> usize {
        self.splits.len()
    }

    fn patch_terminators(&self, blocks: &mut [ParsedBlock], labels: &[BlockLabel]) {
        for (&(pred, succ), new_label) in &self.splits {
            if let Some(term) = blocks[pred].body.last_mut() {
                let target_key = labels[succ].key();
                match &mut term.inner {
                    StmtInner::Jump(j) if j.target.key() == target_key => {
                        j.target = new_label.clone();
                    }
                    StmtInner::CJump(j) => {
                        if j.true_label.key() == target_key {
                            j.true_label = new_label.clone();
                        }
                        if j.false_label.key() == target_key {
                            j.false_label = new_label.clone();
                        }
                    }
                    _ => {}
                }
            }
        }
    }

    fn materialize_splits(mut self, labels: &[BlockLabel]) -> Vec<Vec<Stmt>> {
        self.splits
            .into_iter()
            .map(|((pred, succ), new_label)| {
                let stores = self.split_stores.remove(&(pred, succ)).unwrap_or_default();
                let mut block = vec![Stmt::as_label(new_label)];
                block.extend(stores);
                block.push(Stmt::as_jump(labels[succ].clone()));
                block
            })
            .collect()
    }
}
