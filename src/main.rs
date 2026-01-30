mod asm;
mod ast;
mod ir;
mod parser;

use asm::AsmGenerator;
use clap::{Parser, ValueEnum};
use regex::Regex;
use std::{
    collections::HashSet,
    fs::File,
    io::{self, BufWriter, Read, Write},
    path::{Path, PathBuf},
};

#[derive(Copy, Clone, Debug, PartialEq, ValueEnum)]
enum DumpMode {
    AST,
    IR,
    S,
}

#[derive(Parser, Debug)]
#[command(name = "teac")]
#[command(about = "A compiler written in Rust for TeaLang")]
struct Cli {
    #[clap(value_name = "FILE")]
    input: String,

    #[arg(short = 'd', value_enum, ignore_case = true, default_value = "s")]
    dump: DumpMode,

    #[clap(short, long, value_name = "FILE")]
    output: Option<String>,
}

fn preprocess_file(path: &Path, visited: &mut HashSet<PathBuf>) -> io::Result<String> {
    let key = std::fs::canonicalize(path).unwrap_or_else(|_| path.to_path_buf());
    if !visited.insert(key.clone()) {
        return Err(io::Error::new(
            io::ErrorKind::InvalidData,
            format!("include cycle detected at: {}", key.to_string_lossy()),
        ));
    }

    let mut src = String::new();
    File::open(path)?.read_to_string(&mut src)?;

    let re = Regex::new(r#"(?m)^\s*use\s+([A-Za-z0-9_]+)\s*;?\s*$"#).unwrap();

    let mut out = String::with_capacity(src.len());
    let mut last = 0usize;

    for caps in re.captures_iter(&src) {
        let m = caps.get(0).unwrap();
        let module = caps.get(1).unwrap().as_str();

        out.push_str(&src[last..m.start()]);

        if module == "std" {
            out.push_str(m.as_str());
            last = m.end();
            continue;
        }

        let base_dir = path.parent().unwrap_or(Path::new("."));
        let header_path = base_dir.join(format!("{module}.teah"));

        let header_expanded = preprocess_file(&header_path, visited).map_err(|e| {
            io::Error::new(
                e.kind(),
                format!(
                    "while expanding use {} in {}: {}",
                    module,
                    path.to_string_lossy(),
                    e
                ),
            )
        })?;

        out.push_str(&header_expanded);
        last = m.end();
    }

    out.push_str(&src[last..]);
    visited.remove(&key);

    Ok(out)
}

fn write_output<W: Write>(
    dump_mode: DumpMode,
    module_generator: &ir::ModuleGenerator,
    writer: &mut W,
) {
    match dump_mode {
        DumpMode::IR => {
            module_generator.output(writer).unwrap_or_else(|e| {
                eprintln!("Encountered error outputting: {e}");
                std::process::exit(1);
            });
        }
        DumpMode::S => {
            let mut asm_gen = asm::AArch64AsmGenerator::new(
                &module_generator.module,
                &module_generator.registry,
            );
            asm_gen.generate().unwrap_or_else(|e| {
                eprintln!("Encountered error while generating assembly: {e}");
                std::process::exit(1);
            });
            asm_gen.output(writer).unwrap_or_else(|e| {
                eprintln!("Encountered error while generating assembly: {e}");
                std::process::exit(1);
            });
        }
        DumpMode::AST => unreachable!(),
    }
}

fn main() {
    let cli = Cli::parse();
    let input_path = cli.input;

    let mut visited = HashSet::new();
    let prog = preprocess_file(Path::new(&input_path), &mut visited).unwrap_or_else(|e| {
        eprintln!("Error: Failed to preprocess input file '{input_path}': {e}");
        eprintln!("\nUsage: teac [OPTIONS] <FILE>");
        eprintln!("Try 'teac --help' for more information.");
        std::process::exit(1);
    });

    let ast = parser::parse(&prog).unwrap_or_else(|e| {
        eprintln!("Encountered error while parsing: {e}");
        std::process::exit(1);
    });

    if cli.dump == DumpMode::AST {
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
            write_output(cli.dump, &module_generator, &mut writer);
        }
        None => {
            let mut writer = BufWriter::new(io::stdout());
            write_output(cli.dump, &module_generator, &mut writer);
        }
    }
}
