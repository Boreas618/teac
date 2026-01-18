//! Integration tests for the TeaLang compiler.
//!
//! This test suite validates the TeaLang compiler (`teac`) by compiling test programs,
//! linking them with a standard library, and executing them across different platforms.
//! The suite supports multiple compilation and execution environments:
//!
//! - **Native AArch64 Linux**: Direct compilation and execution using `gcc`
//! - **x86/x86_64 Linux**: Cross-compilation to AArch64 using `aarch64-linux-gnu-gcc` and execution via QEMU
//! - **macOS**: Cross-compilation and execution using Docker containers with ARM64 Linux
//!
//! Each test compiles a `.tea` source file to assembly, links it with `std.o` (the standard library),
//! runs the resulting executable, and compares the output against expected results.

use std::fs::{self, File, OpenOptions};
use std::io::{self, Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};
use std::sync::Once;

/// Ensures the standard library is compiled exactly once across all tests.
static INIT: Once = Once::new();

/// Detects if the current platform is macOS.
///
/// On macOS, the test suite uses Docker to compile and run AArch64 Linux binaries,
/// as macOS does not natively support Linux binaries.
///
/// # Returns
///
/// `true` if running on macOS, `false` otherwise.
fn is_macos() -> bool {
    cfg!(target_os = "macos")
}

/// Detects if the current platform requires cross-compilation from x86/x86_64 Linux.
///
/// On x86/x86_64 Linux systems, the test suite uses cross-compilation tools
/// (`aarch64-linux-gnu-gcc`) and QEMU user-mode emulation to build and run
/// AArch64 binaries.
///
/// # Returns
///
/// `true` if running on x86 or x86_64 Linux, `false` otherwise.
fn is_cross_linux() -> bool {
    cfg!(all(
        target_os = "linux",
        any(target_arch = "x86", target_arch = "x86_64")
    ))
}

/// Checks if a command is available in the system PATH.
///
/// Uses the `which` command to determine if a given executable is available.
/// This is used to verify that required cross-compilation tools are installed.
///
/// # Arguments
///
/// * `cmd` - The name of the command to check (e.g., "docker", "qemu-aarch64")
///
/// # Returns
///
/// `true` if the command exists in PATH and is executable, `false` otherwise.
fn command_exists(cmd: &str) -> bool {
    Command::new("which")
        .arg(cmd)
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .map(|s| s.success())
        .unwrap_or(false)
}

/// Verifies that the required cross-compilation toolchain is available.
///
/// Depending on the platform, this function checks for:
/// - **macOS**: Docker (for running Linux AArch64 binaries in containers)
/// - **x86/x86_64 Linux**: `aarch64-linux-gnu-gcc` (cross-compiler) and `qemu-aarch64` (emulator)
/// - **Native AArch64 Linux**: No special tools required
///
/// # Panics
///
/// Panics with a helpful error message if required tools are missing or not running.
/// The error messages include installation instructions for missing dependencies.
fn ensure_cross_tools() {
    if is_macos() {
        // Check for Docker (needed to run Linux aarch64 binaries on macOS)
        if !command_exists("docker") {
            panic!(
                "✗ Docker not found.\n\
                 Please install Docker Desktop for macOS: https://www.docker.com/products/docker-desktop"
            );
        }

        // Verify Docker is running
        let status = Command::new("docker")
            .arg("info")
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .status();
        if !status.map(|s| s.success()).unwrap_or(false) {
            panic!(
                "✗ Docker is not running.\n\
                 Please start Docker Desktop."
            );
        }
    } else if is_cross_linux() {
        // Check for aarch64 cross-compiler
        if !command_exists("aarch64-linux-gnu-gcc") {
            panic!(
                "✗ aarch64-linux-gnu-gcc not found.\n\
                 Please install: sudo apt install gcc-aarch64-linux-gnu"
            );
        }

        // Check for QEMU user-mode emulator
        if !command_exists("qemu-aarch64") {
            panic!(
                "✗ qemu-aarch64 not found.\n\
                 Please install: sudo apt install qemu-user"
            );
        }
    }
    // Native aarch64 Linux needs no special tools
}

