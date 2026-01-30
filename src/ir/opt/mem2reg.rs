use super::cfg::Cfg;
use super::dominator::DominatorInfo;
use super::liveness::Liveness;
use crate::ir::function::{BlockLabel, Function};
use crate::ir::stmt::{Stmt, StmtInner};
use crate::ir::types::Dtype;
use crate::ir::value::{LocalVariable, Operand};
use std::collections::{HashMap, HashSet, VecDeque};

pub fn mem2reg(func: &mut Function) {
    let next_vreg = func.next_vreg;
    if let Some(pass) = Mem2Reg::new(func, next_vreg) {
        func.next_vreg = pass.run();
    }
}

struct Mem2Reg<'a> {
    blocks: &'a mut Vec<Vec<Stmt>>,
    #[allow(dead_code)]
    arguments: &'a [LocalVariable],
    cfg: Cfg,
    dom_info: DominatorInfo,
    next_vreg: usize,
}

impl<'a> Mem2Reg<'a> {
    fn new(func: &'a mut Function, next_vreg: usize) -> Option<Self> {
        let blocks = func.blocks.as_mut()?;
        if blocks.is_empty() {
            return None;
        }

        let cfg = Cfg::from_blocks(blocks);
        let dom_info = DominatorInfo::compute(&cfg);

        Some(Self {
            blocks,
            arguments: &func.arguments,
            cfg,
            dom_info,
            next_vreg,
        })
    }

    fn run(mut self) -> usize {
        let analysis = AllocaAnalysis::from_blocks(self.blocks);
        let promotable = analysis.promotable_vars(&self.dom_info);

        if promotable.is_empty() {
            return self.next_vreg;
        }

        let mut phi_placement = PhiPlacement::new(self.cfg.num_blocks());
        self.place_phis(&promotable, &mut phi_placement);

        let mut renamer = Renamer::new(
            self.blocks,
            &self.cfg,
            &self.dom_info,
            &mut phi_placement,
            promotable.keys().copied().collect(),
        );
        renamer.run();
        *self.blocks = renamer.finish();

        self.next_vreg
    }

    fn place_phis(&mut self, promotable: &HashMap<usize, VarUsage>, phi_placement: &mut PhiPlacement) {
        for (&var_idx, info) in promotable.iter() {
            if !info.has_load {
                continue;
            }

            let liveness = Liveness::compute(
                &info.load_before_store_blocks,
                &info.def_blocks,
                &self.cfg,
            );

            let mut worklist: VecDeque<usize> = info.def_blocks.iter().copied().collect();

            while let Some(b) = worklist.pop_front() {
                for &y in self.dom_info.dominance_frontier(b) {
                    if !liveness.is_live_in(y) {
                        continue;
                    }
                    if phi_placement.has_phi(y, var_idx) {
                        continue;
                    }

                    let idx = self.next_vreg;
                    self.next_vreg += 1;
                    let dst = Operand::Local(LocalVariable::new(Dtype::I32, idx, None));
                    phi_placement.insert_phi(y, var_idx, dst);

                    if !info.def_blocks.contains(&y) {
                        worklist.push_back(y);
                    }
                }
            }
        }
    }
}

struct AllocaAnalysis {
    #[allow(dead_code)]
    candidates: HashSet<usize>,
    usage: HashMap<usize, VarUsage>,
}

impl AllocaAnalysis {
    fn from_blocks(blocks: &[Vec<Stmt>]) -> Self {
        let candidates = Self::collect_candidates(blocks);
        let usage = Self::analyze_usage(blocks, &candidates);
        Self { candidates, usage }
    }

