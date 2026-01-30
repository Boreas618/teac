use super::cfg::Cfg;
use std::collections::HashSet;

pub struct DominatorInfo {
    dom: Vec<HashSet<usize>>,
    idom: Vec<Option<usize>>,
    children: Vec<Vec<usize>>,
    frontiers: Vec<HashSet<usize>>,
}

#[allow(dead_code)]
impl DominatorInfo {
    pub fn compute(cfg: &Cfg) -> Self {
        let preds = cfg.preds_vec();
        let succs = cfg.succs_vec();

        let dom = Self::compute_dominators(preds);
        let idom = Self::compute_idom(preds, succs);
        let children = Self::build_dom_tree(&idom);
        let frontiers = Self::compute_dominance_frontiers(succs, &idom, &children);

        Self {
            dom,
            idom,
            children,
            frontiers,
        }
    }

    pub fn dominates(&self, dominator: usize, block: usize) -> bool {
        self.dom[block].contains(&dominator)
    }

    pub fn immediate_dominator(&self, block: usize) -> Option<usize> {
        self.idom[block]
    }

    pub fn dom_children(&self, block: usize) -> &[usize] {
        &self.children[block]
    }

    pub fn dominance_frontier(&self, block: usize) -> &HashSet<usize> {
        &self.frontiers[block]
    }

    pub fn dominators(&self, block: usize) -> &HashSet<usize> {
        &self.dom[block]
    }

    pub fn dom_tree_roots(&self) -> impl Iterator<Item = usize> + '_ {
        self.idom
            .iter()
            .enumerate()
            .filter_map(|(i, idom)| if idom.is_none() { Some(i) } else { None })
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
        if n == 0 {
            return Vec::new();
        }

        let start = 0;
        let order = Self::reverse_postorder(succs, start);

        let mut rpo_index = vec![usize::MAX; n];
        for (i, &b) in order.iter().enumerate() {
            rpo_index[b] = i;
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
                        Some(cur) => Self::intersect(p, cur, &idom, &rpo_index),
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

    fn build_dom_tree(idom: &[Option<usize>]) -> Vec<Vec<usize>> {
        let mut children = vec![Vec::new(); idom.len()];
        for (b, parent) in idom.iter().enumerate() {
            if let Some(p) = parent {
                children[*p].push(b);
            }
        }
        children
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
}