/// Returns the platform-appropriate path to the compiled standard library object file.
///
/// The standard library (`std.c`) is compiled to different object files depending on
/// the compilation environment to avoid conflicts:
/// - **Native AArch64 Linux**: `tests/std/std.o`
/// - **Cross-compilation (macOS or x86 Linux)**: `tests/std/std-linux.o`
///
/// # Returns
///
/// A `PathBuf` pointing to the appropriate `std.o` or `std-linux.o` file.
fn get_std_o_path() -> PathBuf {
    let project_root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let std_dir = project_root.join("tests").join("std");
    if is_macos() || is_cross_linux() {
        // Use a separate file for cross-compiled object to avoid conflicts
        std_dir.join("std-linux.o")
    } else {
        std_dir.join("std.o")
    }
}

/// Compiles the standard library C file to an object file using Docker on macOS.
///
/// On macOS, Docker is used to run a Linux ARM64 container with GCC to compile
/// `std.c` into an AArch64 object file that can be linked with test programs.
///
/// # Arguments
///
/// * `std_dir` - Path to the directory containing `std.c`
/// * `o_path` - Path where the compiled object file should be written
///
/// # Panics
///
/// Panics if Docker fails to compile `std.c`, with the exit code displayed.
fn compile_std_in_docker(std_dir: &Path, o_path: &Path) {
    let o_name = o_path.file_name().unwrap().to_str().unwrap();

    let status = Command::new("docker")
        .arg("run")
        .arg("--rm")
        .arg("-v")
        .arg(format!("{}:/work", std_dir.display()))
        .arg("-w")
        .arg("/work")
        .arg("--platform")
        .arg("linux/arm64")
        .arg("gcc:latest")
        .arg("gcc")
        .arg("-c")
        .arg("std.c")
        .arg("-o")
        .arg(o_name)
        .status()
        .expect("Failed to run docker");

    assert!(
        status.success(),
        "✗ Failed to compile std.c in Docker (exit {})",
        status.code().unwrap_or(-1)
    );
}

/// Compiles the standard library C file using the AArch64 cross-compiler on x86 Linux.
///
/// Uses `aarch64-linux-gnu-gcc` to cross-compile `std.c` into an AArch64 object file
/// that can be linked with test programs and executed via QEMU.
///
/// # Arguments
///
/// * `std_dir` - Path to the directory containing `std.c`
/// * `o_path` - Path where the compiled object file should be written
///
/// # Panics
///
/// Panics if the cross-compiler fails, displaying the exit code and paths involved.
fn compile_std_cross_linux(std_dir: &Path, o_path: &Path) {
    let status = Command::new("aarch64-linux-gnu-gcc")
        .arg("-c")
        .arg("std.c")
        .arg("-o")
        .arg(o_path)
        .current_dir(std_dir)
        .status()
        .expect("Failed to execute aarch64-linux-gnu-gcc");

    assert!(
        status.success(),
        "✗ aarch64-linux-gnu-gcc failed to build {} (exit {}). Ran in {}",
        o_path.display(),
        status.code().unwrap_or(-1),
        std_dir.display()
    );
}

