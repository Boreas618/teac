mod gen;
mod stmt;

use crate::ast::{self};
use crate::ir;
use crate::ir::gen::Named;
use indexmap::IndexMap;
use std::any::Any;
use std::fmt::{Display, Formatter};
use std::io::Write;
use std::rc::Rc;
use thiserror::Error;

#[derive(Clone, PartialEq, PartialOrd)]
pub enum Dtype {
    Void,
    I32,
    Struct { type_name: String },
    Pointer { inner: Box<Dtype>, length: usize },
    Undecided,
}

#[derive(Clone)]
pub enum BiOpKind {
    Add,
    Sub,
    Mul,
    Div,
}

#[derive(Clone)]
pub enum RelOpKind {
    Eq,
    Ne,
    Lt,
    Gt,
    Le,
    Ge,
}

#[derive(Clone)]
struct FunctionType {
    return_dtype: Dtype,
    arguments: Vec<VarDef>,
}

impl PartialEq<ast::FnDecl> for FunctionType {
    fn eq(&self, rhs: &ast::FnDecl) -> bool {
        let rhs_dtype = match rhs
            .return_dtype
            .as_ref()
            .as_ref()
            .and_then(|ty| Some(Dtype::from(ty)))
        {
            Some(dtype) => dtype,
            None => Dtype::Void,
        };

        if self.return_dtype != rhs_dtype {
            return false;
        }

        let mut rhs_args = Vec::new();
        if let Some(params) = &rhs.param_decl {
            for decl in params.decls.iter() {
                let identifier = decl.identifier.clone();
                let dtype = match Dtype::try_from(decl) {
                    Ok(t) => t,
                    Err(_) => return false,
                };

                rhs_args.push((identifier, dtype));
            }
        }

        let num_args = self.arguments.len();
        if rhs_args.len() != num_args {
            return false;
        }

        for (lhs_arg, (rhs_id, rhs_dtype)) in self.arguments.iter().zip(rhs_args) {
            let lhs = lhs_arg.inner.as_ref();
            if lhs.identifier().unwrap_or(String::new()) != rhs_id || lhs.dtype() != &rhs_dtype {
                return false;
            }
        }

        true
    }
}

struct Function {
    dtype: FunctionType,
    identifier: String,
    blocks: Option<Vec<Vec<stmt::Stmt>>>,
}

#[derive(Clone)]
pub struct VarDef {
    inner: Rc<dyn Operand>,
    initializers: Option<Vec<i32>>,
}

#[derive(Clone)]
pub enum BlockLabel {
    BasicBlock(usize),
    Function(String),
}

impl Display for BlockLabel {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        match self {
            BlockLabel::BasicBlock(index) => write!(f, "bb{}", index),
            BlockLabel::Function(identifier) => write!(f, "{}", identifier),
        }
    }
}

pub trait Typed {
    fn dtype(&self) -> &Dtype;
}

#[derive(Clone)]
pub struct GlobalVariable {
    dtype: Dtype,
    identifier: String,
    initializers: Option<Vec<i32>>,
}

impl Typed for GlobalVariable {
    fn dtype(&self) -> &Dtype {
        &self.dtype
    }
}

impl Named for GlobalVariable {
    fn identifier(&self) -> Option<String> {
        Some(self.identifier.clone())
    }
}

impl Display for GlobalVariable {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        write!(f, "@{}", self.identifier)
    }
}

impl Operand for GlobalVariable {
    fn as_any(&self) -> &dyn Any {
        self
    }
}

#[derive(Clone)]
pub struct LocalVariable {
    dtype: Dtype,
    identifier: Option<String>,
    index: usize,
}

impl Typed for LocalVariable {
    fn dtype(&self) -> &Dtype {
        &self.dtype
    }
}

impl Named for LocalVariable {
    fn identifier(&self) -> Option<String> {
        self.identifier.clone()
    }
}

impl Display for LocalVariable {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        write!(f, "%r{}", self.index)
    }
}

impl Operand for LocalVariable {
    fn as_any(&self) -> &dyn Any {
        self
    }
}

impl LocalVariable {
    pub fn create_int(index: usize) -> Self {
        LocalVariable {
            dtype: Dtype::I32,
            index,
            identifier: None,
        }
    }

    pub fn create_int_ptr(index: usize, length: usize) -> Self {
        LocalVariable {
            dtype: Dtype::Pointer {
                inner: Box::new(Dtype::I32),
                length,
            },
            index,
            identifier: None,
        }
    }

    pub fn create_struct(name: String, index: usize) -> Self {
        LocalVariable {
            dtype: Dtype::Struct { type_name: name },
            index,
            identifier: None,
        }
    }

    pub fn create_struct_ptr(name: String, index: usize, length: usize) -> Self {
        LocalVariable {
            dtype: Dtype::Pointer {
                inner: Box::new(Dtype::Struct { type_name: name }),
                length,
            },
            index,
            identifier: None,
        }
    }

    pub fn create_undecided() -> Self {
        LocalVariable {
            dtype: Dtype::Undecided,
            index: 0,
            identifier: None,
        }
    }
}

pub struct Integer {
    dtype: Dtype,
    value: i32,
}

impl From<i32> for Integer {
    fn from(value: i32) -> Self {
        Self {
            dtype: Dtype::I32,
            value,
        }
    }
}

