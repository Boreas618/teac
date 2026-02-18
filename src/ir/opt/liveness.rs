use super::cfg::Graph;
use std::collections::HashSet;

pub struct Liveness {
    live_in: Vec<bool>,
    live_out: Vec<bool>,
}

impl Liveness {
    pub fn compute(
        use_blocks: &HashSet<usize>,
        def_blocks: &HashSet<usize>,
        graph: &Graph,
    ) -> Self {
        let n = graph.num_nodes();
        let mut live_in = vec![false; n];
        let mut live_out = vec![false; n];

        let mut changed = true;
        while changed {
            changed = false;
            for b in (0..n).rev() {
                // live_out[b] = ∪ live_in[s] for all successors s
                let mut out = false;
                for &s in graph.successors(b) {
                    if live_in[s] {
                        out = true;
                        break;
                    }
                }

                // live_in[b] = use[b] ∨ (live_out[b] ∧ ¬def[b])
                let in_val = use_blocks.contains(&b) || (out && !def_blocks.contains(&b));

                if live_out[b] != out || live_in[b] != in_val {
                    live_out[b] = out;
                    live_in[b] = in_val;
                    changed = true;
                }
            }
        }

        Self { live_in, live_out }
    }

    pub fn is_live_in(&self, block: usize) -> bool {
        self.live_in[block]
    }

    pub fn is_live_out(&self, block: usize) -> bool {
        self.live_out[block]
    }

    pub fn live_in_vec(&self) -> &[bool] {
        &self.live_in
    }
}
