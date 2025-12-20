# Teac

A Rust-based compiler for the [Teapl language](https://github.com/hxuhack/compiler_project.git), featuring LLVM IR generation and native AArch64 code generation.

## Features

- **LALRPOP-based parser** with preprocessor support (`#use` directives)
- **SSA-style intermediate representation** compatible with LLVM IR
- **Native AArch64 backend** with register allocation
- **Cross-platform testing** via Docker on macOS

## Quick Start

Build the compiler:

```bash
cargo build --release
```

Compile a Teapl program to LLVM IR:

```bash
cargo run -- tests/dfs/dfs.tea
```

Compile to AArch64 assembly:

```bash
cargo run -- tests/dfs/dfs.tea -d s -o dfs.s
```

## Usage

```
teac [OPTIONS] <FILE>

Arguments:
  <FILE>  Input file (.tea source)

Options:
  -d <MODE>        Dump mode: ast, ir (default), or s (assembly)
  -o <FILE>        Output file (default: input with .ll or .s extension)
  -h, --help       Print help
```

### Examples

```bash
# Dump AST
cargo run -- program.tea -d ast

# Generate LLVM IR (default)
cargo run -- program.tea -o program.ll

# Generate AArch64 assembly
cargo run -- program.tea -d s -o program.s
```

## Project Structure

```
src/
├── ast/          # Abstract Syntax Tree definitions
├── ir/           # Intermediate Representation & code generation
│   └── gen/      # IR generation from AST
├── asm/          # Assembly backends
│   ├── aarch64/  # AArch64 code generation & register allocation
│   └── common/   # Shared backend utilities
├── main.rs       # CLI entry point
└── teapl.lalrpop # Grammar definition
```

## Testing

Run the full test suite:

```bash
cargo test
```

> **Note (macOS):** Tests require Docker to cross-compile and run AArch64 binaries. Ensure Docker Desktop is installed and running.

## Project Milestones

- [x] Grammar definition
- [x] AST definition
- [x] Parsing
- [x] LLVM IR generation
- [x] Type checking
- [x] SSA-style IR
- [x] AArch64 code generation
- [x] Register allocation

## Resources

- [LALRPOP Repository](https://github.com/lalrpop/lalrpop)
- [LALRPOP Documentation](https://lalrpop.github.io/lalrpop/)
- [Teaplc in C++ (Yi Sun's Fall 2024 Implementation)](https://github.com/Boreas618/Compilers-24Fall)
