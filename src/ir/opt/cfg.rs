use crate::ir::function::BlockLabel;
use crate::ir::stmt::{Stmt, StmtInner};
use std::collections::HashMap;

#[allow(dead_code)]
pub struct Cfg {
    labels: Vec<BlockLabel>,
    label_map: HashMap<String, usize>,
    succs: Vec<Vec<usize>>,
    preds: Vec<Vec<usize>>,
}

#[allow(dead_code)]
impl Cfg {
    pub fn from_blocks(blocks: &[Vec<Stmt>]) -> Self {
        let labels = Self::collect_labels(blocks);
        let label_map = Self::build_label_map(&labels);
        let (succs, preds) = Self::build_edges(blocks, &label_map);

        Self {
            labels,
            label_map,
            succs,
            preds,
        }
    }

    pub fn num_blocks(&self) -> usize {
        self.labels.len()
    }

    pub fn successors(&self, block: usize) -> &[usize] {
        &self.succs[block]
    }

    pub fn predecessors(&self, block: usize) -> &[usize] {
        &self.preds[block]
    }

    pub fn label(&self, block: usize) -> &BlockLabel {
        &self.labels[block]
    }

    pub fn labels(&self) -> &[BlockLabel] {
        &self.labels
    }

    pub fn block_index(&self, label: &BlockLabel) -> Option<usize> {
        self.label_map.get(&label.key()).copied()
    }

    pub(crate) fn succs_vec(&self) -> &[Vec<usize>] {
        &self.succs
    }

    pub(crate) fn preds_vec(&self) -> &[Vec<usize>] {
        &self.preds
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
        labels
            .iter()
            .enumerate()
            .map(|(i, label)| (label.key(), i))
            .collect()
    }

    fn build_edges(
        blocks: &[Vec<Stmt>],
        label_map: &HashMap<String, usize>,
    ) -> (Vec<Vec<usize>>, Vec<Vec<usize>>) {
        let n = blocks.len();
        let mut succs: Vec<Vec<usize>> = vec![Vec::new(); n];
        let mut preds: Vec<Vec<usize>> = vec![Vec::new(); n];

        for (i, block) in blocks.iter().enumerate() {
            succs[i] = Self::compute_successors(block, i, n, label_map);
        }

        for (i, succ_list) in succs.iter().enumerate() {
            for &s in succ_list {
                preds[s].push(i);
            }
        }

        (succs, preds)
    }

    fn compute_successors(
        block: &[Stmt],
        block_idx: usize,
        num_blocks: usize,
        label_map: &HashMap<String, usize>,
    ) -> Vec<usize> {
        let term = block
            .iter()
            .rev()
            .find(|s| !matches!(s.inner, StmtInner::Label(_)));

        match term.map(|s| &s.inner) {
            Some(StmtInner::Jump(j)) => vec![label_map[&j.target.key()]],
            Some(StmtInner::CJump(j)) => vec![
                label_map[&j.true_label.key()],
                label_map[&j.false_label.key()],
            ],
            Some(StmtInner::Return(_)) => Vec::new(),
            _ => {
                if block_idx + 1 < num_blocks {
                    vec![block_idx + 1]
                } else {
                    Vec::new()
                }
            }
        }
    }
}

