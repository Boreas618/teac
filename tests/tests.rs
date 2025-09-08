use std::fs;
use std::path::Path;
use std::process::{Command, Output};

/// Run `teapl <input> -o <output>` inside a given tests subdirectory
/// and return stderr as a String.
#[inline(always)]
fn running_tests_with_arg(dir: &str, input_file: &str, output_file: &str) -> String {
    // Path to the test directory, e.g., "./progs/xxx"
    let prog_path: &Path = Path::new(dir);

    // Project root directory
    let project_root = Path::new(env!("CARGO_MANIFEST_DIR"));
    // Path to the teaplc executable
    let tool = project_root.join("target/debug/teac");

    // Execute: teaplc <input_file> -o <output_file> in prog_path
    let output: Output = Command::new(tool)
        .arg(input_file)
        .arg("-o")
        .arg(output_file)
        .current_dir(prog_path)
        .output()
        .expect("Failed to execute teac");

    // Convert stderr bytes into a UTF-8 String and return
    String::from_utf8_lossy(&output.stderr).into_owned()
}

#[test]
fn test_dfs() {
    let dir = "tests/progs"; // directory containing dfs.tea and dfs_oracle.ll
    let input_file = "dfs.tea";
    let output_file = "dfs.ll";
    let oracle_file = "oracle/dfs.ll";

    // Run teapl command
    let stderr = running_tests_with_arg(dir, input_file, output_file);
    assert!(stderr.is_empty(), "teapl reported errors:\n{}", stderr);

    // Read the generated output file
    let output_path = Path::new(dir).join(output_file);
    let output_content = fs::read_to_string(output_path)
        .expect("Failed to read generated output file");

    // Read the oracle file
    let oracle_path = Path::new(dir).join(oracle_file);
    let oracle_content = fs::read_to_string(oracle_path)
        .expect("Failed to read oracle file");

    // Compare contents
    assert_eq!(output_content, oracle_content, "Generated output does not match oracle");
}
