use crate::ir::function::{BasicBlock, BlockLabel};
use crate::ir::stmt::StmtInner;
use std::collections::HashMap;

pub struct Graph {
    succs: Vec<Vec<usize>>,
    preds: Vec<Vec<usize>>,
}

impl Graph {
    pub fn num_nodes(&self) -> usize {
        self.succs.len()
    }

    pub fn successors(&self, node: usize) -> &[usize] {
        &self.succs[node]
    }

    pub fn predecessors(&self, node: usize) -> &[usize] {
        &self.preds[node]
    }

    pub fn succs_vec(&self) -> &[Vec<usize>] {
        &self.succs
    }

    pub fn preds_vec(&self) -> &[Vec<usize>] {
        &self.preds
    }
}

pub struct Cfg {
    labels: Vec<BlockLabel>,
    graph: Graph,
}

impl Cfg {
    pub fn from_blocks(blocks: &[BasicBlock]) -> Self {
        let labels = Self::collect_labels(blocks);
        let label_map = Self::build_label_map(&labels);
        let graph = Self::build_graph(blocks, &label_map);

        Self { labels, graph }
    }

    pub fn graph(&self) -> &Graph {
        &self.graph
    }

    pub fn num_blocks(&self) -> usize {
        self.graph.num_nodes()
    }

    pub fn successors(&self, block: usize) -> &[usize] {
        self.graph.successors(block)
    }

    pub fn predecessors(&self, block: usize) -> &[usize] {
        self.graph.predecessors(block)
    }

    pub fn label(&self, block: usize) -> &BlockLabel {
        &self.labels[block]
    }

    pub fn labels(&self) -> &[BlockLabel] {
        &self.labels
    }

    fn collect_labels(blocks: &[BasicBlock]) -> Vec<BlockLabel> {
        blocks.iter().map(|block| block.label.clone()).collect()
    }

    fn build_label_map(labels: &[BlockLabel]) -> HashMap<String, usize> {
        labels
            .iter()
            .enumerate()
            .map(|(i, label)| (label.key(), i))
            .collect()
    }

    fn build_graph(blocks: &[BasicBlock], label_map: &HashMap<String, usize>) -> Graph {
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

        Graph { succs, preds }
    }

    fn compute_successors(
        block: &BasicBlock,
        block_idx: usize,
        num_blocks: usize,
        label_map: &HashMap<String, usize>,
    ) -> Vec<usize> {
        let term = block.stmts.last();

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
