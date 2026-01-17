# Module-Prefixed Function Calls Implementation Summary

## Overview
This implementation adds strict function-call rules to the TeaLang compiler, enforcing proper module scoping for imported vs. locally-defined functions.

## Implementation Details

### 1. Pest Grammar Changes (`src/teapl.pest`)
- Added `kw_use` keyword for module imports
- Added `double_colon` delimiter (`::`) for module prefixes
- Updated `identifier` to exclude `use` keyword
- Modified `program` rule to accept `use_stmt*` before program elements
- Added `use_stmt` rule: `kw_use ~ identifier ~ semicolon`
- Split `fn_call` into two variants:
  - `module_prefixed_call`: `identifier ~ double_colon ~ identifier ~ lparen ~ right_val_list? ~ rparen`
  - `local_call`: `identifier ~ lparen ~ right_val_list? ~ rparen`

### 2. AST Changes
**`src/ast/program.rs`:**
- Added `UseStmt` struct with `module_name: String` field
- Updated `Program` struct to include `use_stmts: Vec<UseStmt>`

**`src/ast/expr.rs`:**
- Updated `FnCall` struct to include `module_prefix: Option<String>` field

**`src/ast/display.rs` & `src/ast/tree.rs`:**
- Updated display implementations to show module prefixes in function calls

**`src/ast/mod.rs`:**
- Exported `UseStmt` type

### 3. Parser Changes (`src/parser.rs`)
- Updated `parse()` function to handle `use_stmt` rules
- Added `parse_use_stmt()` function to parse use statements
- Refactored `parse_fn_call()` into three functions:
  - `parse_fn_call()`: Dispatcher
  - `parse_module_prefixed_call()`: Handles `module::function()` syntax
  - `parse_local_call()`: Handles `function()` syntax

### 4. IR Generation Changes (`src/ir/gen/module_gen.rs`)
- Updated `gen()` to process `use_stmts` before program elements
- Added `handle_use_stmt()` to register module functions
- Added `register_std_functions()` to register standard library functions with `std::` prefix:
  - `std::getint()` -> `i32`
  - `std::getch()` -> `i32`
  - `std::putint(i32)` -> `void`
  - `std::putch(i32)` -> `void`
  - `std::timer_start(i32)` -> `void`
  - `std::timer_stop(i32)` -> `void`
  - `std::putarray(i32, *i32)` -> `void`

**`src/ir/gen/function_gen.rs`:**
- Updated `handle_call_stmt()` and `handle_expr_unit()` to construct full function names with module prefixes

### 5. Assembly Generation Changes (`src/asm/aarch64/function_generator.rs`)
- Modified function call emission to strip module prefix from function names
- Uses `rfind("::")` to extract the actual function name for external calls

### 6. Preprocessing Changes (`src/main.rs`)
- Modified `preprocess_file()` to preserve `use std;` statements
- External modules (like `std`) are not expanded from `.teah` files
- Other modules continue to be expanded as before

### 7. Test Updates
**All existing tests (`tests/**/*.tea`):**
- Updated 29 test files to use `std::` prefix for all standard library function calls
- All tests pass (29/29)

**New test cases (`tests/module_prefix_tests/`):**
1. `correct_imported_with_prefix.tea` - ✓ Passes (uses `std::putint()`)
2. `error_imported_without_prefix.tea` - ✓ Correctly fails (tries `putint()` without prefix)
3. `correct_local_without_prefix.tea` - ✓ Passes (calls local `helper()`)
4. `error_local_with_prefix.tea` - ✓ Correctly fails (tries `main::helper()`)

## Rules Enforced

### Rule 1: Imported Module Functions
Functions from imported modules (via `use <module_name>`) **MUST** be called with the module prefix.

**Correct:**
```tea
use std;
fn main()->i32 {
    std::putint(42);
    ret 0;
}
```

**Incorrect (will fail):**
```tea
use std;
fn main()->i32 {
    putint(42);  // ERROR: Function putint not defined
    ret 0;
}
```

### Rule 2: Local Functions
Functions defined in the current file **MUST** be called without a module prefix.

**Correct:**
```tea
fn helper(x:i32)->i32 { ret x + 1; }
fn main()->i32 {
    let result:i32 = helper(41);
    ret 0;
}
```

**Incorrect (will fail):**
```tea
fn helper(x:i32)->i32 { ret x + 1; }
fn main()->i32 {
    let result:i32 = main::helper(41);  // ERROR: Invalid expression
    ret 0;
}
```

## Validation Results

### Test Suite
- **29/29** existing tests pass
- **4/4** new validation tests work correctly

### Code Review
- No issues found

### Security Scan (CodeQL)
- No vulnerabilities detected

## Technical Notes

1. **External Functions**: The `std` library functions are implemented in C (`tests/std/std.c`) and linked separately. The module prefix is stripped during assembly generation to match the actual C function names.

2. **Module Registry**: The IR generator maintains a function type registry where imported functions are registered with their full module-prefixed names (e.g., `std::getint`).

3. **Backward Compatibility**: The preprocessing mechanism for `.teah` header files remains intact for user-defined modules.

4. **Error Messages**: When users call imported functions without the prefix, they get a clear error: "Function <name> not defined", guiding them to use the module prefix.

## Files Modified
- `src/teapl.pest` - Grammar definition
- `src/ast/program.rs` - AST program structure
- `src/ast/expr.rs` - AST expression types
- `src/ast/display.rs` - AST display implementation
- `src/ast/tree.rs` - AST tree display
- `src/ast/mod.rs` - AST module exports
- `src/parser.rs` - Parser implementation
- `src/ir/gen/module_gen.rs` - IR module generation
- `src/ir/gen/function_gen.rs` - IR function generation
- `src/asm/aarch64/function_generator.rs` - Assembly generation
- `src/main.rs` - Preprocessing logic
- `tests/**/*.tea` - All 29 existing test files
- `tests/module_prefix_tests/*` - 4 new test files + README
