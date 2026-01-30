//! Stack frame layout and alloca handling.
use super::{align_up, vreg_from_value, StructLayouts, VReg};
use crate::asm::error::Error;
use crate::ir;
use std::collections::HashMap;

/// A stack slot with an offset from the frame pointer.
#[derive(Debug, Clone, Copy)]
pub struct StackSlot {
    /// Offset from FP (negative for locals/spills, as stack grows downward).
    pub offset_from_fp: i64,
}

/// Stack frame layout for a function.
///
/// Manages allocation of stack slots for local variables (`alloca`) and
/// spilled registers during register allocation.
#[derive(Debug, Default)]
pub struct StackFrame {
    /// Alloca slots, indexed by the destination vreg.
    alloca_slots: HashMap<u32, StackSlot>,
    /// Spill slots for register allocation.
    spill_slots: HashMap<VReg, StackSlot>,
    /// Current size of allocated stack space (grows positively).
    size: i64,
}

impl StackFrame {
    /// Allocates a new stack slot with the given alignment and size.
    ///
    /// Returns a [`StackSlot`] with a negative offset from the frame pointer.
    pub fn alloc_slot(&mut self, align: i64, size: i64) -> StackSlot {
        let align = align.max(1);
        self.size = align_up(self.size, align);
        self.size += size;
        StackSlot {
            offset_from_fp: -self.size,
        }
    }

    pub fn alloc_alloca(&mut self, vreg: VReg, align: i64, size: i64) -> StackSlot {
        let slot = self.alloc_slot(align, size);
        self.alloca_slots.insert(vreg.0, slot);
        slot
    }

    pub fn alloc_spill(&mut self, vreg: VReg, align: i64, size: i64) -> StackSlot {
        let slot = self.alloc_slot(align, size);
        self.spill_slots.insert(vreg, slot);
        slot
    }

    pub fn has_alloca(&self, vreg: VReg) -> bool {
        self.alloca_slots.contains_key(&vreg.0)
    }

    pub fn alloca_slot(&self, vreg: VReg) -> Option<StackSlot> {
        self.alloca_slots.get(&vreg.0).copied()
    }

    pub fn spill_slot(&self, vreg: VReg) -> Option<StackSlot> {
        self.spill_slots.get(&vreg).copied()
    }

    /// Returns the total frame size, aligned to 16 bytes (AArch64 ABI requirement).
    pub fn frame_size_aligned(&self) -> i64 {
        align_up(self.size, 16)
    }
}

// =============================================================================
// Alloca Analysis
// =============================================================================

/// Collects alloca destinations and their types from IR blocks.
///
/// Scans all blocks for `alloca` instructions and builds a map from the
/// destination virtual register to the allocated type.
pub fn collect_alloca_ptrs(
    blocks: &[Vec<ir::stmt::Stmt>],
) -> Result<HashMap<VReg, ir::Dtype>, Error> {
    let mut out = HashMap::new();
    for stmt in blocks.iter().flatten() {
        if let ir::stmt::StmtInner::Alloca(a) = &stmt.inner {
            out.insert(vreg_from_value(&a.dst)?, a.dst.dtype().clone());
        }
    }
    Ok(out)
}

/// Computes size and alignment for an alloca'd type.
///
/// Handles pointer types (including arrays) and returns the total size
/// and alignment requirements for stack allocation.
pub fn size_align_of_alloca(
    dtype: &ir::Dtype,
    layouts: &StructLayouts,
) -> Result<(i64, i64), Error> {
    match dtype {
        ir::Dtype::Pointer { inner, length } => {
            let (inner_size, inner_align) = layouts.size_align_of(inner.as_ref())?;
            match length {
                // Local scalar pointer: allocate space for one element
                0 => Ok((inner_size, inner_align)),
                // Array: allocate space for n elements
                n => Ok(((*n as i64) * inner_size, inner_align)),
            }
        }
        _ => Err(Error::UnsupportedDtype {
            dtype: dtype.clone(),
        }),
    }
}
