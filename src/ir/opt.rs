use crate::ir::function::{BlockLabel, Function};
use crate::ir::stmt::{PhiStmt, Stmt, StmtInner};
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Operand};
use std::collections::{HashMap, HashSet, VecDeque};

pub fn mem2reg(func: &mut Function) {
    let Some(blocks) = func.blocks.as_mut() else {
        return;
    };
    if blocks.is_empty() {
        return;
    }

    let labels = collect_labels(blocks);
    let label_map = build_label_map(&labels);
    let (succs, preds) = build_cfg(blocks, &label_map);
    let dom = compute_dominators(&preds);
    let idom = compute_idom(&preds, &succs);
    let dom_children = build_dom_tree(&idom);
    let df = compute_dominance_frontiers(&succs, &idom, &dom_children);

    let mut next_vreg = max_vreg_index(blocks, &func.arguments) + 1;
    let candidates = collect_alloca_candidates(blocks);
    let usage = analyze_usage(blocks, &candidates);
    let promotable = select_promotable(&usage, &dom);

    if promotable.is_empty() {
        return;
    }

    let mut phi_nodes: Vec<Vec<PhiInfo>> = vec![Vec::new(); blocks.len()];
    let mut phi_lookup: Vec<HashMap<usize, usize>> = vec![HashMap::new(); blocks.len()];

    for (var_idx, info) in promotable.iter() {
        if !info.has_load {
            continue;
        }
        let live_in = compute_live_in(&info.load_before_store_blocks, &info.def_blocks, &succs);
        let mut worklist: VecDeque<usize> = info.def_blocks.iter().copied().collect();

        while let Some(b) = worklist.pop_front() {
            for y in df[b].iter().copied() {
                if !live_in[y] {
                    continue;
                }
                if phi_lookup[y].contains_key(var_idx) {
                    continue;
                }
                let dst = LocalVariable::new(Dtype::I32, next_vreg, None);
                next_vreg += 1;
                let phi = PhiInfo {
                    var: *var_idx,
                    dst: Operand::Local(dst),
                    incomings: Vec::new(),
                };
                phi_lookup[y].insert(*var_idx, phi_nodes[y].len());
                phi_nodes[y].push(phi);

                if !info.def_blocks.contains(&y) {
                    worklist.push_back(y);
                }
            }
        }
    }

    let mut renamer = Renamer::new(
        blocks,
        labels,
        succs,
        dom_children,
        phi_nodes,
        promotable.keys().copied().collect(),
    );
    renamer.run(&idom);
    *blocks = renamer.finish_blocks();
}

