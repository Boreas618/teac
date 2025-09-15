use std::ffi::OsStr;
use std::fs::{self, File, OpenOptions};
use std::io::{self, Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};
use std::sync::Once;

static INIT: Once = Once::new();

fn ensure_std() {
    INIT.call_once(|| {
        let project_root = Path::new(env!("CARGO_MANIFEST_DIR"));
        let std_dir = project_root.join("tests").join("std");
        let c_path = std_dir.join("std.c");
        let ll_path = std_dir.join("std.ll");

        // If std.ll already exists and is newer than std.c, skip rebuild.
        let needs_build = match (fs::metadata(&c_path), fs::metadata(&ll_path)) {
            (Ok(c_meta), Ok(ll_meta)) => {
                match (c_meta.modified(), ll_meta.modified()) {
                    (Ok(c_m), Ok(ll_m)) => c_m > ll_m, // std.c is newer → rebuild
                    _ => true,
                }
            }
            (Ok(_), Err(_)) => true, // no std.ll yet
            _ => {
                panic!("✗ Missing tests/std/std.c at {}", c_path.display());
            }
        };

        if needs_build {
            let clang = OsStr::new("clang");
            let status = Command::new(clang)
                .arg("-S")
                .arg("-emit-llvm")
                .arg("std.c")
                .arg("-o")
                .arg("std.ll")
                .current_dir(&std_dir)
                .status()
                .expect("Failed to execute clang for std.ll");
            assert!(
                status.success(),
                "✗ clang failed to build std.ll (exit {}). Ran in {}\nHint: ensure clang/LLVM are on PATH.",
                status.code().unwrap_or(-1),
                std_dir.display()
            );
        }
        assert!(ll_path.is_file(), "✗ std.ll not found at {}", ll_path.display());
    });
}

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
                panic!("Output mismatch for {test_name}");
            }
        }
        None => {
            eprintln!("⚠ No expected output file for {test_name} (treated as pass)");
        }
    }
}

#[test]
fn dfs() {
    ensure_std();
    test_single("dfs");
}

#[test]
fn bfs() {
    ensure_std();
    test_single("bfs");
}

#[test]
fn big_int_mul() {
    ensure_std();
    test_single("big_int_mul");
}

#[test]
fn bin_search() {
    ensure_std();
    test_single("bin_search");
}

#[test]
fn brainfk_pl() {
    ensure_std();
    test_single("brainfk_pl");
}