/// Ensures the standard library object file (`std.o`) is compiled and up-to-date.
///
/// This function is called once before any tests run (enforced by the `INIT` static).
/// It performs the following steps:
/// 1. Verifies required cross-compilation tools are available
/// 2. Checks if `std.o` needs to be rebuilt (if missing or older than `std.c`)
/// 3. Compiles `std.c` using the appropriate method for the current platform:
///    - **macOS**: Uses Docker with GCC in a Linux ARM64 container
///    - **x86/x86_64 Linux**: Uses `aarch64-linux-gnu-gcc` cross-compiler
///    - **Native AArch64 Linux**: Uses native `gcc`
///
/// # Panics
///
/// Panics if:
/// - Required cross-compilation tools are not available
/// - `std.c` is missing from `tests/std/`
/// - Compilation fails
/// - The resulting `std.o` file is not found after compilation
fn ensure_std() {
    INIT.call_once(|| {
        // Ensure cross tools are available
        ensure_cross_tools();

        let project_root = Path::new(env!("CARGO_MANIFEST_DIR"));
        let std_dir = project_root.join("tests").join("std");
        let c_path = std_dir.join("std.c");
        let o_path = get_std_o_path();

        // If std.o already exists and is newer than std.c, skip rebuild.
        let needs_build = match (fs::metadata(&c_path), fs::metadata(&o_path)) {
            (Ok(c_meta), Ok(o_meta)) => {
                match (c_meta.modified(), o_meta.modified()) {
                    (Ok(c_m), Ok(o_m)) => c_m > o_m, // std.c is newer → rebuild
                    _ => true,
                }
            }
            (Ok(_), Err(_)) => true, // no std.o yet
            _ => {
                panic!("✗ Missing tests/std/std.c at {}", c_path.display());
            }
        };

        if needs_build {
            if is_macos() {
                compile_std_in_docker(&std_dir, &o_path);
            } else if is_cross_linux() {
                compile_std_cross_linux(&std_dir, &o_path);
            } else {
                // Native aarch64 Linux
                let status = Command::new("gcc")
                    .arg("-c")
                    .arg("std.c")
                    .arg("-o")
                    .arg(&o_path)
                    .current_dir(&std_dir)
                    .status()
                    .expect("Failed to execute gcc");

                assert!(
                    status.success(),
                    "✗ gcc failed to build {} (exit {}). Ran in {}",
                    o_path.display(),
                    status.code().unwrap_or(-1),
                    std_dir.display()
                );
            }
        }
        assert!(
            o_path.is_file(),
            "✗ std.o not found at {}",
            o_path.display()
        );
    });
}

/// Invokes the TeaLang compiler to compile a `.tea` source file to assembly.
///
/// Executes the `teac` binary (built by Cargo) with the specified input and output files.
/// The compilation is performed in the given directory with debug mode set to assembly (`-d s`).
///
/// # Arguments
///
/// * `dir` - Working directory where the compilation should be executed
/// * `input_file` - Name of the input `.tea` file (relative to `dir`)
/// * `output_file` - Name of the output assembly file to generate
///
/// # Returns
///
/// The `Output` from the compiler process, containing exit status, stdout, and stderr.
#[inline(always)]
fn launch(dir: &PathBuf, input_file: &str, output_file: &str) -> Output {
    let tool = Path::new(env!("CARGO_BIN_EXE_teac"));
    Command::new(tool)
        .arg(input_file)
        .arg("-d")
        .arg("s")
        .arg("-o")
        .arg(output_file)
        .current_dir(dir)
        .output()
        .expect("Failed to execute teac")
}

/// Normalizes text output for comparison using "diff -Bb" style rules.
///
/// This function normalizes whitespace in text to make output comparison more robust:
/// - Collapses consecutive whitespace into single spaces
/// - Removes blank lines
/// - Ensures the output ends with a newline if non-empty
///
/// This mimics the behavior of `diff -Bb` (ignore blank lines and changes in whitespace).
///
/// # Arguments
///
/// * `s` - The text to normalize
///
/// # Returns
///
/// A normalized string with consistent whitespace formatting.
fn normalize_for_diff_bb(s: &str) -> String {
    let mut out = Vec::new();
    for line in s.lines() {
        let norm = line.split_whitespace().collect::<Vec<_>>().join(" ");
        if norm.is_empty() {
            continue; // drop blank lines
        }
        out.push(norm);
    }
    if out.is_empty() {
        String::new()
    } else {
        out.join("\n") + "\n"
    }
}