pub fn lower_phis_for_codegen(blocks: &[Vec<Stmt>]) -> Vec<Vec<Stmt>> {
    if !blocks
        .iter()
        .any(|b| b.iter().any(|s| matches!(s.inner, StmtInner::Phi(_))))
    {
        return blocks.to_vec();
    }

    let mut data = Vec::with_capacity(blocks.len());
    let mut labels = Vec::with_capacity(blocks.len());
    for block in blocks {
        let mut label_stmt = None;
        let mut label = None;
        let mut phis = Vec::new();
        let mut stmts = Vec::new();

        for stmt in block {
            match &stmt.inner {
                StmtInner::Label(l) => {
                    if label_stmt.is_none() {
                        label_stmt = Some(stmt.clone());
                        label = Some(l.label.clone());
                    }
                }
                StmtInner::Phi(p) => phis.push(p.clone()),
                _ => stmts.push(stmt.clone()),
            }
        }

        let label_stmt = label_stmt.expect("block missing label");
        let label = label.expect("block missing label");
        labels.push(label);
        data.push(BlockData {
            label_stmt,
            phis,
            stmts,
        });
    }

    let mut next_vreg = max_vreg_index(blocks, &[]) + 1;
    let mut phi_slots: HashMap<usize, Operand> = HashMap::new();
    let mut alloca_stmts: Vec<Stmt> = Vec::new();
    let mut phi_loads: Vec<Vec<Stmt>> = vec![Vec::new(); data.len()];

    for (b_idx, block) in data.iter().enumerate() {
        for phi in &block.phis {
            let dst_idx = local_index(&phi.dst).expect("phi dest must be local");
            let slot = phi_slots.entry(dst_idx).or_insert_with(|| {
                let ptr = LocalVariable::new(Dtype::ptr_to(phi.dst.dtype().clone()), next_vreg, None);
                next_vreg += 1;
                let slot = Operand::Local(ptr);
                alloca_stmts.push(Stmt::as_alloca(slot.clone()));
                slot
            });
            phi_loads[b_idx].push(Stmt::as_load(phi.dst.clone(), slot.clone()));
        }
    }

    let label_map = build_label_map(&labels);
    let (succs, preds) = build_cfg_from_stmts(&data, &label_map);

    let mut next_bb = next_basic_block_id(&labels);
    let mut split_edges: HashMap<(usize, usize), BlockLabel> = HashMap::new();
    let mut edge_copies: HashMap<(usize, usize), Vec<Stmt>> = HashMap::new();
    let mut direct_inserts: HashMap<usize, Vec<Stmt>> = HashMap::new();

    for (b_idx, block) in data.iter().enumerate() {
        if block.phis.is_empty() {
            continue;
        }
        for &pred in preds[b_idx].iter() {
            let stores = build_phi_stores(&block.phis, &labels[pred], &phi_slots);
            if stores.is_empty() {
                continue;
            }

            if succs[pred].len() == 1 {
                direct_inserts.entry(pred).or_default().extend(stores);
            } else {
                let new_label = BlockLabel::BasicBlock(next_bb);
                next_bb += 1;
                split_edges.insert((pred, b_idx), new_label.clone());
                edge_copies.insert((pred, b_idx), stores);
            }
        }
    }

    // Update terminators for split edges.
    for ((pred, succ), new_label) in split_edges.iter() {
        if let Some(term) = data[*pred].stmts.last_mut() {
            match &mut term.inner {
                StmtInner::Jump(j) => {
                    if label_key(&j.target) == label_key(&labels[*succ]) {
                        j.target = new_label.clone();
                    }
                }
                StmtInner::CJump(j) => {
                    if label_key(&j.true_label) == label_key(&labels[*succ]) {
                        j.true_label = new_label.clone();
                    }
                    if label_key(&j.false_label) == label_key(&labels[*succ]) {
                        j.false_label = new_label.clone();
                    }
                }
                _ => {}
            }
        }
    }

    // Insert copies for non-split edges.
    for (pred, copies) in direct_inserts {
        insert_copies_before_terminator(&mut data[pred].stmts, copies);
    }

    let mut out_blocks: Vec<Vec<Stmt>> = Vec::new();
    let entry_idx = labels
        .iter()
        .position(|l| matches!(l, BlockLabel::Function(_)))
        .unwrap_or(0);

    for (idx, block) in data.into_iter().enumerate() {
        let mut stmts = Vec::new();
        stmts.push(block.label_stmt);
        if idx == entry_idx {
            stmts.extend(alloca_stmts.iter().cloned());
        }
        stmts.extend(phi_loads[idx].iter().cloned());
        stmts.extend(block.stmts);
        out_blocks.push(stmts);
    }

    // Append new edge blocks for split edges.
    for ((pred, succ), new_label) in split_edges.iter() {
        let copies = edge_copies
            .get(&(*pred, *succ))
            .cloned()
            .unwrap_or_default();
        let mut stmts = Vec::new();
        stmts.push(Stmt::as_label(new_label.clone()));
        stmts.extend(copies);
        stmts.push(Stmt::as_jump(labels[*succ].clone()));
        out_blocks.push(stmts);
    }

    out_blocks
}

#[derive(Clone)]
struct PhiInfo {
    var: usize,
    dst: Operand,
    incomings: Vec<(BlockLabel, Operand)>,
}

#[derive(Clone, Default)]
struct VarUsage {
    def_blocks: HashSet<usize>,
    load_before_store_blocks: HashSet<usize>,
    has_store: bool,
    has_load: bool,
    invalid: bool,
}

