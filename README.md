# Teaplc-rs

A Rust-based reimplementation of the [Teapl compiler](https://github.com/hxuhack/compiler_project.git).

## Quick Start

To build and run the compiler on a sample program:

```bash
cargo run -- tests/progs/dfs.tea
```

This will generate the LLVM IR file `dfs.tea.ll` under `tests/progs/`.

## Project Milestones

* ~~Grammar definition~~
* ~~AST definition~~
* ~~Parsing~~
* ~~LLVM IR generation~~
* ~~Type checking~~
* SSA (in progress)

## Resources

* [LALRPOP Repository](https://github.com/lalrpop/lalrpop)
* [LALRPOP Documentation](https://lalrpop.github.io/lalrpop/)
* [Teaplc in C++ (Yi Sun’s Fall 2024 Implementation)](https://github.com/Boreas618/Compilers-24Fall)