    fn promotable_vars(&self, dom_info: &DominatorInfo) -> HashMap<usize, VarUsage> {
        let mut out = HashMap::new();

        for (&var, info) in &self.usage {
            if info.invalid || !info.has_store {
                continue;
            }
            if info.def_blocks.len() <= 1 {
                continue;
            }

            let mut ok = true;
            for &block in &info.load_before_store_blocks {
                let has_dom_def = info.def_blocks.iter().any(|&def_block| {
                    def_block != block && dom_info.dominates(def_block, block)
                });
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

    fn collect_candidates(blocks: &[Vec<Stmt>]) -> HashSet<usize> {
        let mut candidates = HashSet::new();
        for stmt in blocks.iter().flatten() {
            if let StmtInner::Alloca(a) = &stmt.inner {
                if let Some(idx) = a.dst.vreg_index() {
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
        let mut usage: HashMap<usize, VarUsage> = candidates
            .iter()
            .map(|&v| (v, VarUsage::default()))
            .collect();

        for (b_idx, block) in blocks.iter().enumerate() {
            let mut store_seen: HashSet<usize> = HashSet::new();

            for stmt in block {
                match &stmt.inner {
                    StmtInner::Load(s) => {
                        if let Some(ptr_idx) = Self::candidate_index(&s.ptr, candidates) {
                            if !store_seen.contains(&ptr_idx) {
                                if let Some(info) = usage.get_mut(&ptr_idx) {
                                    info.load_before_store_blocks.insert(b_idx);
                                }
                            }
                            if let Some(info) = usage.get_mut(&ptr_idx) {
                                info.has_load = true;
                            }
                        }
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.dst);
                    }
                    StmtInner::Store(s) => {
                        if let Some(ptr_idx) = Self::candidate_index(&s.ptr, candidates) {
                            store_seen.insert(ptr_idx);
                            if let Some(info) = usage.get_mut(&ptr_idx) {
                                info.has_store = true;
                                info.def_blocks.insert(b_idx);
                            }
                        }
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.src);
                    }
                    StmtInner::BiOp(s) => {
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.left);
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.right);
                    }
                    StmtInner::Cmp(s) => {
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.left);
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.right);
                    }
                    StmtInner::CJump(s) => {
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.dst);
                    }
                    StmtInner::Call(s) => {
                        if let Some(res) = &s.res {
                            Self::mark_invalid_if_candidate(&mut usage, candidates, res);
                        }
                        for arg in &s.args {
                            Self::mark_invalid_if_candidate(&mut usage, candidates, arg);
                        }
                    }
                    StmtInner::Gep(s) => {
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.base_ptr);
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.index);
                    }
                    StmtInner::Return(s) => {
                        if let Some(val) = &s.val {
                            Self::mark_invalid_if_candidate(&mut usage, candidates, val);
                        }
                    }
                    StmtInner::Phi(s) => {
                        Self::mark_invalid_if_candidate(&mut usage, candidates, &s.dst);
                        for (_, val) in &s.incomings {
                            Self::mark_invalid_if_candidate(&mut usage, candidates, val);
                        }
                    }
                    StmtInner::Alloca(_) | StmtInner::Label(_) | StmtInner::Jump(_) => {}
                }
            }
        }

        usage
    }

    fn candidate_index(op: &Operand, candidates: &HashSet<usize>) -> Option<usize> {
        op.vreg_index().filter(|idx| candidates.contains(idx))
    }

    fn mark_invalid_if_candidate(
        usage: &mut HashMap<usize, VarUsage>,
        candidates: &HashSet<usize>,
        op: &Operand,
    ) {
        if let Some(idx) = Self::candidate_index(op, candidates) {
            if let Some(info) = usage.get_mut(&idx) {
                info.invalid = true;
            }
        }
    }
}

#[derive(Clone, Default)]
struct VarUsage {
    def_blocks: HashSet<usize>,
    load_before_store_blocks: HashSet<usize>,
    has_store: bool,
    has_load: bool,
    invalid: bool,
}

#[derive(Clone)]
struct PhiInfo {
    var: usize,
    dst: Operand,
    incomings: Vec<(BlockLabel, Operand)>,
}

struct PhiPlacement {
    nodes: Vec<Vec<PhiInfo>>,
    lookup: Vec<HashMap<usize, usize>>,
}

