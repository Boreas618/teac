use std::fs::{self, File, OpenOptions};
use std::io::{self, Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

#[inline(always)]
fn launch(dir: &PathBuf, input_file: &str, output_file: &str) -> String {
    let project_root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let tool = project_root.join("target/debug/teac");
    let output: Output = Command::new(tool)
        .arg(input_file)
        .arg("-o")
        .arg(output_file)
        .current_dir(dir)
        .output()
        .expect("Failed to execute teac");
    String::from_utf8_lossy(&output.stderr).into_owned()
}

/// Normalize output like `diff -Bb`:
/// -b: ignore changes in the amount of whitespace (collapse runs to single spaces)
/// -B: ignore blank lines
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

fn read_to_string_if_exists(path: &Path) -> io::Result<Option<String>> {
    match fs::read_to_string(path) {
        Ok(s) => Ok(Some(s)),
        Err(e) if e.kind() == io::ErrorKind::NotFound => Ok(None),
        Err(e) => Err(e),
    }
}

fn run_capture(cmd: &mut Command) -> io::Result<(i32, Vec<u8>, Vec<u8>)> {
    let output = cmd.output()?;
    let code = output.status.code().unwrap_or(-1);
    Ok((code, output.stdout, output.stderr))
}

fn append_line<P: AsRef<Path>>(path: P, line: &str) {
    let mut f = OpenOptions::new()
        .create(true)
        .append(true)
        .open(path.as_ref())
        .unwrap_or_else(|e| panic!("Failed to open {} for append: {e}", path.as_ref().display()));
    writeln!(f, "{line}").expect("Failed to append line");
}

/// End-to-end functional test that mirrors the shell function:
/// 1) Compile .tea -> .ll
/// 2) Link with sylib.ll -> out/<name>.ll
/// 3) Run with lli (stdin from <name>.in if present), capture stdout to out/<name>.out
///    and append the exit code as a final line
/// 4) If <name>.out (expected) exists, compare with -Bb normalization; else warn
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

    let output_name = format!("{test_name}.ll");
    let output_path = out_dir.join(&output_name);
    let stderr = launch(
        &case_dir,
        &format!("{test_name}.tea"),
        &output_path.to_str().unwrap(),
    );
    assert!(
        stderr.is_empty(),
        "✗ Compilation failed, teac stderr:\n{stderr}"
    );

    assert!(
        output_path.is_file(),
        "Expected compiler to produce {}",
        output_path.display()
    );

    let stdlib = base_dir.join("std").join("std.ll");
    assert!(
        stdlib.is_file(),
        "✗ std.ll not found at {}",
        stdlib.display()
    );

    // Link: llvm-link "<dir>/<name>.ll" "src/sylib.ll" -S -o "<dir>/out/<name>.ll"
    let product = out_dir.join(&output_name);
    let (link_code, _link_out, link_err) = run_capture(
        Command::new("llvm-link")
            .arg(&product)
            .arg(&stdlib)
            .arg("-S")
            .arg("-o")
            .arg(&product)
            .stdout(Stdio::piped())
            .stderr(Stdio::piped()),
    )
    .expect("Failed to execute llvm-link");
    assert!(
        link_code == 0,
        "✗ Linking failed (exit {link_code}). Stderr:\n{}",
        String::from_utf8_lossy(&link_err)
    );

    let input = case_dir.join(format!("{test_name}.in"));
    let expected_out = case_dir.join(format!("{test_name}.out"));
    let actual_out = out_dir.join(format!("{test_name}.out"));

    let (run_code, run_stdout, _run_stderr) = if input.is_file() {
        // Feed stdin from <name>.in
        let mut data = Vec::new();
        File::open(&input)
            .and_then(|mut f| {
                f.read_to_end(&mut data)?;
                Ok(())
            })
            .unwrap_or_else(|e| panic!("Failed to read {}: {e}", input.display()));

        // spawn to write stdin
        let mut child = Command::new("lli")
            .arg(&product)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .spawn()
            .expect("Failed to spawn lli");
        {
            let mut stdin = child.stdin.take().expect("Failed to open lli stdin");
            stdin.write_all(&data).expect("Failed to write lli stdin");
        }
        let out = child.wait_with_output().expect("Failed to wait for lli");
        (out.status.code().unwrap_or(-1), out.stdout, out.stderr)
    } else {
        run_capture(
            Command::new("lli")
                .arg(&product)
                .stdin(Stdio::null())
                .stdout(Stdio::piped())
                .stderr(Stdio::piped()),
        )
        .expect("Failed to run lli")
    };

    if run_code == 124 {
        panic!("✗ Timeout");
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
                panic!("✗ Output mismatch for {test_name}");
            }
        }
        None => {
            eprintln!("⚠ No expected output file for {test_name} (treated as pass)");
        }
    }
}

#[test]
fn test() {
    test_single("dfs");
}
