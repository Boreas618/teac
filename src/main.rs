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

fn open_writer(output: &Option<String>) -> Result<Box<dyn Write>, String> {
    match output {
        Some(path) => {
            let out_path = Path::new(path);
            if let Some(parent) = out_path.parent() {
                if !parent.as_os_str().is_empty() {
                    fs::create_dir_all(parent).map_err(|e| {
                        format!(
                            "failed to create output directory '{}': {e}",
                            parent.display()
                        )
                    })?;
                }
            }
            let file = File::create(out_path).map_err(|e| {
                format!("failed to create output file '{}': {e}", out_path.display())
            })?;
            Ok(Box::new(BufWriter::new(file)))
        }
        None => Ok(Box::new(BufWriter::new(io::stdout()))),
    }
}

fn run() -> Result<(), String> {
    let cli = Cli::parse();
    let source = fs::read_to_string(&cli.input)
        .map_err(|e| format!("failed to read input file '{}': {e}", cli.input))?;
    let ast = parser::parse(&source)?;
    let mut writer = open_writer(&cli.output)?;

    match cli.emit {
        EmitTarget::Ast => {
            write!(writer, "{ast}").map_err(|e| format!("failed to write AST output: {e}"))?;
        }
        EmitTarget::Ir | EmitTarget::Asm => {
            let mut module_gen = ir::ModuleGenerator::new();
            module_gen
                .generate(&ast)
                .map_err(|e| format!("IR generation failed: {e}"))?;

            if cli.emit == EmitTarget::Ir {
                module_gen
                    .output(&mut writer)
                    .map_err(|e| format!("failed to write IR output: {e}"))?;
            } else {
                let mut asm_gen =
                    asm::AArch64AsmGenerator::new(&module_gen.module, &module_gen.registry);
                asm_gen
                    .generate()
                    .map_err(|e| format!("assembly generation failed: {e}"))?;
                asm_gen
                    .output(&mut writer)
                    .map_err(|e| format!("failed to write assembly output: {e}"))?;
            }
        }
    }

    Ok(())
}

fn main() {
    if let Err(e) = run() {
        eprintln!("Error: {e}");
        std::process::exit(1);
    }
}
