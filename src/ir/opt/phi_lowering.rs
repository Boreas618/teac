use super::cfg::next_basic_block_id;
use crate::ir::function::BlockLabel;
use crate::ir::stmt::{PhiStmt, Stmt, StmtInner};
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Operand};
use std::collections::HashMap;

pub struct PhiLowering<'a> {
    blocks: &'a [Vec<Stmt>],
    next_vreg: usize,
}

impl<'a> PhiLowering<'a> {
    pub fn new(blocks: &'a [Vec<Stmt>], next_vreg: usize) -> Self {
        Self { blocks, next_vreg }
    }

    pub fn run(mut self) -> Vec<Vec<Stmt>> {
        if !self.has_phis() {
            return self.blocks.to_vec();
        }

        let (mut block_data, labels) = self.parse_blocks();
        let mut slot_alloc = PhiSlotAllocator::new();
        let phi_loads = self.create_phi_loads(&block_data, &mut slot_alloc);
        let cfg = BlockDataCfg::build(&block_data, &labels);

        let mut edge_splitter = EdgeSplitter::new(&labels);
        self.place_phi_stores(&block_data, &cfg, &labels, &slot_alloc, &mut edge_splitter);
        edge_splitter.update_terminators(&mut block_data, &labels);

        self.assemble_blocks(block_data, labels, slot_alloc, phi_loads, edge_splitter)
    }

    fn has_phis(&self) -> bool {
        self.blocks
            .iter()
            .any(|b| b.iter().any(|s| matches!(s.inner, StmtInner::Phi(_))))
    }

    fn parse_blocks(&self) -> (Vec<BlockData>, Vec<BlockLabel>) {
        let mut data = Vec::with_capacity(self.blocks.len());
        let mut labels = Vec::with_capacity(self.blocks.len());

        for block in self.blocks {
            let parsed = BlockData::parse(block);
            labels.push(parsed.label.clone());
            data.push(parsed);
        }

        (data, labels)
    }

    fn create_phi_loads(
        &mut self,
        block_data: &[BlockData],
        slot_alloc: &mut PhiSlotAllocator,
    ) -> Vec<Vec<Stmt>> {
        let mut phi_loads = vec![Vec::new(); block_data.len()];

        for (b_idx, block) in block_data.iter().enumerate() {
            for phi in &block.phis {
                let slot = slot_alloc.get_or_create(&phi.dst, &mut self.next_vreg);
                phi_loads[b_idx].push(Stmt::as_load(phi.dst.clone(), slot));
            }
        }

        phi_loads
    }

    fn place_phi_stores(
        &mut self,
        block_data: &[BlockData],
        cfg: &BlockDataCfg,
        labels: &[BlockLabel],
        slot_alloc: &PhiSlotAllocator,
        edge_splitter: &mut EdgeSplitter,
    ) {
        for (b_idx, block) in block_data.iter().enumerate() {
            if block.phis.is_empty() {
                continue;
            }

            for &pred in &cfg.preds[b_idx] {
                let stores = slot_alloc.build_phi_stores(&block.phis, &labels[pred]);
                if stores.is_empty() {
                    continue;
                }

                if cfg.succs[pred].len() == 1 {
                    edge_splitter.add_direct_inserts(pred, stores);
                } else {
                    // Critical edge: must split
                    edge_splitter.split_edge(pred, b_idx, stores);
                }
            }
        }
    }

    fn assemble_blocks(
        self,
        block_data: Vec<BlockData>,
        labels: Vec<BlockLabel>,
        slot_alloc: PhiSlotAllocator,
        phi_loads: Vec<Vec<Stmt>>,
        edge_splitter: EdgeSplitter,
    ) -> Vec<Vec<Stmt>> {
        let entry_idx = labels
            .iter()
            .position(|l| matches!(l, BlockLabel::Function(_)))
            .unwrap_or(0);

        let alloca_stmts = slot_alloc.into_allocas();
        let mut out_blocks = Vec::new();

        for (idx, block) in block_data.into_iter().enumerate() {
            let mut stmts = Vec::new();
            stmts.push(block.label_stmt);

            if idx == entry_idx {
                stmts.extend(alloca_stmts.iter().cloned());
            }

            stmts.extend(phi_loads[idx].iter().cloned());

            if let Some(copies) = edge_splitter.direct_inserts.get(&idx) {
                Self::insert_before_terminator(&mut stmts, &block.body, copies.clone());
            } else {
                stmts.extend(block.body);
            }

            out_blocks.push(stmts);
        }

        out_blocks.extend(edge_splitter.create_split_blocks(&labels));

        out_blocks
    }

    fn insert_before_terminator(stmts: &mut Vec<Stmt>, body: &[Stmt], copies: Vec<Stmt>) {
        let term_idx = body.iter().rposition(|s| {
            matches!(
                s.inner,
                StmtInner::Jump(_) | StmtInner::CJump(_) | StmtInner::Return(_)
            )
        });

        if let Some(idx) = term_idx {
            stmts.extend(body[..idx].iter().cloned());
            stmts.extend(copies);
            stmts.extend(body[idx..].iter().cloned());
        } else {
            stmts.extend(body.iter().cloned());
            stmts.extend(copies);
        }
    }
}

struct BlockData {
    label: BlockLabel,
    label_stmt: Stmt,
    phis: Vec<PhiStmt>,
    body: Vec<Stmt>,
}