/// Reads a file to a string if it exists, returning `None` if the file is not found.
///
/// # Arguments
///
/// * `path` - Path to the file to read
///
/// # Returns
///
/// - `Ok(Some(String))` if the file exists and was read successfully
/// - `Ok(None)` if the file does not exist
/// - `Err(io::Error)` for other I/O errors
fn read_to_string_if_exists(path: &Path) -> io::Result<Option<String>> {
    match fs::read_to_string(path) {
        Ok(s) => Ok(Some(s)),
        Err(e) if e.kind() == io::ErrorKind::NotFound => Ok(None),
        Err(e) => Err(e),
    }
}

/// Runs a command and captures its exit code, stdout, and stderr.
///
/// # Arguments
///
/// * `cmd` - The command to execute (must be configured with stdout/stderr as `Stdio::piped()`)
///
/// # Returns
///
/// A tuple containing:
/// - Exit code (or -1 if unavailable)
/// - stdout as bytes
/// - stderr as bytes
fn run_capture(cmd: &mut Command) -> io::Result<(i32, Vec<u8>, Vec<u8>)> {
    let output = cmd.output()?;
    let code = output.status.code().unwrap_or(-1);
    Ok((code, output.stdout, output.stderr))
}

/// Appends a line of text to a file, creating the file if it doesn't exist.
///
/// # Arguments
///
/// * `path` - Path to the file to append to
/// * `line` - The line of text to append (a newline will be added automatically)
///
/// # Panics
///
/// Panics if the file cannot be opened or written to.
fn append_line<P: AsRef<Path>>(path: P, line: &str) {
    let mut f = OpenOptions::new()
        .create(true)
        .append(true)
        .open(path.as_ref())
        .unwrap_or_else(|e| panic!("Failed to open {} for append: {e}", path.as_ref().display()));
    writeln!(f, "{line}").expect("Failed to append line");
}

/// Links assembly code with the standard library and runs the resulting executable in Docker.
///
/// This function is used on macOS where native Linux AArch64 execution is not possible.
/// It performs two operations using Docker containers:
/// 1. Links the assembly file with `std.o` using GCC in a Linux ARM64 container
/// 2. Runs the resulting executable in a Debian container, optionally with input from a file
///
/// # Arguments
///
/// * `build_dir` - Directory containing the assembly file and where the executable will be created
/// * `asm_name` - Name of the assembly file to link
/// * `std_o` - Path to the standard library object file
/// * `exe_name` - Name for the output executable
/// * `input` - Optional path to a file whose contents will be provided as stdin to the executable
///
/// # Returns
///
/// A tuple containing:
/// - Exit code of the executable (or linker on failure)
/// - stdout from the executable
/// - stderr from the executable (or linker error message)
fn link_and_run_in_docker(
    build_dir: &Path,
    asm_name: &str,
    std_o: &Path,
    exe_name: &str,
    input: Option<&Path>,
) -> io::Result<(i32, Vec<u8>, Vec<u8>)> {
    // We need to mount both the build dir and the std dir
    let std_dir = std_o.parent().unwrap();
    let std_o_name = std_o.file_name().unwrap().to_str().unwrap();

    // Link the executable inside Docker
    let link_status = Command::new("docker")
        .arg("run")
        .arg("--rm")
        .arg("-v")
        .arg(format!("{}:/build", build_dir.display()))
        .arg("-v")
        .arg(format!("{}:/std:ro", std_dir.display()))
        .arg("-w")
        .arg("/build")
        .arg("--platform")
        .arg("linux/arm64")
        .arg("gcc:latest")
        .arg("gcc")
        .arg(asm_name)
        .arg(format!("/std/{std_o_name}"))
        .arg("-o")
        .arg(exe_name)
        .arg("-static")
        .status()?;

    if !link_status.success() {
        return Ok((
            link_status.code().unwrap_or(-1),
            Vec::new(),
            b"Linking failed in Docker".to_vec(),
        ));
    }

    // Run the executable inside Docker
    let mut run_cmd = Command::new("docker");
    run_cmd
        .arg("run")
        .arg("--rm")
        .arg("-i")
        .arg("-v")
        .arg(format!("{}:/build:ro", build_dir.display()))
        .arg("-w")
        .arg("/build")
        .arg("--platform")
        .arg("linux/arm64")
        .arg("debian:bookworm-slim")
        .arg(format!("./{exe_name}"));

    if let Some(input_path) = input {
        let mut data = Vec::new();
        File::open(input_path)?.read_to_end(&mut data)?;

        let mut child = run_cmd
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()?;

        if let Some(mut stdin) = child.stdin.take() {
            stdin.write_all(&data)?;
        }

        let output = child.wait_with_output()?;
        Ok((
            output.status.code().unwrap_or(-1),
            output.stdout,
            output.stderr,
        ))
    } else {
        run_capture(
            run_cmd
                .stdin(Stdio::null())
                .stdout(Stdio::piped())
                .stderr(Stdio::piped()),
        )
    }
}

