mod asm;
mod ast;
mod ir;

use asm::AsmGenerator;

lalrpop_mod!(pub teapl);

use clap::{Parser, ValueEnum};
use lalrpop_util::lalrpop_mod;
use regex::Regex;
use std::{
    collections::HashSet,
    fs::File,
    io::{self, BufWriter, Read},
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
#[command(about = "A compiler written in Rust for teapl")]
struct Cli {
    /// Input file (source code file with a .tea extension)
    #[clap(value_name = "FILE")]
    input: String,

    /// Dump mode (-d ast|ir|s)
    #[arg(short = 'd', value_enum, ignore_case = true)]
    dump: Option<DumpMode>,

    #[clap(short, long, value_name = "FILE")]
    output: Option<String>,
}

fn preprocess_file(path: &Path, visited: &mut HashSet<PathBuf>) -> io::Result<String> {
    // Use canonical path for cycle detection
    let key = std::fs::canonicalize(path).unwrap_or_else(|_| path.to_path_buf());
    if !visited.insert(key.clone()) {
        return Err(io::Error::new(
            io::ErrorKind::InvalidData,
            format!("include cycle detected at: {}", key.to_string_lossy()),
        ));
    }

    let mut src = String::new();
    File::open(path)?.read_to_string(&mut src)?;

    // Matches full line: `#use name` (with optional whitespace, optional semicolon)
    // Examples:
    //   #use math
    //   #use   std   ;
    let re = Regex::new(r#"(?m)^\s*#use\s+([A-Za-z0-9_]+)\s*;?\s*$"#).unwrap();

    let mut out = String::with_capacity(src.len());
    let mut last = 0usize;

    for caps in re.captures_iter(&src) {
        let m = caps.get(0).unwrap();
        let module = caps.get(1).unwrap().as_str();

        // Push text before the directive
        out.push_str(&src[last..m.start()]);

        // Resolve `module.h` in the same directory
        let base_dir = path.parent().unwrap_or(Path::new("."));
        let header_path = base_dir.join(format!("{module}.teah"));

        // Recursively preprocess the header
        let header_expanded = preprocess_file(&header_path, visited).map_err(|e| {
            io::Error::new(
                e.kind(),
                format!(
                    "while expanding #use {} in {}: {}",
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

fn main() {
    // Parse the command.
    let cli = Cli::parse();
    let input_path = cli.input;
    let default_ext = match cli.dump {
        Some(DumpMode::S) => "s",
        _ => "ll",
    };
    let output_path = match cli.output {
        None => Path::new(&input_path)
            .with_extension(default_ext)
            .to_string_lossy()
            .into_owned(),
        Some(path) => path,
    };

    // Process input code file.
    let mut visited = HashSet::new();
    let prog = preprocess_file(Path::new(&input_path), &mut visited).unwrap_or_else(|e| {
        eprintln!("Encountered error while preprocessing: {e}");
        std::process::exit(1);
    });

    // Generate abstract syntax tree for the code.
    let ast = teapl::ProgramParser::new()
        .parse(&prog)
        .unwrap_or_else(|e| {
            eprintln!("Encountered error while parsing: {e}");
            std::process::exit(1);
        });

    if cli.dump == Some(DumpMode::AST) {
        print!("{}", ast);
        return;
    }

    // Generate IR based on the AST.
    let mut module_generator = ir::ModuleGenerator::new();
    module_generator.gen(&ast).unwrap_or_else(|e| {
        eprintln!("Encountered error while generating IR from AST: {e}");
        std::process::exit(1);
    });

    let out_path = Path::new(&output_path);
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

    match cli.dump {
        None | Some(DumpMode::IR) => {
            // Save the generated LLVM IR into a file.
            module_generator.output(&mut writer).unwrap_or_else(|e| {
                eprintln!("Encountered error outputing: {e}");
                std::process::exit(1);
            });
        }
        Some(DumpMode::S) => {
            // Lower IR to AArch64 assembly.
            let asm_gen =
                asm::AArch64AsmGenerator::new(&module_generator.module, &module_generator.registry);
            asm_gen.output(&mut writer).unwrap_or_else(|e| {
                eprintln!("Encountered error while generating assembly: {e}");
                std::process::exit(1);
            });
        }
        Some(DumpMode::AST) => unreachable!("handled above"),
    }
}