impl BlockData {
    fn parse(block: &[Stmt]) -> Self {
        let mut label_stmt = None;
        let mut label = None;
        let mut phis = Vec::new();
        let mut body = Vec::new();

        for stmt in block {
            match &stmt.inner {
                StmtInner::Label(l) => {
                    if label_stmt.is_none() {
                        label_stmt = Some(stmt.clone());
                        label = Some(l.label.clone());
                    }
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

struct BlockDataCfg {
    succs: Vec<Vec<usize>>,
    preds: Vec<Vec<usize>>,
}

impl BlockDataCfg {
    fn build(blocks: &[BlockData], labels: &[BlockLabel]) -> Self {
        let label_map: HashMap<String, usize> = labels
            .iter()
            .enumerate()
            .map(|(i, l)| (l.key(), i))
            .collect();

        let n = blocks.len();
        let mut succs = vec![Vec::new(); n];
        let mut preds = vec![Vec::new(); n];

        for (i, block) in blocks.iter().enumerate() {
            let term = block
                .body
                .iter()
                .rev()
                .find(|s| !matches!(s.inner, StmtInner::Label(_)));

            let successors = match term.map(|s| &s.inner) {
                Some(StmtInner::Jump(j)) => vec![label_map[&j.target.key()]],
                Some(StmtInner::CJump(j)) => vec![
                    label_map[&j.true_label.key()],
                    label_map[&j.false_label.key()],
                ],
                Some(StmtInner::Return(_)) => Vec::new(),
                _ => {
                    if i + 1 < n {
                        vec![i + 1]
                    } else {
                        Vec::new()
                    }
                }
            };
            succs[i] = successors;
        }

        for (i, succ_list) in succs.iter().enumerate() {
            for &s in succ_list {
                preds[s].push(i);
            }
        }

        Self { succs, preds }
    }
}

struct PhiSlotAllocator {
    slots: HashMap<usize, Operand>,
    alloca_stmts: Vec<Stmt>,
}

impl PhiSlotAllocator {
    fn new() -> Self {
        Self {
            slots: HashMap::new(),
            alloca_stmts: Vec::new(),
        }
    }

    fn get_or_create(&mut self, phi_dst: &Operand, next_vreg: &mut usize) -> Operand {
        let dst_idx = phi_dst.vreg_index().expect("phi dest must be local");

        self.slots
            .entry(dst_idx)
            .or_insert_with(|| {
                let idx = *next_vreg;
                *next_vreg += 1;
                let ptr = LocalVariable::new(Dtype::ptr_to(phi_dst.dtype().clone()), idx, None);
                let slot = Operand::Local(ptr);
                self.alloca_stmts.push(Stmt::as_alloca(slot.clone()));
                slot
            })
            .clone()
    }

    fn build_phi_stores(&self, phis: &[PhiStmt], pred_label: &BlockLabel) -> Vec<Stmt> {
        let pred_key = pred_label.key();

        phis.iter()
            .map(|phi| {
                let incoming = phi
                    .incomings
                    .iter()
                    .find(|(label, _)| label.key() == pred_key)
                    .map(|(_, val)| val.clone())
                    .unwrap_or_else(|| Operand::from(0));

                let dst_idx = phi.dst.vreg_index().expect("phi dest must be local");
                let slot = self.slots.get(&dst_idx).expect("missing phi slot").clone();

                Stmt::as_store(incoming, slot)
            })
            .collect()
    }

    fn into_allocas(self) -> Vec<Stmt> {
        self.alloca_stmts
    }
}

struct EdgeSplitter {
    split_edges: HashMap<(usize, usize), BlockLabel>,
    edge_copies: HashMap<(usize, usize), Vec<Stmt>>,
    direct_inserts: HashMap<usize, Vec<Stmt>>,
    next_bb_id: usize,
}

impl EdgeSplitter {
    fn new(labels: &[BlockLabel]) -> Self {
        Self {
            split_edges: HashMap::new(),
            edge_copies: HashMap::new(),
            direct_inserts: HashMap::new(),
            next_bb_id: next_basic_block_id(labels),
        }
    }

    fn split_edge(&mut self, pred: usize, succ: usize, stores: Vec<Stmt>) {
        let new_label = BlockLabel::BasicBlock(self.next_bb_id);
        self.next_bb_id += 1;
        self.split_edges.insert((pred, succ), new_label);
        self.edge_copies.insert((pred, succ), stores);
    }

    fn add_direct_inserts(&mut self, pred: usize, stores: Vec<Stmt>) {
        self.direct_inserts.entry(pred).or_default().extend(stores);
    }

    fn update_terminators(&self, block_data: &mut [BlockData], labels: &[BlockLabel]) {
        for (&(pred, succ), new_label) in &self.split_edges {
            if let Some(term) = block_data[pred].body.last_mut() {
                match &mut term.inner {
                    StmtInner::Jump(j) => {
                        if j.target.key() == labels[succ].key() {
                            j.target = new_label.clone();
                        }
                    }
                    StmtInner::CJump(j) => {
                        if j.true_label.key() == labels[succ].key() {
                            j.true_label = new_label.clone();
                        }
                        if j.false_label.key() == labels[succ].key() {
                            j.false_label = new_label.clone();
                        }
                    }
                    _ => {}
                }
            }
        }
    }

    fn create_split_blocks(mut self, labels: &[BlockLabel]) -> Vec<Vec<Stmt>> {
        let mut result = Vec::new();

        for ((pred, succ), new_label) in self.split_edges {
            let copies = self
                .edge_copies
                .remove(&(pred, succ))
                .unwrap_or_default();

            let mut stmts = Vec::new();
            stmts.push(Stmt::as_label(new_label));
            stmts.extend(copies);
            stmts.push(Stmt::as_jump(labels[succ].clone()));
            result.push(stmts);
        }

        result
    }
}