/// Links assembly code with the standard library using the AArch64 cross-compiler.
///
/// This function is used on x86/x86_64 Linux systems to link AArch64 assembly code
/// with the standard library object file. The resulting executable must be run using
/// QEMU user-mode emulation.
///
/// # Arguments
///
/// * `build_dir` - Working directory for the linking operation
/// * `asm_path` - Path to the assembly source file
/// * `std_o` - Path to the standard library object file
/// * `exe_path` - Path where the output executable should be written
///
/// # Returns
///
/// `Ok((exit_code, stderr))` on successful execution, where:
/// - `exit_code` - Exit code from the linker (0 indicates success)
/// - `stderr` - stderr from the linker (for error messages)
///
/// `Err` if the command execution fails (e.g., command not found, I/O error).
fn link_cross_linux(
    build_dir: &Path,
    asm_path: &Path,
    std_o: &Path,
    exe_path: &Path,
) -> io::Result<(i32, Vec<u8>)> {
    let output = Command::new("aarch64-linux-gnu-gcc")
        .arg(asm_path)
        .arg(std_o)
        .arg("-o")
        .arg(exe_path)
        .arg("-static")
        .current_dir(build_dir)
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .output()?;

    Ok((output.status.code().unwrap_or(-1), output.stderr))
}

/// Runs an AArch64 executable using QEMU user-mode emulation.
///
/// This function is used on x86/x86_64 Linux systems to execute AArch64 binaries
/// that were cross-compiled for ARM architecture.
///
/// # Arguments
///
/// * `exe` - Path to the AArch64 executable to run
/// * `input` - Optional path to a file whose contents will be provided as stdin
///
/// # Returns
///
/// `Ok((exit_code, stdout, stderr))` on successful execution, where:
/// - `exit_code` - Exit code from the executable
/// - `stdout` - stdout from the executable
/// - `stderr` - stderr from the executable
///
/// `Err` if the command execution fails (e.g., QEMU not found, I/O error).
fn run_with_qemu(exe: &Path, input: Option<&Path>) -> io::Result<(i32, Vec<u8>, Vec<u8>)> {
    if let Some(input_path) = input {
        let mut data = Vec::new();
        File::open(input_path)?.read_to_end(&mut data)?;

        let mut child = Command::new("qemu-aarch64")
            .arg(exe)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()?;

        if let Some(mut stdin) = child.stdin.take() {
            stdin.write_all(&data)?;
        }

        let output = child.wait_with_output()?;
        Ok((
            output.status.code().unwrap_or(-1),
            output.stdout,
            output.stderr,
        ))
    } else {
        run_capture(
            Command::new("qemu-aarch64")
                .arg(exe)
                .stdin(Stdio::null())
                .stdout(Stdio::piped())
                .stderr(Stdio::piped()),
        )
    }
}