struct Renamer<'a> {
    blocks: &'a [Vec<Stmt>],
    labels: Vec<BlockLabel>,
    succs: Vec<Vec<usize>>,
    dom_children: Vec<Vec<usize>>,
    phi_nodes: Vec<Vec<PhiInfo>>,
    promoted: HashSet<usize>,
    var_stack: HashMap<usize, Vec<Operand>>,
    alias_map: HashMap<usize, Operand>,
    rewritten: Vec<Vec<Stmt>>,
}

impl<'a> Renamer<'a> {
    fn new(
        blocks: &'a [Vec<Stmt>],
        labels: Vec<BlockLabel>,
        succs: Vec<Vec<usize>>,
        dom_children: Vec<Vec<usize>>,
        phi_nodes: Vec<Vec<PhiInfo>>,
        promoted: HashSet<usize>,
    ) -> Self {
        let mut var_stack = HashMap::new();
        for var in promoted.iter().copied() {
            var_stack.insert(var, Vec::new());
        }
        Self {
            blocks,
            labels,
            succs,
            dom_children,
            phi_nodes,
            promoted,
            var_stack,
            alias_map: HashMap::new(),
            rewritten: vec![Vec::new(); blocks.len()],
        }
    }

    fn run(&mut self, idom: &[Option<usize>]) {
        let roots: Vec<usize> = (0..self.blocks.len())
            .filter(|&i| idom[i].is_none())
            .collect();

        for root in roots {
            self.clear_state();
            self.rename_block(root);
        }
    }

    fn finish_blocks(self) -> Vec<Vec<Stmt>> {
        let mut out = Vec::with_capacity(self.blocks.len());

        for (i, block) in self.blocks.iter().enumerate() {
            let label_stmt = block
                .iter()
                .find(|s| matches!(s.inner, StmtInner::Label(_)))
                .cloned();
            let mut stmts = Vec::new();
            if let Some(label) = label_stmt {
                stmts.push(label);
            }
            for phi in &self.phi_nodes[i] {
                stmts.push(Stmt::as_phi(phi.dst.clone(), phi.incomings.clone()));
            }
            stmts.extend(self.rewritten[i].iter().cloned());
            out.push(stmts);
        }

        out
    }

    fn rename_block(&mut self, block_idx: usize) {
        let mut pushed_vars: Vec<usize> = Vec::new();
        let mut added_aliases: Vec<usize> = Vec::new();

        for phi in &self.phi_nodes[block_idx] {
            if let Some(stack) = self.var_stack.get_mut(&phi.var) {
                stack.push(phi.dst.clone());
                pushed_vars.push(phi.var);
            }
        }

        for stmt in &self.blocks[block_idx] {
            if matches!(stmt.inner, StmtInner::Label(_)) {
                continue;
            }

            match &stmt.inner {
                StmtInner::Alloca(a) => {
                    if let Some(idx) = local_index(&a.dst) {
                        if self.promoted.contains(&idx) {
                            continue;
                        }
                    }
                    self.rewritten[block_idx].push(stmt.clone());
                }
                StmtInner::Store(s) => {
                    if let Some(ptr_idx) = local_index(&s.ptr) {
                        if self.promoted.contains(&ptr_idx) {
                            let src = self.resolve_alias(&s.src);
                            if let Some(stack) = self.var_stack.get_mut(&ptr_idx) {
                                stack.push(src.clone());
                                pushed_vars.push(ptr_idx);
                            }
                            continue;
                        }
                    }
                    let rewritten = self.rewrite_stmt(stmt);
                    self.rewritten[block_idx].push(rewritten);
                }
                StmtInner::Load(s) => {
                    if let Some(ptr_idx) = local_index(&s.ptr) {
                        if self.promoted.contains(&ptr_idx) {
                            if let Some(dst_idx) = local_index(&s.dst) {
                                let cur = self.current_value(ptr_idx);
                                self.alias_map.insert(dst_idx, cur);
                                added_aliases.push(dst_idx);
                            }
                            continue;
                        }
                    }
                    let rewritten = self.rewrite_stmt(stmt);
                    self.rewritten[block_idx].push(rewritten);
                }
                _ => {
                    let rewritten = self.rewrite_stmt(stmt);
                    self.rewritten[block_idx].push(rewritten);
                }
            }
        }

        let pred_label = self.labels[block_idx].clone();
        let succs = self.succs[block_idx].clone();
        for succ in succs {
            let incoming_vals: Vec<Operand> = self.phi_nodes[succ]
                .iter()
                .map(|phi| self.current_value(phi.var))
                .collect();
            for (phi, val) in self.phi_nodes[succ].iter_mut().zip(incoming_vals.into_iter()) {
                phi.incomings.push((pred_label.clone(), val));
            }
        }

        let children = self.dom_children[block_idx].clone();
        for child in children {
            self.rename_block(child);
        }

        for idx in added_aliases {
            self.alias_map.remove(&idx);
        }
        for var in pushed_vars.into_iter().rev() {
            if let Some(stack) = self.var_stack.get_mut(&var) {
                stack.pop();
            }
        }
    }

