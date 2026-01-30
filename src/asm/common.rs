mod layout;
mod phi_elimination;
mod stack;

pub use layout::{align_up, StructLayouts};
pub use phi_elimination::eliminate_phis;
pub use stack::{collect_alloca_ptrs, size_align_of_alloca, StackFrame, StackSlot};