/// Links assembly code with the standard library using the native GCC on AArch64 Linux.
///
/// This function is used on native AArch64 Linux systems where cross-compilation
/// is not necessary.
///
/// # Arguments
///
/// * `build_dir` - Working directory for the linking operation
/// * `asm_path` - Path to the assembly source file
/// * `std_o` - Path to the standard library object file
/// * `exe_path` - Path where the output executable should be written
///
/// # Returns
///
/// `Ok((exit_code, stderr))` on successful execution, where:
/// - `exit_code` - Exit code from the linker (0 indicates success)
/// - `stderr` - stderr from the linker (for error messages)
///
/// `Err` if the command execution fails (e.g., GCC not found, I/O error).
fn link_native(
    build_dir: &Path,
    asm_path: &Path,
    std_o: &Path,
    exe_path: &Path,
) -> io::Result<(i32, Vec<u8>)> {
    let output = Command::new("gcc")
        .arg(asm_path)
        .arg(std_o)
        .arg("-o")
        .arg(exe_path)
        .current_dir(build_dir)
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .output()?;

    Ok((output.status.code().unwrap_or(-1), output.stderr))
}

/// Runs an executable natively on AArch64 Linux.
///
/// This function executes a binary directly on the host system without emulation.
///
/// # Arguments
///
/// * `exe` - Path to the executable to run
/// * `input` - Optional path to a file whose contents will be provided as stdin
///
/// # Returns
///
/// `Ok((exit_code, stdout, stderr))` on successful execution, where:
/// - `exit_code` - Exit code from the executable
/// - `stdout` - stdout from the executable
/// - `stderr` - stderr from the executable
///
/// `Err` if the command execution fails (e.g., executable not found, I/O error).
fn run_native(exe: &Path, input: Option<&Path>) -> io::Result<(i32, Vec<u8>, Vec<u8>)> {
    if let Some(input_path) = input {
        let mut data = Vec::new();
        File::open(input_path)?.read_to_end(&mut data)?;

        let mut child = Command::new(exe)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()?;

        if let Some(mut stdin) = child.stdin.take() {
            stdin.write_all(&data)?;
        }

        let output = child.wait_with_output()?;
        Ok((
            output.status.code().unwrap_or(-1),
            output.stdout,
            output.stderr,
        ))
    } else {
        run_capture(
            Command::new(exe)
                .stdin(Stdio::null())
                .stdout(Stdio::piped())
                .stderr(Stdio::piped()),
        )
    }
}

