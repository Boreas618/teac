mod ast;
mod ir;

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

/// Dump mode: AST / IR / Assembly
#[derive(Copy, Clone, Debug, ValueEnum)]
enum DumpMode {
    AST,
    IR,
    S,
}

// Derive (auto-implement) the `Parser` trait from the `clap` crate so this struct can parse command-line arguments automatically.
#[derive(Parser, Debug)]
#[command(name = "teac")] // Provide metadata for the CLI: must be the same with the program’s name.
#[command(about = "A compiler written in Rust for teapl")] // Provide metadata for the CLI: a short description shown in `--help`.
struct Cli {
    /// Input file (source code file with a .tea extension)
    #[clap(value_name = "FILE")]
    input: String,

    /// Dump mode (-D AST|IR|S)
    #[arg(short = 'D', value_enum, ignore_case=true)]
    dump: Option<DumpMode>,

    #[clap(short, long, value_name = "FILE")]
    output: Option<String>,
}

/// Preprocess a source file: expand `#use name` with the contents of `name.h`.
/// Includes are resolved relative to the file that contains the directive.
/// Nested includes are supported. Cycles are detected and reported.
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
    let output_path = match cli.output {
        None => {
            Path::new(&input_path)
                .with_extension("ll") // replaces whatever extension it had
                .to_string_lossy() // convert PathBuf to String
                .into_owned()
        }
        Some(path) => path,
    };

    match cli.dump {
        Some(DumpMode::AST) => {
            println!("Will dump AST");
        }
        Some(DumpMode::IR) => {
            println!("Will dump LLVM IR");
        }
        Some(DumpMode::S) => {
            println!("Will dump Assembly");
        }
        None => {
            println!("No dump mode specified, proceed normally.");
        }
    }

    // Process input code file.
    let mut visited = HashSet::new();
    let prog = preprocess_file(Path::new(&input_path), &mut visited).unwrap_or_else(|e| {
        eprintln!("Encountered Error while preprocessing: {e}");
        std::process::exit(1);
    });

    // Generate abstract syntax tree for the code.
    let ast = teapl::ProgramParser::new()
        .parse(&prog)
        .unwrap_or_else(|e| {
            eprintln!("Encountered Error while parsing: {e}");
            std::process::exit(1);
        });

    // Generate LLVM IR based on the ast.
    let mut module_generator = ir::ModuleGenerator::new();
    let mut writer = BufWriter::new(File::create(output_path).unwrap());
    module_generator.gen(&ast).unwrap_or_else(|e| {
        eprintln!("Encountered Error while generating IR from AST: {e}");
        std::process::exit(1);
    });

    // Save the generated IR into a file.
    module_generator.output(&mut writer).unwrap_or_else(|e| {
        eprintln!("Encountered Error outputing: {e}");
        std::process::exit(1);
    });
}
