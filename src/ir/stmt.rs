//! IR statement types.
//!
//! This module defines the IR statement representation:
//!
//! - [`Stmt`]: A single IR statement
//! - [`StmtInner`]: The kind of statement (load, store, call, etc.)
//! - Individual statement types (LoadStmt, StoreStmt, etc.)

use crate::ast;

use super::function::BlockLabel;
use super::types::Dtype;
use super::value::Operand;
use std::fmt::{self, Display, Formatter};

// =============================================================================
// Statement Types
// =============================================================================

/// The kind of IR statement.
#[derive(Clone)]
pub enum StmtInner {
    /// Function call.
    Call(CallStmt),
    /// Load from memory.
    Load(LoadStmt),
    /// Phi node.
    Phi(PhiStmt),
    /// Binary arithmetic operation.
    BiOp(BiOpStmt),
    /// Stack allocation.
    Alloca(AllocaStmt),
    /// Comparison.
    Cmp(CmpStmt),
    /// Conditional jump.
    CJump(CJumpStmt),
    /// Label declaration.
    Label(LabelStmt),
    /// Store to memory.
    Store(StoreStmt),
    /// Unconditional jump.
    Jump(JumpStmt),
    /// Get element pointer.
    Gep(GepStmt),
    /// Return from function.
    Return(ReturnStmt),
}

/// An IR statement with its inner data.
#[derive(Clone)]
pub struct Stmt {
    /// The statement data.
    pub inner: StmtInner,
}

// =============================================================================
// Statement Constructors
// =============================================================================

impl Stmt {
    /// Creates a call statement.
    pub fn as_call(func_name: String, res: Option<Operand>, args: Vec<Operand>) -> Self {
        Self {
            inner: StmtInner::Call(CallStmt {
                func_name,
                res,
                args,
            }),
        }
    }

    /// Creates a load statement.
    pub fn as_load(dst: Operand, ptr: Operand) -> Self {
        Self {
            inner: StmtInner::Load(LoadStmt { dst, ptr }),
        }
    }

    /// Creates a phi statement.
    pub fn as_phi(dst: Operand, incomings: Vec<(BlockLabel, Operand)>) -> Self {
        Self {
            inner: StmtInner::Phi(PhiStmt { dst, incomings }),
        }
    }

    /// Creates a binary operation statement.
    pub fn as_biop(kind: ast::ArithBiOp, left: Operand, right: Operand, dst: Operand) -> Self {
        Self {
            inner: StmtInner::BiOp(BiOpStmt {
                kind,
                left,
                right,
                dst,
            }),
        }
    }

    /// Creates an alloca statement.
    pub fn as_alloca(dst: Operand) -> Self {
        Self {
            inner: StmtInner::Alloca(AllocaStmt { dst }),
        }
    }

    /// Creates a comparison statement.
    pub fn as_cmp(kind: ast::ComOp, left: Operand, right: Operand, dst: Operand) -> Self {
        Self {
            inner: StmtInner::Cmp(CmpStmt {
                kind,
                left,
                right,
                dst,
            }),
        }
    }

    /// Creates a conditional jump statement.
    pub fn as_cjump(dst: Operand, true_label: BlockLabel, false_label: BlockLabel) -> Self {
        Self {
            inner: StmtInner::CJump(CJumpStmt {
                dst,
                true_label,
                false_label,
            }),
        }
    }

    /// Creates a label statement.
    pub fn as_label(label: BlockLabel) -> Self {
        Self {
            inner: StmtInner::Label(LabelStmt { label }),
        }
    }

    /// Creates a store statement.
    pub fn as_store(src: Operand, ptr: Operand) -> Self {
        Self {
            inner: StmtInner::Store(StoreStmt { src, ptr }),
        }
    }

    /// Creates an unconditional jump statement.
    pub fn as_jump(target: BlockLabel) -> Self {
        Self {
            inner: StmtInner::Jump(JumpStmt { target }),
        }
    }

    /// Creates a return statement.
    pub fn as_return(val: Option<Operand>) -> Self {
        Self {
            inner: StmtInner::Return(ReturnStmt { val }),
        }
    }

    /// Creates a GEP statement.
    pub fn as_gep(new_ptr: Operand, base_ptr: Operand, index: Operand) -> Self {
        Self {
            inner: StmtInner::Gep(GepStmt {
                new_ptr,
                base_ptr,
                index,
            }),
        }
    }
}

// =============================================================================
// Statement Display
// =============================================================================

impl Display for Stmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match &self.inner {
            StmtInner::Alloca(s) => write!(f, "\t{}", s),
            StmtInner::BiOp(s) => write!(f, "\t{}", s),
            StmtInner::CJump(s) => write!(f, "\t{}", s),
            StmtInner::Call(s) => write!(f, "\t{}", s),
            StmtInner::Cmp(s) => write!(f, "\t{}", s),
            StmtInner::Gep(s) => write!(f, "\t{}", s),
            StmtInner::Label(s) => write!(f, "{}", s),
            StmtInner::Load(s) => write!(f, "\t{}", s),
            StmtInner::Phi(s) => write!(f, "\t{}", s),
            StmtInner::Return(s) => write!(f, "\t{}", s),
            StmtInner::Store(s) => write!(f, "\t{}", s),
            StmtInner::Jump(s) => write!(f, "\t{}", s),
        }
    }
}

// =============================================================================
// Individual Statement Types
// =============================================================================

/// Function call statement.
#[derive(Clone)]
pub struct CallStmt {
    /// Function name.
    pub func_name: String,
    /// Optional result register.
    pub res: Option<Operand>,
    /// Call arguments.
    pub args: Vec<Operand>,
}