/// Runs a single integration test for the TeaLang compiler.
///
/// This function orchestrates the complete test workflow:
/// 1. Locates the test's `.tea` source file in `tests/{test_name}/`
/// 2. Compiles the source to assembly using `teac`
/// 3. Links the assembly with the standard library (`std.o`)
/// 4. Executes the resulting binary (with optional input from `{test_name}.in`)
/// 5. Compares the output against expected results in `{test_name}.out`
///
/// The compilation, linking, and execution strategy varies by platform:
/// - **macOS**: Uses Docker containers for both linking and execution
/// - **x86/x86_64 Linux**: Uses cross-compilation and QEMU for execution
/// - **Native AArch64 Linux**: Uses native GCC for linking and direct execution
///
/// # Arguments
///
/// * `test_name` - Name of the test (must match the directory name in `tests/`)
///
/// # Test File Structure
///
/// Each test is expected to have the following structure in `tests/{test_name}/`:
/// - `{test_name}.tea` - Required: The TeaLang source file to compile
/// - `{test_name}.in` - Optional: Input data to provide to the program via stdin
/// - `{test_name}.out` - Required: Expected output (stdout + exit code on last line)
/// - `build/` - Directory where compilation artifacts are created
///
/// # Output Comparison
///
/// The actual output is compared against expected output using whitespace-insensitive
/// comparison (similar to `diff -Bb`). The exit code is appended as the last line of
/// the output file.
///
/// # Panics
///
/// Panics if:
/// - The test source file is not found
/// - Compilation fails or produces stderr output
/// - Linking fails
/// - The expected output file is missing
/// - The actual output doesn't match the expected output
fn test_single(test_name: &str) {
    let base_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests");
    let case_dir = base_dir.join(test_name);

    let out_dir = case_dir.join("build");
    fs::create_dir_all(&out_dir).expect("Failed to create output dir");

    let tea = case_dir.join(format!("{test_name}.tea"));
    assert!(
        tea.is_file(),
        "✗ {test_name}: Test file not found at {}",
        tea.display()
    );

    let output_name = format!("{test_name}.s");
    let output_path = out_dir.join(&output_name);
    let output = launch(
        &case_dir,
        &format!("{test_name}.tea"),
        output_path.to_str().unwrap(),
    );
    let stderr = String::from_utf8_lossy(&output.stderr).into_owned();
    assert!(
        output.status.success(),
        "✗ Compilation failed (exit {}). teac stderr:\n{stderr}",
        output.status.code().unwrap_or(-1)
    );
    assert!(
        stderr.is_empty(),
        "✗ Compilation produced stderr:\n{stderr}"
    );

    assert!(
        output_path.is_file(),
        "Expected compiler to produce {}",
        output_path.display()
    );

    let stdlib = get_std_o_path();
    assert!(
        stdlib.is_file(),
        "✗ std.o not found at {}",
        stdlib.display()
    );

    let input = case_dir.join(format!("{test_name}.in"));
    let expected_out = case_dir.join(format!("{test_name}.out"));
    let actual_out = out_dir.join(format!("{test_name}.out"));

    let input_path = if input.is_file() {
        Some(input.as_path())
    } else {
        None
    };

    let (run_code, run_stdout, run_stderr) = if is_macos() {
        // Use Docker for linking and running on macOS
        link_and_run_in_docker(&out_dir, &output_name, &stdlib, test_name, input_path)
            .expect("Failed to run in Docker")
    } else if is_cross_linux() {
        // Use cross-compiler and QEMU on x86/x86_64 Linux
        let exe = out_dir.join(test_name);
        let (link_code, link_err) =
            link_cross_linux(&out_dir, &output_path, &stdlib, &exe).expect("Failed to link");
        assert!(
            link_code == 0,
            "✗ Linking failed (exit {link_code}). Stderr:\n{}",
            String::from_utf8_lossy(&link_err)
        );
        run_with_qemu(&exe, input_path).expect("Failed to run with QEMU")
    } else {
        // Native linking and running on aarch64 Linux
        let exe = out_dir.join(test_name);
        let (link_code, link_err) =
            link_native(&out_dir, &output_path, &stdlib, &exe).expect("Failed to link");
        assert!(
            link_code == 0,
            "✗ Linking failed (exit {link_code}). Stderr:\n{}",
            String::from_utf8_lossy(&link_err)
        );
        run_native(&exe, input_path).expect("Failed to run executable")
    };

    // Check for linking failures (from Docker path)
    if !run_stderr.is_empty() {
        let stderr_str = String::from_utf8_lossy(&run_stderr);
        if stderr_str.contains("Linking failed") {
            panic!("✗ Linking failed. Stderr:\n{stderr_str}");
        }
    }

    // Write stdout to actual_out and append exit code
    fs::write(&actual_out, &run_stdout)
        .unwrap_or_else(|e| panic!("Failed to write {}: {e}", actual_out.display()));
    append_line(&actual_out, &run_code.to_string());

    // Compare with expected if present (diff -Bb style)
    match read_to_string_if_exists(&expected_out).expect("Failed to read expected output file") {
        Some(exp) => {
            let got = fs::read_to_string(&actual_out)
                .unwrap_or_else(|e| panic!("Failed to read {}: {e}", actual_out.display()));
            let exp_norm = normalize_for_diff_bb(&exp);
            let got_norm = normalize_for_diff_bb(&got);
            if exp_norm != got_norm {
                if std::env::var_os("VERBOSE").is_some() {
                    eprintln!("✗ Output mismatch for {test_name}");
                    eprintln!("--- Expected:\n{exp}");
                    eprintln!("--- Got:\n{got}");
                }
                panic!("Output mismatch for {test_name}");
            }
        }
        None => {
            panic!(
                "✗ No expected output file for {test_name} at {}",
                expected_out.display()
            );
        }
    }
}

