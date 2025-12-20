//! Common types and utilities for code generation.
//!
//! This module provides shared abstractions used across all target backends:
//!
//! - [`AsmGenerator`]: Trait for target-specific code generators
//! - [`VReg`] / [`VRegKind`]: Virtual register representation
//! - [`StackFrame`] / [`StackSlot`]: Stack layout management
//! - [`StructLayout`] / [`StructLayouts`]: Aggregate type layouts

mod layout;
mod stack;
mod vreg;

pub use layout::{align_up, compute_struct_layouts, size_align_of_dtype, StructLayouts};
pub use stack::{collect_alloca_ptrs, size_align_of_alloca, StackFrame, StackSlot};
pub use vreg::{vreg_from_value, VReg, VRegKind};
