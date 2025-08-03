mod gen;
mod stmt;

use crate::ast::{self, BoolBiOp};
use indexmap::IndexMap;
use std::rc::Rc;
use std::sync::atomic::{AtomicI32, Ordering};
use thiserror::Error;

#[derive(Clone, PartialEq, PartialOrd)]
pub enum Dtype {
    Void,
    I32,
    I64,
    U32,
    U64,
    F32,
    F64,
    Struct { name: String },
    Pointer { inner: Box<Dtype>, length: usize },
}

pub enum BiOpKind {
    Plus,
    Minus,
    Mul,
    Div,
}

pub enum RelOpKind {
    Eq,
    Ne,
    Lt,
    Gt,
    Le,
    Ge,
}

pub struct MemberDecl {
    kind: Dtype,
    len: usize,
    struct_name: String,
}

pub struct StructDef {
    name: String,
    members: Vec<MemberDecl>,
}

pub struct FnDecl {
    name: String,
    args: Vec<VarDef>,
}

pub struct VarDef {
    inner: Rc<Operand>,
    initializers: Option<Vec<i32>>,
}

pub enum GlobalDef {
    Struct(StructDef),
    Func(FnDecl),
}

#[derive(Clone)]
pub struct BlockLabel {
    name: String,
}

impl BlockLabel {
    fn from_index(index: i32) -> Self {
        BlockLabel {
            name: format!("bb{}", index),
        }
    }

    fn from_str(name: &str) -> Self {
        BlockLabel {
            name: name.to_string(),
        }
    }
}

pub trait Typed {
    fn dtype(&self) -> &Dtype;
}

pub struct GlobalVar {
    dtype: Dtype,
    identifier: String,
}

impl Typed for GlobalVar {
    fn dtype(&self) -> &Dtype {
        &self.dtype
    }
}

pub struct LocalVar {
    dtype: Dtype,
    index: i32,
    identifier: Option<String>,
}

impl Typed for LocalVar {
    fn dtype(&self) -> &Dtype {
        &self.dtype
    }
}

impl LocalVar {
    pub fn create_int(index: i32) -> Self {
        LocalVar {
            dtype: Dtype::I32,
            index,
            identifier: None,
        }
    }

    pub fn create_int_ptr(index: i32, length: usize) -> Self {
        LocalVar {
            dtype: Dtype::Pointer {
                inner: Box::new(Dtype::I32),
                length,
            },
            index,
            identifier: None,
        }
    }

    pub fn create_struct(index: i32, name: String) -> Self {
        LocalVar {
            dtype: Dtype::Struct { name },
            index,
            identifier: None,
        }
    }

    pub fn create_struct_ptr(index: i32, length: usize, name: String) -> Self {
        LocalVar {
            dtype: Dtype::Pointer {
                inner: Box::new(Dtype::Struct { name }),
                length,
            },
            index,
            identifier: None,
        }
    }
}

pub enum Operand {
    Local(Box<dyn Typed>),
    Global(Box<dyn Typed>),
    Interger(i32),
}

impl Operand {
    pub fn make_global(dtype: Dtype, identifier: String) -> Self {
        Self::Global(Box::new(GlobalVar { dtype, identifier }))
    }
}

pub struct MemberProp {
    offset: i32,
    def: VarDef,
}

pub struct StructProp {
    member_props: IndexMap<String, MemberProp>,
}

pub struct FnProp {
    name: String,
    ret: Dtype,
    args: Vec<Rc<Operand>>,
    irs: Vec<stmt::Stmt>,
}

#[derive(Debug, Error)]
pub enum Error {
    #[error("initialization of structs not supported")]
    StructInitialization,
}

pub struct Program {}

pub struct Generator {
    definitions: IndexMap<String, GlobalDef>,
    global_variables: IndexMap<String, VarDef>,
    local_variables: IndexMap<String, VarDef>,
    return_dtypes: IndexMap<String, Dtype>,
    label_index: AtomicI32,
    vreg_index: AtomicI32,
    emit_irs: Vec<stmt::Stmt>,
    struct_props: IndexMap<String, StructProp>,
}

impl Generator {
    fn new() -> Self {
        Self {
            definitions: IndexMap::new(),
            global_variables: IndexMap::new(),
            local_variables: IndexMap::new(),
            return_dtypes: IndexMap::new(),
            label_index: AtomicI32::new(0),
            vreg_index: AtomicI32::new(100),
            emit_irs: Vec::new(),
            struct_props: IndexMap::new(),
        }
    }

    fn get_next_label_index(&self) -> i32 {
        return self.label_index.fetch_add(1, Ordering::SeqCst);
    }

    fn get_next_vreg_index(&self) -> i32 {
        return self.vreg_index.fetch_add(1, Ordering::SeqCst);
    }
}