    fn clear_state(&mut self) {
        for stack in self.var_stack.values_mut() {
            stack.clear();
        }
        self.alias_map.clear();
    }

    fn current_value(&self, var: usize) -> Operand {
        self.var_stack
            .get(&var)
            .and_then(|stack| stack.last())
            .map(|v| self.resolve_alias(v))
            .unwrap_or_else(|| Operand::from(0))
    }

    fn resolve_alias(&self, op: &Operand) -> Operand {
        let mut cur = op.clone();
        loop {
            match &cur {
                Operand::Local(l) => {
                    if let Some(next) = self.alias_map.get(&l.index) {
                        cur = next.clone();
                        continue;
                    }
                }
                _ => {}
            }
            break;
        }
        cur
    }

    fn rewrite_stmt(&self, stmt: &Stmt) -> Stmt {
        match &stmt.inner {
            StmtInner::Call(s) => {
                let args = s
                    .args
                    .iter()
                    .map(|a| self.resolve_alias(a))
                    .collect::<Vec<_>>();
                Stmt::as_call(s.func_name.clone(), s.res.clone(), args)
            }
            StmtInner::Load(s) => {
                let ptr = self.resolve_alias(&s.ptr);
                Stmt::as_load(s.dst.clone(), ptr)
            }
            StmtInner::BiOp(s) => {
                let left = self.resolve_alias(&s.left);
                let right = self.resolve_alias(&s.right);
                Stmt::as_biop(s.kind.clone(), left, right, s.dst.clone())
            }
            StmtInner::Alloca(s) => Stmt::as_alloca(s.dst.clone()),
            StmtInner::Cmp(s) => {
                let left = self.resolve_alias(&s.left);
                let right = self.resolve_alias(&s.right);
                Stmt::as_cmp(s.kind.clone(), left, right, s.dst.clone())
            }
            StmtInner::CJump(s) => {
                let cond = self.resolve_alias(&s.dst);
                Stmt::as_cjump(cond, s.true_label.clone(), s.false_label.clone())
            }
            StmtInner::Label(s) => Stmt::as_label(s.label.clone()),
            StmtInner::Store(s) => {
                let src = self.resolve_alias(&s.src);
                let ptr = self.resolve_alias(&s.ptr);
                Stmt::as_store(src, ptr)
            }
            StmtInner::Jump(s) => Stmt::as_jump(s.target.clone()),
            StmtInner::Gep(s) => {
                let base_ptr = self.resolve_alias(&s.base_ptr);
                let index = self.resolve_alias(&s.index);
                Stmt::as_gep(s.new_ptr.clone(), base_ptr, index)
            }
            StmtInner::Return(s) => {
                let val = s.val.as_ref().map(|v| self.resolve_alias(v));
                Stmt::as_return(val)
            }
            StmtInner::Phi(s) => Stmt::as_phi(s.dst.clone(), s.incomings.clone()),
        }
    }
}

fn collect_alloca_candidates(blocks: &[Vec<Stmt>]) -> HashSet<usize> {
    let mut candidates = HashSet::new();
    for stmt in blocks.iter().flatten() {
        if let StmtInner::Alloca(a) = &stmt.inner {
            if let Some(idx) = local_index(&a.dst) {
                if let Dtype::Pointer { inner, length: 0 } = a.dst.dtype() {
                    if matches!(inner.as_ref(), Dtype::I32) {
                        candidates.insert(idx);
                    }
                }
            }
        }
    }
    candidates
}

