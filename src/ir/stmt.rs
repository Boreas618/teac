use crate::ir::{self, LocalVariable};

use super::{BiOpKind, BlockLabel, Operand, RelOpKind};
use std::fmt::{self, Display, Formatter};
use std::rc::Rc;

#[derive(Clone)]
pub enum StmtInner {
    Call(CallStmt),
    Load(LoadStmt),
    BiOp(BiOpStmt),
    Alloca(AllocaStmt),
    Cmp(CmpStmt),
    CJump(CJumpStmt),
    Label(LabelStmt),
    Store(StoreStmt),
    Jump(JumpStmt),
    Gep(GepStmt),
    Return(ReturnStmt),
}

#[derive(Clone)]
pub struct Stmt {
    pub inner: StmtInner,
}

impl Stmt {
    pub fn as_call(
        func_name: String,
        res: Option<Rc<LocalVariable>>,
        args: Vec<Rc<dyn Operand>>,
    ) -> Self {
        Self {
            inner: StmtInner::Call(CallStmt {
                func_name,
                res,
                args,
            }),
        }
    }

    pub fn as_load(dst: Rc<dyn Operand>, ptr: Rc<dyn Operand>) -> Self {
        Self {
            inner: StmtInner::Load(LoadStmt { dst, ptr }),
        }
    }

    pub fn as_biop(
        kind: BiOpKind,
        left: Rc<dyn Operand>,
        right: Rc<dyn Operand>,
        dst: Rc<dyn Operand>,
    ) -> Self {
        Self {
            inner: StmtInner::BiOp(BiOpStmt {
                kind,
                left,
                right,
                dst,
            }),
        }
    }

    pub fn as_alloca(dst: Rc<dyn Operand>) -> Self {
        Self {
            inner: StmtInner::Alloca(AllocaStmt { dst }),
        }
    }

    pub fn as_cmp(
        kind: RelOpKind,
        left: Rc<dyn Operand>,
        right: Rc<dyn Operand>,
        dst: Rc<dyn Operand>,
    ) -> Self {
        Self {
            inner: StmtInner::Cmp(CmpStmt {
                kind,
                left,
                right,
                dst,
            }),
        }
    }

    pub fn as_cjump(dst: Rc<dyn Operand>, true_label: BlockLabel, false_label: BlockLabel) -> Self {
        Self {
            inner: StmtInner::CJump(CJumpStmt {
                dst,
                true_label,
                false_label,
            }),
        }
    }

    pub fn as_label(label: BlockLabel) -> Self {
        Self {
            inner: StmtInner::Label(LabelStmt { label }),
        }
    }

    pub fn as_store(src: Rc<dyn Operand>, ptr: Rc<dyn Operand>) -> Self {
        Self {
            inner: StmtInner::Store(StoreStmt { src, ptr }),
        }
    }

    pub fn as_jump(target: BlockLabel) -> Self {
        Self {
            inner: StmtInner::Jump(JumpStmt { target }),
        }
    }

    pub fn as_return(val: Option<Rc<dyn Operand>>) -> Self {
        Self {
            inner: StmtInner::Return(ReturnStmt { val }),
        }
    }

    pub fn as_gep(
        new_ptr: Rc<dyn Operand>,
        base_ptr: Rc<dyn Operand>,
        index: Rc<dyn Operand>,
    ) -> Self {
        Self {
            inner: StmtInner::Gep(GepStmt {
                new_ptr,
                base_ptr,
                index,
            }),
        }
    }
}

impl Display for Stmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        match &self.inner {
            StmtInner::Alloca(s) => write!(f, "\t{}", s),
            StmtInner::BiOp(s) => write!(f, "\t{}", s),
            StmtInner::CJump(s) => write!(f, "\t{}", s),
            StmtInner::Call(s) => write!(f, "\t{}", s),
            StmtInner::Cmp(s) => write!(f, "\t{}", s),
            StmtInner::Gep(s) => write!(f, "\t{}", s),
            StmtInner::Label(s) => write!(f, "{}", s),
            StmtInner::Load(s) => write!(f, "\t{}", s),
            StmtInner::Return(s) => write!(f, "\t{}", s),
            StmtInner::Store(s) => write!(f, "\t{}", s),
            StmtInner::Jump(s) => write!(f, "\t{}", s),
        }
    }
}

