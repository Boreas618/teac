mod asm;
mod ast;
mod ir;
mod parser;

use asm::AsmGenerator;
use clap::{Parser, ValueEnum};
use std::{
    fs::{self, File},
    io::{self, BufWriter, Write},
    path::Path,
};

#[derive(Copy, Clone, Debug, PartialEq, ValueEnum)]
enum EmitTarget {
    Ast,
    Ir,
    Asm,
}

#[derive(Parser, Debug)]
#[command(name = "teac")]
#[command(about = "A compiler written in Rust for TeaLang")]
struct Cli {
    #[clap(value_name = "FILE")]
    input: String,

    #[arg(long, value_enum, ignore_case = true, default_value = "asm")]
    emit: EmitTarget,

    #[clap(short, long, value_name = "FILE")]
    output: Option<String>,
}

fn write_output<W: Write>(
    emit_target: EmitTarget,
    module_generator: &ir::ModuleGenerator,
    writer: &mut W,
) {
    match emit_target {
        EmitTarget::Ir => {
            module_generator.output(writer).unwrap_or_else(|e| {
                eprintln!("Encountered error outputting: {e}");
                std::process::exit(1);
            });
        }
        EmitTarget::Asm => {
            let mut asm_gen =
                asm::AArch64AsmGenerator::new(&module_generator.module, &module_generator.registry);
            asm_gen.generate().unwrap_or_else(|e| {
                eprintln!("Encountered error while generating assembly: {e}");
                std::process::exit(1);
            });
            asm_gen.output(writer).unwrap_or_else(|e| {
                eprintln!("Encountered error while generating assembly: {e}");
                std::process::exit(1);
            });
        }
        EmitTarget::Ast => {}
    }
}

fn main() {
    let cli = Cli::parse();
    let input_path = cli.input;

    let prog = fs::read_to_string(input_path).unwrap_or_else(|e| {
        eprintln!("Encountered error while reading input file: {e}");
        std::process::exit(1);
    });

    let ast = parser::parse(&prog).unwrap_or_else(|e| {
        eprintln!("Encountered error while parsing: {e}");
        std::process::exit(1);
    });

    if cli.emit == EmitTarget::Ast {
        print!("{}", ast);
        return;
    }

    let mut module_generator = ir::ModuleGenerator::new();
    module_generator.generate(&ast).unwrap_or_else(|e| {
        eprintln!("Encountered error while generating IR from AST: {e}");
        std::process::exit(1);
    });

    match &cli.output {
        Some(output_path) => {
            let out_path = Path::new(output_path);
            if let Some(parent) = out_path.parent() {
                if !parent.as_os_str().is_empty() {
                    std::fs::create_dir_all(parent).unwrap_or_else(|e| {
                        eprintln!(
                            "Failed to create output directory {}: {e}",
                            parent.to_string_lossy()
                        );
                        std::process::exit(1);
                    });
                }
            }
            let mut writer = BufWriter::new(File::create(out_path).unwrap_or_else(|e| {
                eprintln!(
                    "Failed to create output file {}: {e}",
                    out_path.to_string_lossy()
                );
                std::process::exit(1);
            }));
            write_output(cli.emit, &module_generator, &mut writer);
        }
        None => {
            let mut writer = BufWriter::new(io::stdout());
            write_output(cli.emit, &module_generator, &mut writer);
        }
    }
}