fn analyze_usage(blocks: &[Vec<Stmt>], candidates: &HashSet<usize>) -> HashMap<usize, VarUsage> {
    let mut usage: HashMap<usize, VarUsage> =
        candidates.iter().map(|&v| (v, VarUsage::default())).collect();

    for (b_idx, block) in blocks.iter().enumerate() {
        let mut store_seen: HashSet<usize> = HashSet::new();
        for stmt in block {
            match &stmt.inner {
                StmtInner::Load(s) => {
                    if let Some(ptr_idx) = candidate_index(&s.ptr, candidates) {
                        if !store_seen.contains(&ptr_idx) {
                            if let Some(info) = usage.get_mut(&ptr_idx) {
                                info.load_before_store_blocks.insert(b_idx);
                            }
                        }
                        if let Some(info) = usage.get_mut(&ptr_idx) {
                            info.has_load = true;
                        }
                    }
                    if let Some(dst_idx) = candidate_index(&s.dst, candidates) {
                        if let Some(info) = usage.get_mut(&dst_idx) {
                            info.invalid = true;
                        }
                    }
                }
                StmtInner::Store(s) => {
                    if let Some(ptr_idx) = candidate_index(&s.ptr, candidates) {
                        store_seen.insert(ptr_idx);
                        if let Some(info) = usage.get_mut(&ptr_idx) {
                            info.has_store = true;
                            info.def_blocks.insert(b_idx);
                        }
                    }
                    if let Some(src_idx) = candidate_index(&s.src, candidates) {
                        if let Some(info) = usage.get_mut(&src_idx) {
                            info.invalid = true;
                        }
                    }
                }
                StmtInner::BiOp(s) => {
                    mark_invalid_if_candidate(&mut usage, candidates, &s.left);
                    mark_invalid_if_candidate(&mut usage, candidates, &s.right);
                }
                StmtInner::Cmp(s) => {
                    mark_invalid_if_candidate(&mut usage, candidates, &s.left);
                    mark_invalid_if_candidate(&mut usage, candidates, &s.right);
                }
                StmtInner::CJump(s) => {
                    mark_invalid_if_candidate(&mut usage, candidates, &s.dst);
                }
                StmtInner::Call(s) => {
                    if let Some(res) = &s.res {
                        mark_invalid_if_candidate(&mut usage, candidates, res);
                    }
                    for arg in &s.args {
                        mark_invalid_if_candidate(&mut usage, candidates, arg);
                    }
                }
                StmtInner::Gep(s) => {
                    mark_invalid_if_candidate(&mut usage, candidates, &s.base_ptr);
                    mark_invalid_if_candidate(&mut usage, candidates, &s.index);
                }
                StmtInner::Return(s) => {
                    if let Some(val) = &s.val {
                        mark_invalid_if_candidate(&mut usage, candidates, val);
                    }
                }
                StmtInner::Phi(s) => {
                    mark_invalid_if_candidate(&mut usage, candidates, &s.dst);
                    for (_, val) in &s.incomings {
                        mark_invalid_if_candidate(&mut usage, candidates, val);
                    }
                }
                StmtInner::Alloca(_) | StmtInner::Label(_) | StmtInner::Jump(_) => {}
            }
        }
    }

    usage
}


fn select_promotable(
    usage: &HashMap<usize, VarUsage>,
    dom: &[HashSet<usize>],
) -> HashMap<usize, VarUsage> {
    let mut out = HashMap::new();
    for (&var, info) in usage.iter() {
        if info.invalid || !info.has_store {
            continue;
        }
        if info.def_blocks.len() <= 1 {
            continue;
        }
        let mut ok = true;
        for &block in info.load_before_store_blocks.iter() {
            let mut has_dom_def = false;
            for &def_block in info.def_blocks.iter() {
                if def_block != block && dom[block].contains(&def_block) {
                    has_dom_def = true;
                    break;
                }
            }
            if !has_dom_def {
                ok = false;
                break;
            }
        }
        if ok {
            out.insert(var, info.clone());
        }
    }
    out
}

