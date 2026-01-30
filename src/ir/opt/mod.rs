mod cfg;
mod dominator;
mod liveness;
mod mem2reg;
mod phi_lowering;
mod vreg;

#[allow(unused_imports)]
pub use cfg::Cfg;
#[allow(unused_imports)]
pub use dominator::DominatorInfo;
#[allow(unused_imports)]
pub use liveness::Liveness;
#[allow(unused_imports)]
pub use vreg::VRegCounter;

pub use mem2reg::mem2reg;
pub use phi_lowering::lower_phis_for_codegen;
