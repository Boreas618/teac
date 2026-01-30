use crate::ast;
use crate::ir::function::{Function, FunctionGenerator};
use crate::ir::module::ModuleGenerator;
use crate::ir::opt;
use crate::ir::stmt::{Stmt, StmtInner};
use crate::ir::types::{Dtype, FunctionType, StructMember, StructType};
use crate::ir::value::GlobalVariable;
use crate::ir::Error;

use crate::ir::value::Named;

impl ModuleGenerator {
    pub fn generate(&mut self, from: &ast::Program) -> Result<(), Error> {
        for use_stmt in from.use_stmts.iter() {
            self.handle_use_stmt(use_stmt)?;
        }

        for elem in from.elements.iter() {
            use ast::ProgramElementInner::*;
            match &elem.inner {
                VarDeclStmt(stmt) => self.handle_global_var_decl(stmt)?,
                FnDeclStmt(fn_decl) => self.handle_fn_decl(fn_decl)?,
                FnDef(fn_def) => self.handle_fn_def(fn_def)?,
                StructDef(struct_def) => self.handle_struct_def(struct_def)?,
            }
        }

        for elem in from.elements.iter() {
            use ast::ProgramElementInner::*;
            if let FnDef(fn_def) = &elem.inner {
                let mut function_generator = FunctionGenerator::new(self);
                function_generator.gen(fn_def)?;

                let blocks = Self::harvest_function_irs(function_generator.irs);
                let local_variables = function_generator.local_variables;
                let arguments = function_generator.arguments;

                let func = self
                    .module
                    .function_list
                    .get_mut(&fn_def.fn_decl.identifier);

                if let Some(f) = func {
                    f.blocks = Some(blocks);
                    f.local_variables = Some(local_variables);
                    f.arguments = arguments;
                    opt::mem2reg(f);
                } else {
                    return Err(Error::FunctionNotDefined {
                        symbol: fn_def.fn_decl.identifier.clone(),
                    });
                }
            }
        }

        Ok(())
    }

    fn handle_use_stmt(&mut self, use_stmt: &ast::UseStmt) -> Result<(), Error> {
        if use_stmt.module_name == "std" {
            self.register_std_functions()?;
        }
        Ok(())
    }

    fn register_std_functions(&mut self) -> Result<(), Error> {
        let std_functions = vec![
            ("std::getint", vec![], Dtype::I32),
            ("std::getch", vec![], Dtype::I32),
            ("std::putint", vec![("a".to_string(), Dtype::I32)], Dtype::Void),
            ("std::putch", vec![("a".to_string(), Dtype::I32)], Dtype::Void),
            ("std::timer_start", vec![("lineno".to_string(), Dtype::I32)], Dtype::Void),
            ("std::timer_stop", vec![("lineno".to_string(), Dtype::I32)], Dtype::Void),
            ("std::putarray", vec![
                ("n".to_string(), Dtype::I32), 
                ("a".to_string(), Dtype::Pointer { inner: Box::new(Dtype::I32), length: 0 })
            ], Dtype::Void),
        ];
        
        for (name, arguments, return_dtype) in std_functions {
            self.registry.function_types.insert(
                name.to_string(),
                FunctionType { return_dtype, arguments }
            );
        }
        
        Ok(())
    }

    fn harvest_function_irs(irs: Vec<Stmt>) -> Vec<Vec<Stmt>> {
        let mut blocks = Vec::new();
        let mut insts = Vec::new();

        let mut flag = false;
        for stmt in irs {
            if let StmtInner::Label(_) = &stmt.inner {
                if !insts.is_empty() {
                    blocks.push(insts);
                    insts = Vec::new();
                }
                flag = false;
            }
            if flag {
                continue;
            }
            if matches!(&stmt.inner, StmtInner::Return(_))
                || matches!(&stmt.inner, StmtInner::CJump(_))
                || matches!(&stmt.inner, StmtInner::Jump(_))
            {
                flag = true;
            }
            insts.push(stmt);
        }
        if !insts.is_empty() {
            blocks.push(insts);
        }

        for block_index in 1..blocks.len() {
            let block = blocks.get(block_index).unwrap();
            let (allocas, remaining): (Vec<Stmt>, Vec<Stmt>) = block
                .iter()
                .cloned()
                .partition(|x| matches!(x.inner, StmtInner::Alloca(_)));
            blocks[0].splice(1..1, allocas);
            blocks[block_index] = remaining;
        }

        blocks
    }