fn mark_invalid_if_candidate(
    usage: &mut HashMap<usize, VarUsage>,
    candidates: &HashSet<usize>,
    op: &Operand,
) {
    if let Some(idx) = candidate_index(op, candidates) {
        if let Some(info) = usage.get_mut(&idx) {
            info.invalid = true;
        }
    }
}

fn candidate_index(op: &Operand, candidates: &HashSet<usize>) -> Option<usize> {
    local_index(op).filter(|idx| candidates.contains(idx))
}

fn local_index(op: &Operand) -> Option<usize> {
    op.as_local().map(|l| l.index)
}

fn max_vreg_index(blocks: &[Vec<Stmt>], args: &[LocalVariable]) -> usize {
    let mut max_idx = 0;
    for arg in args {
        max_idx = max_idx.max(arg.index);
    }
    for stmt in blocks.iter().flatten() {
        update_max_from_stmt(&mut max_idx, stmt);
    }
    max_idx
}

fn update_max_from_stmt(max_idx: &mut usize, stmt: &Stmt) {
    match &stmt.inner {
        StmtInner::Call(s) => {
            if let Some(res) = &s.res {
                update_max_from_operand(max_idx, res);
            }
            for a in &s.args {
                update_max_from_operand(max_idx, a);
            }
        }
        StmtInner::Load(s) => {
            update_max_from_operand(max_idx, &s.dst);
            update_max_from_operand(max_idx, &s.ptr);
        }
        StmtInner::Phi(s) => {
            update_max_from_operand(max_idx, &s.dst);
            for (_, val) in &s.incomings {
                update_max_from_operand(max_idx, val);
            }
        }
        StmtInner::BiOp(s) => {
            update_max_from_operand(max_idx, &s.left);
            update_max_from_operand(max_idx, &s.right);
            update_max_from_operand(max_idx, &s.dst);
        }
        StmtInner::Alloca(s) => update_max_from_operand(max_idx, &s.dst),
        StmtInner::Cmp(s) => {
            update_max_from_operand(max_idx, &s.left);
            update_max_from_operand(max_idx, &s.right);
            update_max_from_operand(max_idx, &s.dst);
        }
        StmtInner::CJump(s) => update_max_from_operand(max_idx, &s.dst),
        StmtInner::Label(_) => {}
        StmtInner::Store(s) => {
            update_max_from_operand(max_idx, &s.src);
            update_max_from_operand(max_idx, &s.ptr);
        }
        StmtInner::Jump(_) => {}
        StmtInner::Gep(s) => {
            update_max_from_operand(max_idx, &s.new_ptr);
            update_max_from_operand(max_idx, &s.base_ptr);
            update_max_from_operand(max_idx, &s.index);
        }
        StmtInner::Return(s) => {
            if let Some(val) = &s.val {
                update_max_from_operand(max_idx, val);
            }
        }
    }
}

fn update_max_from_operand(max_idx: &mut usize, op: &Operand) {
    if let Some(idx) = local_index(op) {
        *max_idx = (*max_idx).max(idx);
    }
}

fn collect_labels(blocks: &[Vec<Stmt>]) -> Vec<BlockLabel> {
    blocks
        .iter()
        .map(|block| {
            block
                .iter()
                .find_map(|stmt| match &stmt.inner {
                    StmtInner::Label(l) => Some(l.label.clone()),
                    _ => None,
                })
                .expect("block missing label")
        })
        .collect()
}

fn build_label_map(labels: &[BlockLabel]) -> HashMap<String, usize> {
    let mut map = HashMap::new();
    for (i, label) in labels.iter().enumerate() {
        map.insert(label_key(label), i);
    }
    map
}