/// Load from memory statement.
#[derive(Clone)]
pub struct LoadStmt {
    /// Destination register.
    pub dst: Operand,
    /// Source pointer.
    pub ptr: Operand,
}

/// Phi node statement.
#[derive(Clone)]
pub struct PhiStmt {
    /// Destination register.
    pub dst: Operand,
    /// Incoming values with their predecessor labels.
    pub incomings: Vec<(BlockLabel, Operand)>,
}

/// Binary arithmetic operation statement.
#[derive(Clone)]
pub struct BiOpStmt {
    /// Operation kind.
    pub kind: ast::ArithBiOp,
    /// Left operand.
    pub left: Operand,
    /// Right operand.
    pub right: Operand,
    /// Destination register.
    pub dst: Operand,
}

/// Stack allocation statement.
#[derive(Clone)]
pub struct AllocaStmt {
    /// Destination pointer register.
    pub dst: Operand,
}

/// Comparison statement.
#[derive(Clone)]
pub struct CmpStmt {
    /// Comparison kind.
    pub kind: ast::ComOp,
    /// Left operand.
    pub left: Operand,
    /// Right operand.
    pub right: Operand,
    /// Destination register (boolean result).
    pub dst: Operand,
}

/// Conditional jump statement.
#[derive(Clone)]
pub struct CJumpStmt {
    /// Condition register.
    pub dst: Operand,
    /// Label to jump to if true.
    pub true_label: BlockLabel,
    /// Label to jump to if false.
    pub false_label: BlockLabel,
}

/// Label statement.
#[derive(Clone)]
pub struct LabelStmt {
    /// The label.
    pub label: BlockLabel,
}

/// Store to memory statement.
#[derive(Clone)]
pub struct StoreStmt {
    /// Source value.
    pub src: Operand,
    /// Destination pointer.
    pub ptr: Operand,
}

/// Unconditional jump statement.
#[derive(Clone)]
pub struct JumpStmt {
    /// Target label.
    pub target: BlockLabel,
}

/// Get element pointer statement.
#[derive(Clone)]
pub struct GepStmt {
    /// Result pointer.
    pub new_ptr: Operand,
    /// Base pointer.
    pub base_ptr: Operand,
    /// Index value.
    pub index: Operand,
}

/// Return statement.
#[derive(Clone)]
pub struct ReturnStmt {
    /// Optional return value.
    pub val: Option<Operand>,
}

// =============================================================================
// Statement Display Implementations
// =============================================================================

impl Display for CallStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        let args = self
            .args
            .iter()
            .map(|a| {
                if matches!(a.dtype(), Dtype::Pointer { .. }) {
                    format!("ptr {}", a)
                } else {
                    format!("{} {}", a.dtype(), a)
                }
            })
            .collect::<Vec<_>>()
            .join(", ");

        if let Some(res) = &self.res {
            write!(
                f,
                "{} = call {} @{}({})",
                res,
                &res.dtype(),
                self.func_name,
                args
            )
        } else {
            write!(f, "call void @{}({})", self.func_name, args)
        }
    }
}

impl Display for LoadStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{} = load {}, ptr {}, align 4",
            self.dst,
            self.dst.dtype(),
            self.ptr
        )
    }
}

impl Display for PhiStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        let dtype = self.dst.dtype();
        let incoming_str = self
            .incomings
            .iter()
            .map(|(label, val)| format!("[ {}, %{} ]", val, label))
            .collect::<Vec<_>>()
            .join(", ");
        write!(f, "{} = phi {} {}", self.dst, dtype, incoming_str)
    }
}

impl Display for StoreStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "store {} {}, ptr {}, align 4",
            self.src.dtype(),
            self.src,
            self.ptr
        )
    }
}

impl Display for AllocaStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self.dst.dtype() {
            Dtype::Pointer { inner, length } => match length {
                0 => write!(f, "{} = alloca {}, align 4", self.dst, inner),
                _ => write!(f, "{} = alloca {}, align 4", self.dst, self.dst.dtype()),
            },
            _ => write!(f, "{} = alloca {}, align 4", self.dst, self.dst.dtype()),
        }
    }
}

impl Display for BiOpStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{} = {} {} {}, {}",
            self.dst,
            self.kind,
            self.dst.dtype(),
            self.left,
            self.right
        )
    }
}

impl Display for CmpStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{} = icmp {} {} {}, {}",
            self.dst,
            self.kind,
            self.left.dtype(),
            self.left,
            self.right
        )
    }
}

impl Display for CJumpStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "br i1 {}, label %{}, label %{}",
            self.dst, &self.true_label, &self.false_label
        )
    }
}

impl Display for JumpStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "br label %{}", &self.target)
    }
}

impl Display for LabelStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{}:", self.label)
    }
}

impl Display for GepStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self.base_ptr.dtype() {
            Dtype::Pointer { length, .. } => match length {
                0 => write!(
                    f,
                    "{} = getelementptr {}, ptr {}, i32 {}",
                    self.new_ptr,
                    self.base_ptr.dtype(),
                    self.base_ptr,
                    self.index,
                ),
                _ => write!(
                    f,
                    "{} = getelementptr {}, ptr {}, i32 {}, i32 {}",
                    self.new_ptr,
                    self.base_ptr.dtype(),
                    self.base_ptr,
                    0,
                    self.index,
                ),
            },
            _ => Err(fmt::Error),
        }
    }
}

impl Display for ReturnStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match &self.val {
            Some(v) => write!(f, "ret {} {}", v.dtype(), v),
            None => write!(f, "ret void"),
        }
    }
}