impl Typed for Integer {
    fn dtype(&self) -> &Dtype {
        &Dtype::I32
    }
}

impl Named for Integer {
    fn identifier(&self) -> Option<String> {
        None
    }
}

impl Display for Integer {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        write!(f, "{}", self.value)
    }
}

impl Operand for Integer {
    fn as_any(&self) -> &dyn Any {
        self
    }
}

pub trait Operand: Named + Typed + Display {
    fn as_any(&self) -> &dyn Any;
}

pub struct StructMember {
    offset: i32,
    identifier: String,
    dtype: Dtype,
}

pub struct StructType {
    identifier: String,
    elements: Vec<(String, StructMember)>,
}

#[derive(Debug, Error)]
pub enum Error {
    #[error("Initialization of structs not supported")]
    StructInitialization,

    #[error("Redefined symbol {symbol}")]
    RedefinedSymbol { symbol: String },

    #[error("Symbol missing")]
    SymbolMissing,

    #[error("Mismatched declaration and definition of {symbol}")]
    DeclDefMismatch { symbol: String },

    #[error("Function {symbol} not defined")]
    FunctionNotDefined { symbol: String },

    #[error("Variable {symbol} not defined")]
    VariableNotDefined { symbol: String },

    #[error("Invalid array expression")]
    InvalidArrayExpression,

    #[error("Invalid struct member expression")]
    InvalidStructMemberExpression,

    #[error("Invalid operand")]
    InvalidOperand,

    #[error("Invalid expression unit: {expr_unit}")]
    InvalidExprUnit { expr_unit: ast::ExprUnit },

    #[error("Unsupported type of local variable")]
    LocalVarTypeUnsupported,

    #[error("Definition of array is not supported")]
    DefineLocalVarArrayUnsupported,

    #[error("Unsupported function call")]
    FunctionCallUnsupported,

    #[error("Invalid continue instruction")]
    InvalidContinueInst,

    #[error("Invalid break instruction")]
    InvalidBreakInst,

    #[error("Unsupported return type")]
    ReturnTypeUnsupported,

    #[error("Invalid Bool Expression")]
    InvalidBoolExpr,
}

/// Equivalent to llvm::LLVMContext
pub struct Registry {
    struct_types: IndexMap<String, StructType>,
    function_types: IndexMap<String, FunctionType>,
}

/// Equivalent to llvm::Module
pub struct Module {
    pub global_list: IndexMap<String, GlobalVariable>,
    pub function_list: IndexMap<String, Function>,
}

pub struct ModuleGenerator {
    pub module: Module,
    pub registry: Registry,
}

impl ModuleGenerator {
    pub fn new() -> Self {
        let module = Module {
            global_list: IndexMap::new(),
            function_list: IndexMap::new(),
        };
        let registry = Registry {
            struct_types: IndexMap::new(),
            function_types: IndexMap::new(),
        };
        Self { module, registry }
    }

    pub fn output<W: Write>(&self, writer: &mut W) -> std::io::Result<()> {
        // Globals
        for global in self.module.global_list.values() {
            let init_str = match (&global.initializers, &global.dtype) {
                (None, ir::Dtype::I32) => "0".to_string(),
                (None, _) => "zeroinitializer".to_string(),
                (Some(inits), _) => {
                    assert!(
                        inits.len() == 1,
                        "global '{}' expected exactly 1 initializer, got {}",
                        global.identifier,
                        inits.len()
                    );
                    format!("{}", inits[0])
                }
            };

            writeln!(
                writer,
                "@{} = global {} {}",
                global.identifier, global.dtype, init_str
            )?;
            writeln!(writer)?; // blank line
        }

        // Functions
        for func in self.module.function_list.values() {
            // Build argument list once, without trailing comma handling.
            let args = func
                .dtype
                .arguments
                .iter()
                .map(|arg| {
                    let var = arg
                        .inner
                        .as_ref()
                        .as_any()
                        .downcast_ref::<ir::LocalVariable>()
                        .expect("function arguments must be ir::LocalVariable");
                    format!("{} %r{}", var.dtype, var.index)
                })
                .collect::<Vec<_>>()
                .join(", ");

            if let Some(blocks) = &func.blocks {
                writeln!(
                    writer,
                    "define {} @{}({}) {{",
                    func.dtype.return_dtype, func.identifier, args
                )?;
                for block in blocks {
                    for stmt in block {
                        writeln!(writer, "{}", stmt)?;
                    }
                }
                writeln!(writer, "}}")?;
                writeln!(writer)?; // blank line
            } else {
                writeln!(
                    writer,
                    "declare {} @{}({});",
                    func.dtype.return_dtype, func.identifier, args
                )?;
                writeln!(writer)?; // blank line
            }
        }

        Ok(())
    }
}

pub struct FunctionGenerator<'ir> {
    pub module_generator: &'ir mut ModuleGenerator,
    pub local_variables: IndexMap<String, LocalVariable>,
    pub irs: Vec<stmt::Stmt>,
    virt_reg_index: usize,
    basic_block_index: usize,
}

impl FunctionGenerator<'_> {
    pub fn increment_virt_reg_index(&mut self) -> usize {
        self.virt_reg_index += 1;
        self.virt_reg_index - 1
    }

    pub fn increment_basic_block_index(&mut self) -> usize {
        self.basic_block_index += 1;
        self.basic_block_index - 1
    }
}
