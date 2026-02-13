use crate::ir::function::Function;

pub(crate) mod cfg;
pub(crate) mod dominator;
pub(crate) mod liveness;
mod mem2reg;

pub use mem2reg::Mem2RegPass;

/// Function-level optimization pass interface.
pub trait FunctionPass {
    fn run(&self, func: &mut Function);
}

/// Simple ordered pass manager for function passes.
#[derive(Default)]
pub struct FunctionPassManager {
    passes: Vec<Box<dyn FunctionPass>>,
}

impl FunctionPassManager {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn with_default_pipeline() -> Self {
        let mut pm = Self::new();
        pm.add_pass(Mem2RegPass);
        pm
    }

    pub fn add_pass<P>(&mut self, pass: P)
    where
        P: FunctionPass + 'static,
    {
        self.passes.push(Box::new(pass));
    }

    pub fn run(&self, func: &mut Function) {
        for pass in &self.passes {
            pass.run(func);
        }
    }
}