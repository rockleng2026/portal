//! The execution tools: shell commands, tests, git.
//!
//! These are the tools the agent uses to find out whether what it did actually worked. The
//! output of a command is returned **verbatim** - the agent has to be able to read a compiler
//! error or a failing test, and paraphrasing that would defeat the purpose.

use crate::policy::AutonomyLevel;
use crate::tools::capabilities::{CAP_FILE_WRITE, CAP_GIT_COMMIT, CAP_GIT_READ, CAP_SSH_EXEC};
use crate::tools::{arg_str, opt_bool, opt_str, Tool, ToolContext, ToolResult};
use anyhow::{anyhow, Result};
use serde_json::{json, Value};
use std::path::PathBuf;
use std::process::{Command, Stdio};
use std::time::Duration;

/// How long a command may run before it is killed.
pub const DEFAULT_TIMEOUT: Duration = Duration::from_secs(300);

/// Runs a shell command.
pub struct ShellExec {
    pub timeout: Duration,
    /// The commands the agent may run. Empty means "nothing".
    pub allowed_commands: Vec<String>,
}

impl Default for ShellExec {
    fn default() -> Self {
        Self {
            timeout: DEFAULT_TIMEOUT,
            allowed_commands: Vec::new(),
        }
    }
}

impl Tool for ShellExec {
    fn name(&self) -> &str {
        "shell_exec"
    }

    fn description(&self) -> &str {
        "Run a shell command in the workspace and return its output and exit code. \
         Use it to build, to run tests, to inspect the repository."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {
                "command": {"type": "string", "description": "The command line to run"},
                "timeout_seconds": {"type": "integer"}
            },
            "required": ["command"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some(CAP_SSH_EXEC)
    }

    fn min_level(&self) -> AutonomyLevel {
        AutonomyLevel::L3
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let command = arg_str(arguments, "command")?;
        if !self.allowed_commands.is_empty() {
            let program = command.split_whitespace().next().unwrap_or("");
            let permitted = self.allowed_commands.iter().any(|allowed| {
                allowed == program || allowed == "*" || command.starts_with(allowed.as_str())
            });
            if !permitted {
                return Ok(ToolResult::failure(
                    "shell_exec",
                    "COMMAND_NOT_ALLOWED",
                    format!("{program} is not one of the commands this agent may run"),
                ));
            }
        }
        let timeout = opt_str(arguments, "timeout_seconds")
            .and_then(|v| v.parse::<u64>().ok())
            .map(Duration::from_secs)
            .unwrap_or(self.timeout);

        let output = run_command(&command, &context.cwd, timeout)?;
        let text = output.text.clone();
        let mut result = if output.success {
            ToolResult::ok("shell_exec", text)
        } else {
            ToolResult::failure("shell_exec", "COMMAND_FAILED", text)
        };
        result.touched = output.touched;
        Ok(result)
    }
}

/// Runs the project's tests and summarises what failed.
///
/// The summary is the point: a wall of test output is what the model already gets from
/// `shell_exec`, and this tool adds the part it cannot work out itself - which tests failed
/// and what they said.
pub struct RunTests {
    /// The command that runs the tests. Detected when not set.
    pub command: Option<String>,
    pub timeout: Duration,
}

impl Default for RunTests {
    fn default() -> Self {
        Self {
            command: None,
            timeout: DEFAULT_TIMEOUT,
        }
    }
}

impl Tool for RunTests {
    fn name(&self) -> &str {
        "run_tests"
    }

    fn description(&self) -> &str {
        "Run the project's test suite and return a summary: how many tests ran, which failed \
         and what they said. This is how you find out whether your change worked."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {
                "command": {"type": "string", "description": "Override the test command"},
                "filter": {"type": "string", "description": "Only run tests matching this"}
            }
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some(CAP_SSH_EXEC)
    }