    fn handle_global_var_decl(&mut self, stmt: &ast::VarDeclStmt) -> Result<(), Error> {
        let identifier = match stmt.identifier() {
            Some(id) => id,
            None => return Err(Error::SymbolMissing),
        };

        let dtype = Dtype::try_from(stmt)?;
        let initializers = if let ast::VarDeclStmtInner::Def(d) = &stmt.inner {
            Some(match &d.inner {
                ast::VarDefInner::Array(def) => def
                    .vals
                    .iter()
                    .map(|val| Self::handle_right_val_static(val).unwrap())
                    .collect(),
                ast::VarDefInner::Scalar(scalar) => {
                    let value = Self::handle_right_val_static(&scalar.val)?;
                    vec![value]
                }
            })
        } else {
            None
        };

        self.module
            .global_list
            .insert(
                identifier.clone(),
                GlobalVariable {
                    dtype,
                    identifier,
                    initializers,
                },
            )
            .map_or(Ok(()), |v| {
                Err(Error::VariableRedefinition {
                    symbol: v.identifier,
                })
            })
    }

    fn handle_fn_decl(&mut self, decl: &ast::FnDecl) -> Result<(), Error> {
        let identifier = decl.identifier.clone();

        let mut arguments = Vec::new();
        if let Some(params) = &decl.param_decl {
            for decl in params.decls.iter() {
                let id = decl.identifier().unwrap();
                let dtype = Dtype::try_from(decl)?;
                arguments.push((id, dtype));
            }
        }

        let function_type = FunctionType {
            return_dtype: match decl.return_dtype.as_ref() {
                Some(type_specifier) => type_specifier.into(),
                None => Dtype::Void,
            },
            arguments,
        };

        if let Some(ftype) = self
            .registry
            .function_types
            .insert(identifier.clone(), function_type.clone())
        {
            if ftype != function_type {
                return Err(Error::ConflictedFunction { symbol: identifier });
            }
        }

        self.module.function_list.insert(
            identifier.clone(),
            Function {
                arguments: Vec::new(),
                local_variables: None,
                identifier: identifier.clone(),
                blocks: None,
            },
        );

        Ok(())
    }

    fn handle_fn_def(&mut self, stmt: &ast::FnDef) -> Result<(), Error> {
        let identifier = stmt.fn_decl.identifier.clone();

        match self.registry.function_types.get(&identifier) {
            None => self.handle_fn_decl(&stmt.fn_decl)?,
            Some(ty) => {
                if ty != stmt.fn_decl.as_ref() {
                    return Err(Error::DeclDefMismatch {
                        symbol: identifier.clone(),
                    });
                }
            }
        }

        Ok(())
    }

    fn handle_struct_def(&mut self, struct_def: &ast::StructDef) -> Result<(), Error> {
        let identifier = struct_def.identifier.clone();
        let mut offset = 0;
        let mut elements = Vec::new();

        for decl in struct_def.decls.iter() {
            let base_dtype = match decl.type_specifier.as_ref() {
                Some(type_specifier) => type_specifier.into(),
                None => Dtype::Void,
            };

            if let Dtype::Struct { type_name } = &base_dtype {
                if !self.registry.struct_types.contains_key(type_name) {
                    return Err(Error::UndefinedStructMemberType {
                        struct_name: identifier.clone(),
                        member_type: type_name.clone(),
                    });
                }
            }

            elements.push((
                decl.identifier.clone(),
                StructMember {
                    offset,
                    dtype: match &decl.inner {
                        ast::VarDeclInner::Scalar(_) => base_dtype,
                        ast::VarDeclInner::Array(array) => Dtype::Pointer {
                            inner: Box::new(base_dtype),
                            length: array.len,
                        },
                    },
                },
            ));

            offset += 1;
        }

        self.registry
            .struct_types
            .insert(identifier, StructType { elements });

        Ok(())
    }
}
