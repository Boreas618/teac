# Module Prefix Test Cases

This directory contains test cases to validate the strict function-call rules enforced by the TeaLang compiler.

## Test Files

### 1. correct_imported_with_prefix.tea
**Purpose**: Demonstrates correct usage of imported module functions with the module prefix.
**Expected**: Should compile successfully.
**Details**: Uses `std::putint()` and `std::putch()` with the required `std::` prefix.

### 2. error_imported_without_prefix.tea
**Purpose**: Demonstrates incorrect usage of imported module functions without the module prefix.
**Expected**: Should FAIL with error "Function putint not defined".
**Details**: Attempts to call `putint()` without the `std::` prefix, which should be rejected.

### 3. correct_local_without_prefix.tea
**Purpose**: Demonstrates correct usage of locally-defined functions without a module prefix.
**Expected**: Should compile successfully.
**Details**: Defines a local `helper()` function and calls it without any prefix.

### 4. error_local_with_prefix.tea
**Purpose**: Demonstrates incorrect usage of locally-defined functions with a module prefix.
**Expected**: Should FAIL with error "Invalid expression unit" or function not found.
**Details**: Attempts to call a local function with `main::helper()` prefix, which should be rejected.

## Rules Enforced

1. **Imported Module Functions**: Functions from imported modules (via `use <module_name>`) MUST be called with the module prefix (e.g., `std::getint()`).

2. **Local Functions**: Functions defined in the current file MUST be called without a module prefix (e.g., `helper()`, not `main::helper()`).

## Running Tests

To test these cases manually:

```bash
# Should succeed
./target/debug/teac tests/module_prefix_tests/correct_imported_with_prefix.tea -d s -o /tmp/test.s

# Should fail
./target/debug/teac tests/module_prefix_tests/error_imported_without_prefix.tea -d s -o /tmp/test.s

# Should succeed
./target/debug/teac tests/module_prefix_tests/correct_local_without_prefix.tea -d s -o /tmp/test.s

# Should fail
./target/debug/teac tests/module_prefix_tests/error_local_with_prefix.tea -d s -o /tmp/test.s
```
