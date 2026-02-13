use super::function::Function;
use super::types::{Dtype, FunctionType, StructType};
use super::value::GlobalVariable;
use indexmap::IndexMap;
use std::io::Write;

pub struct Registry {
    pub struct_types: IndexMap<String, StructType>,
    pub function_types: IndexMap<String, FunctionType>,
}

/// Whole-module IR container.
pub struct Module {
    pub global_list: IndexMap<String, GlobalVariable>,
    pub function_list: IndexMap<String, Function>,
}

/// High-level AST-to-IR module builder and printer.
pub struct ModuleGenerator {
    pub module: Module,
    pub registry: Registry,
}

impl ModuleGenerator {
    const TARGET_TRIPLE: &'static str = "aarch64-unknown-linux-gnu";
    const TARGET_DATALAYOUT: &'static str = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128";

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
        writeln!(writer, "target triple = \"{}\"", Self::TARGET_TRIPLE)?;
        writeln!(
            writer,
            "target datalayout = \"{}\"",
            Self::TARGET_DATALAYOUT
        )?;
        writeln!(writer)?;

        // Structs
        for (type_name, struct_type) in self.registry.struct_types.iter() {
            let members: Vec<String> = struct_type
                .elements
                .iter()
                .map(|e| format!("{}", e.1.dtype))
                .collect();
            let members = members.join(", ");
            writeln!(writer, "%{} = type {{ {} }}", type_name, members)?;
        }
        writeln!(writer)?;

        // Globals
        for global in self.module.global_list.values() {
            let init_str = match (&global.initializers, &global.dtype) {
                (None, Dtype::I32) => "0".to_string(),
                (None, _) => "zeroinitializer".to_string(),
                (Some(inits), Dtype::Array { element, .. }) => {
                    // Array initializer: [i32 1, i32 2, i32 3]
                    let elems: Vec<String> = inits
                        .iter()
                        .map(|v| format!("{} {}", element, v))
                        .collect();
                    format!("[{}]", elems.join(", "))
                }
                (Some(inits), _) if inits.len() == 1 => {
                    format!("{}", inits[0])
                }
                (Some(inits), _) => {
                    // Fallback for other multi-value initializers
                    let elems: Vec<String> = inits
                        .iter()
                        .map(|v| format!("i32 {}", v))
                        .collect();
                    format!("[{}]", elems.join(", "))
                }
            };

            writeln!(
                writer,
                "@{} = dso_local global {} {}, align 4",
                global.identifier, global.dtype, init_str
            )?;
        }
        writeln!(writer)?;

        // Functions
        for func in self.module.function_list.values() {
            if let Some(blocks) = &func.blocks {
                let args = func
                    .arguments
                    .iter()
                    .map(|var| {
                        if matches!(&var.dtype, Dtype::Ptr { .. }) {
                            format!("ptr %r{}", var.index)
                        } else {
                            format!("{} %r{}", var.dtype, var.index)
                        }
                    })
                    .collect::<Vec<_>>()
                    .join(", ");

                writeln!(
                    writer,
                    "define dso_local {} @{}({}) {{",
                    self.registry
                        .function_types
                        .get(&func.identifier)
                        .unwrap()
                        .return_dtype,
                    func.identifier,
                    args
                )?;
                for block in blocks {
                    writeln!(writer, "{}:", block.label)?;
                    for stmt in &block.stmts {
                        writeln!(writer, "{}", stmt)?;
                    }
                }
                writeln!(writer, "}}")?;
                writeln!(writer)?;
            } else {
                let func_type = self.registry.function_types.get(&func.identifier).unwrap();

                let args = func_type
                    .arguments
                    .iter()
                    .map(|(_, dtype)| format!("{}", dtype))
                    .collect::<Vec<_>>()
                    .join(", ");

                writeln!(
                    writer,
                    "declare dso_local {} @{}({})",
                    func_type.return_dtype, func.identifier, args
                )?;
                writeln!(writer)?;
            }
        }

        Ok(())
    }
}

impl Default for ModuleGenerator {
    fn default() -> Self {
        Self::new()
    }
}