/// Tests the depth-first search (DFS) algorithm implementation.
#[test]
fn dfs() {
    ensure_std();
    test_single("dfs");
}

/// Tests the breadth-first search (BFS) algorithm implementation.
#[test]
fn bfs() {
    ensure_std();
    test_single("bfs");
}

/// Tests arbitrary-precision integer multiplication.
#[test]
fn big_int_mul() {
    ensure_std();
    test_single("big_int_mul");
}

/// Tests binary search algorithm implementation.
#[test]
fn bin_search() {
    ensure_std();
    test_single("bin_search");
}

/// Tests a Brainfuck interpreter implementation.
#[test]
fn brainfk() {
    ensure_std();
    test_single("brainfk");
}

/// Tests array convolution operations.
#[test]
fn conv() {
    ensure_std();
    test_single("conv");
}

/// Tests Dijkstra's shortest path algorithm.
#[test]
fn dijkstra() {
    ensure_std();
    test_single("dijkstra");
}

/// Tests expression evaluation and parsing.
#[test]
fn expr_eval() {
    ensure_std();
    test_single("expr_eval");
}

/// Tests fully connected neural network layer computation.
#[test]
fn full_conn() {
    ensure_std();
    test_single("full_conn");
}

/// Tests the Tower of Hanoi recursive solution.
#[test]
fn hanoi() {
    ensure_std();
    test_single("hanoi");
}

/// Tests insertion sort with order preservation.
#[test]
fn insert_order() {
    ensure_std();
    test_single("insert_order");
}

/// Tests integer input/output operations.
#[test]
fn int_io() {
    ensure_std();
    test_single("int_io");
}

/// Tests integer digit splitting operations.
#[test]
fn int_split() {
    ensure_std();
    test_single("int_split");
}

/// Tests the jump game dynamic programming solution.
#[test]
fn jump_game() {
    ensure_std();
    test_single("jump_game");
}

/// Tests linear search algorithm.
#[test]
fn line_search() {
    ensure_std();
    test_single("line_search");
}

/// Tests compilation of large code files (stress test).
#[test]
fn long_code() {
    ensure_std();
    test_single("long_code");
}

/// Tests compilation of large code files (stress test variant 2).
#[test]
fn long_code2() {
    ensure_std();
    test_single("long_code2");
}

/// Tests handling of many global variables.
#[test]
fn many_globals() {
    ensure_std();
    test_single("many_globals");
}

/// Tests handling of many local variables.
#[test]
fn many_locals2() {
    ensure_std();
    test_single("many_locals2");
}

/// Tests matrix multiplication implementation.
#[test]
fn matrix_mul() {
    ensure_std();
    test_single("matrix_mul");
}

/// Tests deeply nested function calls.
#[test]
fn nested_calls() {
    ensure_std();
    test_single("nested_calls");
}

/// Tests deeply nested loop structures.
#[test]
fn nested_loops() {
    ensure_std();
    test_single("nested_loops");
}

/// Tests palindrome number detection algorithm.
#[test]
fn palindrome_number() {
    ensure_std();
    test_single("palindrome_number");
}

/// Tests register allocation correctness.
#[test]
fn register_alloca() {
    ensure_std();
    test_single("register_alloca");
}

/// Tests short-circuit evaluation of logical expressions (variant 3).
#[test]
fn short_circuit3() {
    ensure_std();
    test_single("short_circuit3");
}

/// Tests sorting algorithm implementation (variant 5).
#[test]
fn sort_test5() {
    ensure_std();
    test_single("sort_test5");
}

/// Tests sorting algorithm implementation (variant 7).
#[test]
fn sort_test7() {
    ensure_std();
    test_single("sort_test7");
}

/// Tests general sorting algorithm implementation.
#[test]
fn sort() {
    ensure_std();
    test_single("sort");
}

/// Tests the unique paths dynamic programming problem.
#[test]
fn unique_path() {
    ensure_std();
    test_single("unique_path");
}