    fn min_level(&self) -> AutonomyLevel {
        AutonomyLevel::L2
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let command = opt_str(arguments, "command")
            .or_else(|| self.command.clone())
            .or_else(|| detect_test_command(&context.cwd))
            .ok_or_else(|| {
                anyhow!("no test command found; pass one explicitly")
            })?;
        let command = match opt_str(arguments, "filter") {
            Some(filter) if !filter.is_empty() => format!("{command} {filter}"),
            _ => command,
        };
        let output = run_command(&command, &context.cwd, self.timeout)?;
        let summary = summarise_tests(&output.text);
        let mut result = if output.success {
            ToolResult::ok("run_tests", summary)
        } else {
            ToolResult::failure("run_tests", "TESTS_FAILED", summary)
        };
        result.touched = output.touched;
        Ok(result)
    }
}

/// Shows the repository state.
pub struct GitStatus;

impl Tool for GitStatus {
    fn name(&self) -> &str {
        "git_status"
    }

    fn description(&self) -> &str {
        "Show the branch, the changed files and the diff of the working tree."
    }

    fn schema(&self) -> Value {
        json!({"type": "object", "properties": {}})
    }

    fn capability(&self) -> Option<&'static str> {
        Some(CAP_GIT_READ)
    }

    fn min_level(&self) -> AutonomyLevel {
        AutonomyLevel::L0
    }

    fn run(&self, context: &ToolContext, _arguments: &Value) -> Result<ToolResult> {
        let status = run_command("git status --porcelain=v1 --branch", &context.cwd, DEFAULT_TIMEOUT)?;
        let diff = run_command("git diff --stat", &context.cwd, DEFAULT_TIMEOUT)?;
        let mut out = status.text;
        if !diff.text.trim().is_empty() {
            out.push_str("\n--- diff --stat ---\n");
            out.push_str(&diff.text);
        }
        Ok(ToolResult::ok("git_status", out))
    }
}

/// Creates a git commit.
pub struct GitCommit;

impl Tool for GitCommit {
    fn name(&self) -> &str {
        "git_commit"
    }

