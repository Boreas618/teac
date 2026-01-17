// Module declarations for the TeaLang compiler components
mod asm;    // Assembly code generation backend (AArch64)
mod ast;    // Abstract Syntax Tree definitions
mod ir;     // Intermediate Representation (LLVM-style IR)
mod parser; // Parser implementation using Pest

// External dependencies
use asm::AsmGenerator;           // Trait for assembly generation
use clap::{Parser, ValueEnum};   // Command-line argument parsing
use regex::Regex;                // Regular expressions for preprocessing
use std::{
    collections::HashSet,        // For tracking visited files during preprocessing
    fs::File,                    // File I/O operations
    io::{self, BufWriter, Read, Write}, // I/O traits and buffered writing
    path::{Path, PathBuf},       // File path handling
};

/// Output format for the compiler.
/// Determines what representation to generate from the source code.
#[derive(Copy, Clone, Debug, PartialEq, ValueEnum)]
enum DumpMode {
    /// Dump the Abstract Syntax Tree (AST) representation
    AST,
    /// Dump the Intermediate Representation (LLVM-style IR)
    IR,
    /// Dump assembly code (AArch64)
    S,
}

/// Command-line interface structure for the TeaLang compiler.
/// 
/// This compiler translates TeaLang source code through multiple stages:
/// 1. Preprocessing (handle #use directives)
/// 2. Parsing (source → AST)
/// 3. IR generation (AST → LLVM-style IR)
/// 4. Code generation (IR → AArch64 assembly)
#[derive(Parser, Debug)]
#[command(name = "teac")]
#[command(about = "A compiler written in Rust for TeaLang")]
struct Cli {
    /// Input file (source code file with a .tea extension)
    #[clap(value_name = "FILE")]
    input: String,

    /// Dump mode (-d ast|ir|s), defaults to 's' (assembly)
    #[arg(short = 'd', value_enum, ignore_case = true, default_value = "s")]
    dump: DumpMode,

    /// Output file (defaults to stdout if not specified)
    #[clap(short, long, value_name = "FILE")]
    output: Option<String>,
}

