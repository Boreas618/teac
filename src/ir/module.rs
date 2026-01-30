use super::function::Function;
use super::types::{Dtype, FunctionType, StructType};
use super::value::GlobalVariable;
use indexmap::IndexMap;
use std::io::Write;

pub struct Registry {
    pub struct_types: IndexMap<String, StructType>,
    pub function_types: IndexMap<String, FunctionType>,
}

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
        // Structs
        for (type_name, struct_type) in self.registry.struct_types.iter() {
            let members: Vec<String> = struct_type
                .elements
                .iter()
                .map(|e| format!("{}", e.1.dtype))
                .collect();
            let members = members.join(", ");
            writeln!(writer, "%{} = type {{{}}}", type_name, members)?;
        }
        writeln!(writer)?;

        // Globals
        for global in self.module.global_list.values() {
            let init_str = match (&global.initializers, &global.dtype) {
                (None, Dtype::I32) => "0".to_string(),
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
        }
        writeln!(writer)?;

        // Functions
        for func in self.module.function_list.values() {
            if let Some(blocks) = &func.blocks {
                let args = func
                    .arguments
                    .iter()
                    .map(|var| {
                        if matches!(&var.dtype, Dtype::Pointer { .. }) {
                            format!("ptr %r{}", var.index)
                        } else {
                            format!("{} %r{}", var.dtype, var.index)
                        }
                    })
                    .collect::<Vec<_>>()
                    .join(", ");

                writeln!(
                    writer,
                    "define {} @{}({}) {{",
                    self.registry
                        .function_types
                        .get(&func.identifier)
                        .unwrap()
                        .return_dtype,
                    func.identifier,
                    args
                )?;
                for block in blocks {
                    for stmt in block {
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
                    "declare {} @{}({});",
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