fn build_cfg(
    blocks: &[Vec<Stmt>],
    label_map: &HashMap<String, usize>,
) -> (Vec<Vec<usize>>, Vec<Vec<usize>>) {
    let n = blocks.len();
    let mut succs: Vec<Vec<usize>> = vec![Vec::new(); n];
    let mut preds: Vec<Vec<usize>> = vec![Vec::new(); n];

    for (i, block) in blocks.iter().enumerate() {
        let term = block.iter().rev().find(|s| !matches!(s.inner, StmtInner::Label(_)));
        let successors = match term.map(|s| &s.inner) {
            Some(StmtInner::Jump(j)) => vec![label_map[&label_key(&j.target)]],
            Some(StmtInner::CJump(j)) => vec![
                label_map[&label_key(&j.true_label)],
                label_map[&label_key(&j.false_label)],
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

    for (i, succ) in succs.iter().enumerate() {
        for &s in succ {
            preds[s].push(i);
        }
    }

    (succs, preds)
}

fn compute_dominators(preds: &[Vec<usize>]) -> Vec<HashSet<usize>> {
    let n = preds.len();
    let mut dom = vec![HashSet::new(); n];
    for i in 0..n {
        if i == 0 {
            dom[i].insert(0);
        } else {
            dom[i] = (0..n).collect();
        }
    }

    let mut changed = true;
    while changed {
        changed = false;
        for i in 1..n {
            let new_dom = if preds[i].is_empty() {
                let mut set = HashSet::new();
                set.insert(i);
                set
            } else {
                let mut iter = preds[i].iter();
                let first = *iter.next().unwrap();
                let mut intersect = dom[first].clone();
                for &p in iter {
                    intersect = intersect
                        .intersection(&dom[p])
                        .copied()
                        .collect::<HashSet<_>>();
                }
                intersect.insert(i);
                intersect
            };
            if new_dom != dom[i] {
                dom[i] = new_dom;
                changed = true;
            }
        }
    }

    dom
}

fn compute_idom(preds: &[Vec<usize>], succs: &[Vec<usize>]) -> Vec<Option<usize>> {
    let n = succs.len();
    let start = 0;
    let order = reverse_postorder(succs, start);
    let mut rpo_index = vec![usize::MAX; n];
    for (i, b) in order.iter().enumerate() {
        rpo_index[*b] = i;
    }

    let mut idom = vec![None; n];
    idom[start] = Some(start);
    let mut changed = true;
    while changed {
        changed = false;
        for &b in order.iter().skip(1) {
            let mut new_idom: Option<usize> = None;
            for &p in &preds[b] {
                if idom[p].is_none() {
                    continue;
                }
                new_idom = Some(match new_idom {
                    None => p,
                    Some(cur) => intersect(p, cur, &idom, &rpo_index),
                });
            }
            if idom[b] != new_idom {
                idom[b] = new_idom;
                changed = true;
            }
        }
    }
    if start < n {
        idom[start] = None;
    }
    idom
}

fn intersect(
    mut b1: usize,
    mut b2: usize,
    idom: &[Option<usize>],
    rpo_index: &[usize],
) -> usize {
    while b1 != b2 {
        while rpo_index[b1] > rpo_index[b2] {
            b1 = idom[b1].expect("missing idom during intersect");
        }
        while rpo_index[b2] > rpo_index[b1] {
            b2 = idom[b2].expect("missing idom during intersect");
        }
    }
    b1
}

fn reverse_postorder(succs: &[Vec<usize>], start: usize) -> Vec<usize> {
    let n = succs.len();
    let mut visited = vec![false; n];
    let mut post = Vec::new();

    fn dfs(v: usize, succs: &[Vec<usize>], visited: &mut [bool], post: &mut Vec<usize>) {
        if visited[v] {
            return;
        }
        visited[v] = true;
        for &s in &succs[v] {
            dfs(s, succs, visited, post);
        }
        post.push(v);
    }

    dfs(start, succs, &mut visited, &mut post);
    post.reverse();
    post
}

fn compute_dominance_frontiers(
    succs: &[Vec<usize>],
    idom: &[Option<usize>],
    dom_children: &[Vec<usize>],
) -> Vec<HashSet<usize>> {
    let n = succs.len();
    let mut df: Vec<HashSet<usize>> = vec![HashSet::new(); n];

    fn dfs(
        b: usize,
        succs: &[Vec<usize>],
        idom: &[Option<usize>],
        dom_children: &[Vec<usize>],
        df: &mut [HashSet<usize>],
    ) {
        for &s in &succs[b] {
            if idom[s] != Some(b) {
                df[b].insert(s);
            }
        }
        for &c in &dom_children[b] {
            dfs(c, succs, idom, dom_children, df);
            let child_df = df[c].clone();
            for w in child_df {
                if idom[w] != Some(b) {
                    df[b].insert(w);
                }
            }
        }
    }

    for (b, parent) in idom.iter().enumerate() {
        if parent.is_none() {
            dfs(b, succs, idom, dom_children, &mut df);
        }
    }

    df
}

fn compute_live_in(
    use_blocks: &HashSet<usize>,
    def_blocks: &HashSet<usize>,
    succs: &[Vec<usize>],
) -> Vec<bool> {
    let n = succs.len();
    let mut live_in = vec![false; n];
    let mut live_out = vec![false; n];

    let mut changed = true;
    while changed {
        changed = false;
        for b in (0..n).rev() {
            let mut out = false;
            for &s in &succs[b] {
                if live_in[s] {
                    out = true;
                    break;
                }
            }
            let in_val = use_blocks.contains(&b) || (out && !def_blocks.contains(&b));
            if live_out[b] != out || live_in[b] != in_val {
                live_out[b] = out;
                live_in[b] = in_val;
                changed = true;
            }
        }
    }

    live_in
}

fn build_dom_tree(idom: &[Option<usize>]) -> Vec<Vec<usize>> {
    let mut children = vec![Vec::new(); idom.len()];
    for (b, parent) in idom.iter().enumerate() {
        if let Some(p) = parent {
            children[*p].push(b);
        }
    }
    children
}

#[derive(Clone)]
struct BlockData {
    label_stmt: Stmt,
    phis: Vec<PhiStmt>,
    stmts: Vec<Stmt>,
}

fn build_cfg_from_stmts(
    blocks: &[BlockData],
    label_map: &HashMap<String, usize>,
) -> (Vec<Vec<usize>>, Vec<Vec<usize>>) {
    let n = blocks.len();
    let mut succs: Vec<Vec<usize>> = vec![Vec::new(); n];
    let mut preds: Vec<Vec<usize>> = vec![Vec::new(); n];

    for (i, block) in blocks.iter().enumerate() {
        let term = block
            .stmts
            .iter()
            .rev()
            .find(|s| !matches!(s.inner, StmtInner::Label(_)));
        let successors = match term.map(|s| &s.inner) {
            Some(StmtInner::Jump(j)) => vec![label_map[&label_key(&j.target)]],
            Some(StmtInner::CJump(j)) => vec![
                label_map[&label_key(&j.true_label)],
                label_map[&label_key(&j.false_label)],
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

    for (i, succ) in succs.iter().enumerate() {
        for &s in succ {
            preds[s].push(i);
        }
    }

    (succs, preds)
}

fn build_phi_stores(
    phis: &[PhiStmt],
    pred_label: &BlockLabel,
    phi_slots: &HashMap<usize, Operand>,
) -> Vec<Stmt> {
    let pred_key = label_key(pred_label);
    phis.iter()
        .map(|phi| {
            let incoming = phi
                .incomings
                .iter()
                .find(|(label, _)| label_key(label) == pred_key)
                .map(|(_, val)| val.clone())
                .unwrap_or_else(|| Operand::from(0));
            let dst_idx = local_index(&phi.dst).expect("phi dest must be local");
            let slot = phi_slots
                .get(&dst_idx)
                .expect("missing phi slot for dest")
                .clone();
            Stmt::as_store(incoming, slot)
        })
        .collect()
}

fn insert_copies_before_terminator(stmts: &mut Vec<Stmt>, copies: Vec<Stmt>) {
    if copies.is_empty() {
        return;
    }
    let insert_pos = match stmts.last() {
        Some(last)
            if matches!(
                last.inner,
                StmtInner::Jump(_) | StmtInner::CJump(_) | StmtInner::Return(_)
            ) =>
        {
            stmts.len() - 1
        }
        _ => stmts.len(),
    };
    stmts.splice(insert_pos..insert_pos, copies);
}

fn next_basic_block_id(labels: &[BlockLabel]) -> usize {
    labels
        .iter()
        .filter_map(|l| match l {
            BlockLabel::BasicBlock(n) => Some(*n),
            _ => None,
        })
        .max()
        .unwrap_or(0)
        + 1
}

fn label_key(label: &BlockLabel) -> String {
    format!("{}", label)
}