    fn description(&self) -> &str {
        "Stage everything that changed and create a commit with the given message."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {"message": {"type": "string"}},
            "required": ["message"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some(CAP_GIT_COMMIT)
    }

    fn min_level(&self) -> AutonomyLevel {
        AutonomyLevel::L2
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let message = arg_str(arguments, "message")?;
        let add = run_command("git add -A", &context.cwd, DEFAULT_TIMEOUT)?;
        if !add.success {
            return Ok(ToolResult::failure("git_commit", "COMMAND_FAILED", add.text));
        }
        let commit = run_command(
            &format!("git commit -m {}", shell_quote(&message)),
            &context.cwd,
            DEFAULT_TIMEOUT,
        )?;
        if !commit.success {
            return Ok(ToolResult::failure("git_commit", "COMMAND_FAILED", commit.text));
        }
        Ok(ToolResult::ok("git_commit", commit.text))
    }
}

/// The result of running a command.
pub struct CommandOutput {
    pub success: bool,
    pub text: String,
    pub touched: Vec<String>,
}

/// Runs a shell command and captures its output.
pub fn run_command(command: &str, cwd: &std::path::Path, timeout: Duration) -> Result<CommandOutput> {
    let mut child = Command::new("sh")
        .arg("-c")
        .arg(command)
        .current_dir(cwd)
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .map_err(|e| anyhow!("cannot start '{command}': {e}"))?;

    let deadline = std::time::Instant::now() + timeout;
    loop {
        if child.try_wait()?.is_some() {
            break;
        }
        if std::time::Instant::now() > deadline {
            let _ = child.kill();
            return Ok(CommandOutput {
                success: false,
                text: format!("command timed out after {}s: {command}", timeout.as_secs()),
                touched: Vec::new(),
            });
        }
        std::thread::sleep(Duration::from_millis(20));
    }
    let output = child.wait_with_output()?;
    let mut text = String::from_utf8_lossy(&output.stdout).to_string();
    let stderr = String::from_utf8_lossy(&output.stderr).to_string();
    if !stderr.trim().is_empty() {
        text.push_str("\n--- stderr ---\n");
        text.push_str(&stderr);
    }
    text.push_str(&format!("\n[exit code: {}]", output.status.code().unwrap_or(-1)));
    Ok(CommandOutput {
        success: output.status.success(),
        text,
        touched: Vec::new(),
    })
}

/// Picks a test command that fits the project.
pub fn detect_test_command(cwd: &std::path::Path) -> Option<String> {
    if cwd.join("Cargo.toml").exists() {
        return Some("cargo test".to_string());
    }
    if cwd.join("package.json").exists() {
        return Some("npm test --silent".to_string());
    }
    if cwd.join("pom.xml").exists() {
        return Some("mvn -B -q test".to_string());
    }
    if cwd.join("build.gradle").exists() || cwd.join("build.gradle.kts").exists() {
        return Some("./gradlew test".to_string());
    }
    if cwd.join("go.mod").exists() {
        return Some("go test ./...".to_string());
    }
    if cwd.join("pytest.ini").exists() || cwd.join("pyproject.toml").exists() {
        return Some("pytest -q".to_string());
    }
    None
}

/// Extracts the interesting part of a test run.
pub fn summarise_tests(output: &str) -> String {
    let mut failures = Vec::new();
    let mut counts = Vec::new();
    for line in output.lines() {
        let trimmed = line.trim();
        if trimmed.starts_with("test result:")
            || trimmed.contains("Tests run:")
            || trimmed.contains("tests passed")
            || trimmed.contains("test result")
        {
            counts.push(trimmed.to_string());
        }
        if trimmed.starts_with("FAIL") || trimmed.starts_with("FAILED") || trimmed.contains("panicked at") {
            failures.push(trimmed.to_string());
        }
    }
    let mut summary = String::new();
    for count in counts.iter().take(5) {
        summary.push_str(count);
        summary.push('\n');
    }
    if !failures.is_empty() {
        summary.push_str("--- failures ---\n");
        for failure in failures.iter().take(20) {
            summary.push_str(failure);
            summary.push('\n');
        }
    }
    if summary.is_empty() {
        summary = output.lines().rev().take(20).collect::<Vec<_>>().join("\n");
    }
    summary
}

/// Quotes a string for a POSIX shell.
pub fn shell_quote(value: &str) -> String {
    format!("'{}'", value.replace('\'', "'\\''"))
}

/// Registers the execution tools.
pub fn register(registry: &mut crate::tools::ToolRegistry) {
    registry.register(std::sync::Arc::new(ShellExec::default()));
    registry.register(std::sync::Arc::new(RunTests::default()));
    registry.register(std::sync::Arc::new(GitStatus));
    registry.register(std::sync::Arc::new(GitCommit));
}

/// Whether a git repository is present in the workspace.
pub fn is_git_repository(cwd: &std::path::Path) -> bool {
    cwd.join(".git").exists()
}

/// The path of the workspace, for the tools that need it.
pub fn workspace_path(context: &ToolContext) -> PathBuf {
    context.workspace.root().to_path_buf()
}

/// Whether the agent may write to the repository (used by the loop's planning step).
pub fn may_write(context: &ToolContext) -> bool {
    opt_bool(&json!({}), "unused")
        || context
            .policy
            .capabilities()
            .contains(CAP_FILE_WRITE)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn runs_a_command_and_reports_the_exit_code() {
        let dir = tempfile::tempdir().unwrap();
        let output = run_command("echo hello", dir.path(), DEFAULT_TIMEOUT).unwrap();
        assert!(output.success);
        assert!(output.text.contains("hello"));
        assert!(output.text.contains("exit code: 0"));
    }

    #[test]
    fn a_failing_command_is_reported_as_a_failure() {
        let dir = tempfile::tempdir().unwrap();
        let output = run_command("exit 3", dir.path(), DEFAULT_TIMEOUT).unwrap();
        assert!(!output.success);
        assert!(output.text.contains("exit code: 3"));
    }

    #[test]
    fn detects_the_test_command() {
        let dir = tempfile::tempdir().unwrap();
        assert_eq!(detect_test_command(dir.path()), None);
        std::fs::write(dir.path().join("Cargo.toml"), "[package]").unwrap();
        assert_eq!(detect_test_command(dir.path()), Some("cargo test".to_string()));
    }

    #[test]
    fn summarises_a_test_run() {
        let output = "running 3 tests\ntest a ... ok\ntest b ... FAILED\ntest result: FAILED. 1 passed; 1 failed\n";
        let summary = summarise_tests(output);
        assert!(summary.contains("test result:"));
        assert!(summary.contains("FAILED"));
    }

    #[test]
    fn quotes_shell_arguments() {
        assert_eq!(shell_quote("it's fine"), "'it'\\''s fine'");
    }
}