/// Preprocesses a TeaLang source file by recursively expanding `#use` directives.
/// 
/// This function implements a simple preprocessor that handles module inclusion:
/// - Detects `#use module_name` directives in the source code
/// - Recursively loads and expands the corresponding `.teah` header files
/// - Prevents infinite loops by detecting include cycles
/// 
/// # Arguments
/// * `path` - Path to the source file to preprocess
/// * `visited` - Set of already-visited files for cycle detection
/// 
/// # Returns
/// The fully expanded source code with all `#use` directives replaced by their content
/// 
/// # Errors
/// Returns an error if:
/// - A file cannot be read
/// - An include cycle is detected
/// - A referenced header file does not exist
fn preprocess_file(path: &Path, visited: &mut HashSet<PathBuf>) -> io::Result<String> {
    // Use canonical path for cycle detection to handle symlinks and relative paths
    let key = std::fs::canonicalize(path).unwrap_or_else(|_| path.to_path_buf());
    if !visited.insert(key.clone()) {
        return Err(io::Error::new(
            io::ErrorKind::InvalidData,
            format!("include cycle detected at: {}", key.to_string_lossy()),
        ));
    }

    // Read the source file content
    let mut src = String::new();
    File::open(path)?.read_to_string(&mut src)?;

    // Regular expression to match `#use` directives
    // Matches full line: `#use name` (with optional whitespace, optional semicolon)
    // Examples:
    //   #use math
    //   #use   std   ;
    let re = Regex::new(r#"(?m)^\s*#use\s+([A-Za-z0-9_]+)\s*;?\s*$"#).unwrap();

    let mut out = String::with_capacity(src.len());
    let mut last = 0usize;

    // Process each `#use` directive found in the file
    for caps in re.captures_iter(&src) {
        let m = caps.get(0).unwrap();
        let module = caps.get(1).unwrap().as_str();

        // Append text before this directive to output
        out.push_str(&src[last..m.start()]);

        // Resolve header file path: `module_name` → `module_name.teah` in same directory
        let base_dir = path.parent().unwrap_or(Path::new("."));
        let header_path = base_dir.join(format!("{module}.teah"));

        // Recursively preprocess the header file
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

        // Replace the `#use` directive with the expanded header content
        out.push_str(&header_expanded);
        last = m.end();
    }

    // Append remaining text after the last directive
    out.push_str(&src[last..]);
    
    // Remove this file from visited set to allow it to be included from other paths
    visited.remove(&key);

    Ok(out)
}

/// Writes the compilation output in the requested format.
/// 
/// This function handles the final stage of compilation, outputting either:
/// - LLVM-style IR (intermediate representation)
/// - AArch64 assembly code
/// 
/// Note: AST dumping is handled separately in main() before IR generation.
/// 
/// # Arguments
/// * `dump_mode` - The output format to generate (IR or assembly)
/// * `module_generator` - The IR module containing all generated code
/// * `writer` - Output destination (file or stdout)
fn write_output<W: Write>(
    dump_mode: DumpMode,
    module_generator: &ir::ModuleGenerator,
    writer: &mut W,
) {
    match dump_mode {
        DumpMode::IR => {
            // Generate and output LLVM-style intermediate representation
            module_generator.output(writer).unwrap_or_else(|e| {
                eprintln!("Encountered error outputting: {e}");
                std::process::exit(1);
            });
        }
        DumpMode::S => {
            // Lower IR to AArch64 assembly code
            let asm_gen = asm::AArch64AsmGenerator::new(
                &module_generator.module,
                &module_generator.registry,
            );
            asm_gen.output(writer).unwrap_or_else(|e| {
                eprintln!("Encountered error while generating assembly: {e}");
                std::process::exit(1);
            });
        }
        DumpMode::AST => unreachable!("AST dumping is handled in main() before IR generation"),
    }
}

/// Main entry point for the TeaLang compiler.
/// 
/// Compilation pipeline:
/// 1. Parse command-line arguments
/// 2. Preprocess source file (expand #use directives)
/// 3. Parse source code into AST
/// 4. Generate IR from AST (if not dumping AST)
/// 5. Output result in requested format (AST/IR/assembly)
fn main() {
    // Parse command-line arguments
    let cli = Cli::parse();
    let input_path = cli.input;

    // Stage 1: Preprocess the input file
    // Recursively expands #use directives and checks for include cycles
    let mut visited = HashSet::new();
    let prog = preprocess_file(Path::new(&input_path), &mut visited).unwrap_or_else(|e| {
        eprintln!("Error: Failed to read input file '{input_path}': {e}");
        eprintln!("\nUsage: teac [OPTIONS] <FILE>");
        eprintln!("Try 'teac --help' for more information.");
        std::process::exit(1);
    });

    // Stage 2: Parse the preprocessed source into an Abstract Syntax Tree
    let ast = parser::parse(&prog).unwrap_or_else(|e| {
        eprintln!("Encountered error while parsing: {e}");
        std::process::exit(1);
    });

    // If AST dump requested, output it and exit early
    if cli.dump == DumpMode::AST {
        print!("{}", ast);
        return;
    }

    // Stage 3: Generate LLVM-style Intermediate Representation from the AST
    // This performs semantic analysis, type checking, and IR code generation
    let mut module_generator = ir::ModuleGenerator::new();
    module_generator.gen(&ast).unwrap_or_else(|e| {
        eprintln!("Encountered error while generating IR from AST: {e}");
        std::process::exit(1);
    });

    // Stage 4: Write output in the requested format (IR or assembly)
    // Create output writer: either to a file or stdout
    match &cli.output {
        Some(output_path) => {
            // Output to file: create parent directories if needed
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
            // Output to stdout
            let mut writer = BufWriter::new(io::stdout());
            write_output(cli.dump, &module_generator, &mut writer);
        }
    }
}