impl PhiPlacement {
    fn new(num_blocks: usize) -> Self {
        Self {
            nodes: vec![Vec::new(); num_blocks],
            lookup: vec![HashMap::new(); num_blocks],
        }
    }

    fn insert_phi(&mut self, block: usize, var: usize, dst: Operand) {
        let phi = PhiInfo {
            var,
            dst,
            incomings: Vec::new(),
        };
        self.lookup[block].insert(var, self.nodes[block].len());
        self.nodes[block].push(phi);
    }

    fn has_phi(&self, block: usize, var: usize) -> bool {
        self.lookup[block].contains_key(&var)
    }

    fn phis_at(&self, block: usize) -> &[PhiInfo] {
        &self.nodes[block]
    }

    fn phis_at_mut(&mut self, block: usize) -> &mut [PhiInfo] {
        &mut self.nodes[block]
    }
}

struct Renamer<'a> {
    blocks: &'a [Vec<Stmt>],
    cfg: &'a Cfg,
    dom_info: &'a DominatorInfo,
    phi_placement: &'a mut PhiPlacement,
    promoted: HashSet<usize>,
    var_stack: HashMap<usize, Vec<Operand>>,
    alias_map: HashMap<usize, Operand>,
    rewritten: Vec<Vec<Stmt>>,
}

impl<'a> Renamer<'a> {
    fn new(
        blocks: &'a [Vec<Stmt>],
        cfg: &'a Cfg,
        dom_info: &'a DominatorInfo,
        phi_placement: &'a mut PhiPlacement,
        promoted: HashSet<usize>,
    ) -> Self {
        let mut var_stack = HashMap::new();
        for var in promoted.iter().copied() {
            var_stack.insert(var, Vec::new());
        }
        Self {
            blocks,
            cfg,
            dom_info,
            phi_placement,
            promoted,
            var_stack,
            alias_map: HashMap::new(),
            rewritten: vec![Vec::new(); blocks.len()],
        }
    }

    fn run(&mut self) {
        for root in self.dom_info.dom_tree_roots() {
            self.clear_state();
            self.rename_block(root);
        }
    }

    fn finish(self) -> Vec<Vec<Stmt>> {
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
            for phi in self.phi_placement.phis_at(i) {
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

        for phi in self.phi_placement.phis_at(block_idx) {
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
                    if let Some(idx) = a.dst.vreg_index() {
                        if self.promoted.contains(&idx) {
                            continue;
                        }
                    }
                    self.rewritten[block_idx].push(stmt.clone());
                }
                StmtInner::Store(s) => {
                    if let Some(ptr_idx) = s.ptr.vreg_index() {
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
                    if let Some(ptr_idx) = s.ptr.vreg_index() {
                        if self.promoted.contains(&ptr_idx) {
                            if let Some(dst_idx) = s.dst.vreg_index() {
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

        let pred_label = self.cfg.label(block_idx).clone();
        for &succ in self.cfg.successors(block_idx) {
            let incoming_vals: Vec<Operand> = self
                .phi_placement
                .phis_at(succ)
                .iter()
                .map(|phi| self.current_value(phi.var))
                .collect();

            for (phi, val) in self
                .phi_placement
                .phis_at_mut(succ)
                .iter_mut()
                .zip(incoming_vals)
            {
                phi.incomings.push((pred_label.clone(), val));
            }
        }

        let children: Vec<usize> = self.dom_info.dom_children(block_idx).to_vec();
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
            if let Operand::Local(l) = &cur {
                if let Some(next) = self.alias_map.get(&l.index) {
                    cur = next.clone();
                    continue;
                }
            }
            break;
        }
        cur
    }

    fn rewrite_stmt(&self, stmt: &Stmt) -> Stmt {
        match &stmt.inner {
            StmtInner::Call(s) => {
                let args = s.args.iter().map(|a| self.resolve_alias(a)).collect();
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