#[derive(Clone)]
pub struct CallStmt {
    func_name: String,
    res: Option<Rc<LocalVariable>>,
    args: Vec<Rc<dyn Operand>>,
}

#[derive(Clone)]
pub struct LoadStmt {
    dst: Rc<dyn Operand>,
    ptr: Rc<dyn Operand>,
}

#[derive(Clone)]
pub struct BiOpStmt {
    kind: BiOpKind,
    left: Rc<dyn Operand>,
    right: Rc<dyn Operand>,
    dst: Rc<dyn Operand>,
}

#[derive(Clone)]
pub struct AllocaStmt {
    dst: Rc<dyn Operand>,
}

#[derive(Clone)]
pub struct CmpStmt {
    kind: RelOpKind,
    left: Rc<dyn Operand>,
    right: Rc<dyn Operand>,
    dst: Rc<dyn Operand>,
}

#[derive(Clone)]
pub struct CJumpStmt {
    dst: Rc<dyn Operand>,
    true_label: BlockLabel,
    false_label: BlockLabel,
}

#[derive(Clone)]
pub struct LabelStmt {
    label: BlockLabel,
}

#[derive(Clone)]
pub struct StoreStmt {
    src: Rc<dyn Operand>,
    ptr: Rc<dyn Operand>,
}

#[derive(Clone)]
pub struct JumpStmt {
    target: BlockLabel,
}

#[derive(Clone)]
pub struct GepStmt {
    new_ptr: Rc<dyn Operand>,
    base_ptr: Rc<dyn Operand>,
    index: Rc<dyn Operand>,
}

#[derive(Clone)]
pub struct ReturnStmt {
    val: Option<Rc<dyn Operand>>,
}

impl Display for ir::BiOpKind {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        use ir::BiOpKind::*;
        match self {
            Add => write!(f, "add"),
            Sub => write!(f, "sub"),
            Mul => write!(f, "mul"),
            Div => write!(f, "udiv"),
        }
    }
}

impl Display for ir::RelOpKind {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        use ir::RelOpKind::*;
        match self {
            Eq => write!(f, "eq"),
            Ne => write!(f, "ne"),
            Gt => write!(f, "sgt"),
            Ge => write!(f, "sge"),
            Lt => write!(f, "slt"),
            Le => write!(f, "sle"),
        }
    }
}

impl Display for ir::Dtype {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            ir::Dtype::I32 => write!(f, "i32"),
            ir::Dtype::Void => write!(f, "void"),
            ir::Dtype::Struct { .. } => write!(f, "struct"),
            ir::Dtype::Pointer { inner, length } => {
                write!(f, "[{} x {}]", length, inner.as_ref())
            }
            ir::Dtype::Undecided => write!(f, "?"),
        }
    }
}

impl Display for CallStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        let args = self
            .args
            .iter()
            .map(|a| format!("{} {}", a.dtype(), a))
            .collect::<Vec<_>>()
            .join(", ");

        if let Some(res) = &self.res {
            write!(
                f,
                "{} = call {} @{}({})",
                res,
                &res.as_ref().dtype,
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
            ir::Dtype::Pointer { inner, length } => {
                if *length == 0 {
                    write!(f, "{} = alloca {}, align 4", self.dst, inner)
                } else {
                    write!(f, "{} = alloca {}, align 4", self.dst, self.dst.dtype())
                }
            }
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
        // Only valid if the base is a pointer
        if !matches!(self.base_ptr.dtype(), ir::Dtype::Pointer { .. }) {
            return Err(fmt::Error);
        }

        write!(
            f,
            "{} = getelementptr {}, ptr {}, i32 {}, i32 {}",
            self.new_ptr,
            self.base_ptr.dtype(),
            self.base_ptr,
            0,
            self.index,
        )
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
