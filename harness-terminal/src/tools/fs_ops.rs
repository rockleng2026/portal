//! The file tools: read, write, edit, list, search.
//!
//! "Edit" is the interesting one. A blind write is how an agent destroys a file it only
//! half-understood, so `edit_file` takes the exact text to replace and refuses when it is not
//! there - or when it is there more than once, because "which one?" is a question the agent
//! has to answer, not one the tool should guess.

use crate::tools::{arg_path, arg_str, opt_bool, opt_i64, opt_str, Tool, ToolContext, ToolResult};
use crate::workspace::Workspace;
use anyhow::{anyhow, Result};
use serde_json::{json, Value};

/// Reads a file.
pub struct ReadFile {
    /// How many bytes to read at most.
    pub max_bytes: usize,
}

impl Default for ReadFile {
    fn default() -> Self {
        Self { max_bytes: 256 * 1024 }
    }
}

impl Tool for ReadFile {
    fn name(&self) -> &str {
        "read_file"
    }

    fn description(&self) -> &str {
        "Read a file from the workspace. Returns the content with line numbers."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {
                "path": {"type": "string", "description": "Path relative to the workspace root"},
                "offset": {"type": "integer", "description": "First line to return (1-based)"},
                "limit": {"type": "integer", "description": "How many lines to return"}
            },
            "required": ["path"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some("cap:fs.read")
    }

    fn min_level(&self) -> crate::policy::AutonomyLevel {
        crate::policy::AutonomyLevel::L0
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let path = arg_path(context, arguments, "path")?;
        let content = context.workspace.read_file(&path.to_string_lossy())?;
        let lines: Vec<&str> = content.lines().collect();
        let offset = opt_i64(arguments, "offset").unwrap_or(1).max(1) as usize;
        let limit = opt_i64(arguments, "limit").unwrap_or(0).max(0) as usize;
        let end = if limit == 0 {
            lines.len()
        } else {
            (offset - 1 + limit).min(lines.len())
        };
        let mut out = String::new();
        let mut bytes = 0usize;
        for (index, line) in lines
            .iter()
            .enumerate()
            .take(end)
            .skip(offset - 1)
        {
            let rendered = format!("{:>6}\t{}\n", index + 1, line);
            bytes += rendered.len();
            if bytes > self.max_bytes {
                out.push_str("... (truncated)\n");
                break;
            }
            out.push_str(&rendered);
        }
        let mut result = ToolResult::ok("read_file", out);
        result.touched.push(context.workspace.relative(&path));
        Ok(result)
    }
}

/// Writes a file, creating it if needed.
pub struct WriteFile;

impl Tool for WriteFile {
    fn name(&self) -> &str {
        "write_file"
    }

    fn description(&self) -> &str {
        "Write a file. Overwrites the whole file. Use edit_file for a targeted change."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {
                "path": {"type": "string"},
                "content": {"type": "string"}
            },
            "required": ["path", "content"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some("cap:fs.write")
    }

    fn min_level(&self) -> crate::policy::AutonomyLevel {
        crate::policy::AutonomyLevel::L2
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let path = arg_path(context, arguments, "path")?;
        let content = arg_str(arguments, "content")?;
        context.workspace.write_file(&path.to_string_lossy(), &content)?;
        let mut result = ToolResult::ok(
            "write_file",
            format!("wrote {} bytes", content.len()),
        );
        result.touched.push(context.workspace.relative(&path));
        Ok(result)
    }
}

/// Replaces an exact piece of text in a file.
pub struct EditFile;

impl Tool for EditFile {
    fn name(&self) -> &str {
        "edit_file"
    }

    fn description(&self) -> &str {
        "Replace an exact string in a file. The old string must appear exactly once, \
         otherwise nothing is changed."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {
                "path": {"type": "string"},
                "old": {"type": "string", "description": "The exact text to replace"},
                "new": {"type": "string", "description": "The replacement text"},
                "replace_all": {"type": "boolean"}
            },
            "required": ["path", "old", "new"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some("cap:fs.write")
    }

    fn min_level(&self) -> crate::policy::AutonomyLevel {
        crate::policy::AutonomyLevel::L2
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let path = arg_path(context, arguments, "path")?;
        let old = arg_str(arguments, "old")?;
        let new = arg_str(arguments, "new")?;
        if old == new {
            return Ok(ToolResult::failure(
                "edit_file",
                "NO_CHANGE",
                "the old and the new text are identical",
            ));
        }
        let content = context.workspace.read_file(&path.to_string_lossy())?;
        let occurrences = content.matches(&old).count();
        let replace_all = opt_bool(arguments, "replace_all");
        if occurrences == 0 {
            return Ok(ToolResult::failure(
                "edit_file",
                "OLD_TEXT_NOT_FOUND",
                "the text to replace does not appear in the file",
            ));
        }
        if occurrences > 1 && !replace_all {
            return Ok(ToolResult::failure(
                "edit_file",
                "OLD_TEXT_AMBIGUOUS",
                format!(
                    "the text to replace appears {occurrences} times; include more context or pass replace_all"
                ),
            ));
        }
        let updated = if replace_all {
            content.replace(&old, &new)
        } else {
            content.replacen(&old, &new, 1)
        };
        context.workspace.write_file(&path.to_string_lossy(), &updated)?;
        let mut result = ToolResult::ok(
            "edit_file",
            format!("replaced {occurrences} occurrence(s)"),
        );
        result.touched.push(context.workspace.relative(&path));
        Ok(result)
    }
}

/// Deletes a file. Destructive: it needs a human approval.
pub struct DeleteFile;

impl Tool for DeleteFile {
    fn name(&self) -> &str {
        "delete_file"
    }

    fn description(&self) -> &str {
        "Delete a file. This is destructive and needs a human approval."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {"path": {"type": "string"}},
            "required": ["path"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some("cap:fs.delete")
    }

    fn min_level(&self) -> crate::policy::AutonomyLevel {
        crate::policy::AutonomyLevel::L3
    }

    fn requires_approval(&self) -> bool {
        true
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let path = arg_path(context, arguments, "path")?;
        if !path.exists() {
            return Ok(ToolResult::failure(
                "delete_file",
                "NOT_FOUND",
                format!("{} does not exist", path.display()),
            ));
        }
        std::fs::remove_file(&path)?;
        let mut result = ToolResult::ok("delete_file", format!("deleted {}", path.display()));
        result.touched.push(context.workspace.relative(&path));
        Ok(result)
    }
}

/// Lists the workspace.
pub struct ListFiles {
    pub max_entries: usize,
}

impl Default for ListFiles {
    fn default() -> Self {
        Self { max_entries: 2000 }
    }
}

impl Tool for ListFiles {
    fn name(&self) -> &str {
        "list_files"
    }

    fn description(&self) -> &str {
        "List the files in the workspace with their language and size. Start here to understand \
         the shape of a codebase."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {"path": {"type": "string", "description": "Subdirectory to list"}}
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some("cap:fs.read")
    }

    fn min_level(&self) -> crate::policy::AutonomyLevel {
        crate::policy::AutonomyLevel::L0
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let sub = opt_str(arguments, "path");
        let workspace = match sub {
            Some(sub) => context.workspace.with_root(context.workspace.root().join(sub)),
            None => context.workspace.as_ref().clone(),
        };
        let files = workspace.list_files()?;
        let mut out = String::new();
        for file in files.iter().take(self.max_entries) {
            out.push_str(&format!(
                "{:<10} {:>9}  {}\n",
                file.language.unwrap_or("-"),
                file.size,
                file.path
            ));
        }
        if files.len() > self.max_entries {
            out.push_str(&format!("... and {} more\n", files.len() - self.max_entries));
        }
        Ok(ToolResult::ok("list_files", out))
    }
}

/// Searches the workspace for text or a pattern.
pub struct SearchCode {
    pub max_results: usize,
}

impl Default for SearchCode {
    fn default() -> Self {
        Self { max_results: 200 }
    }
}

impl Tool for SearchCode {
    fn name(&self) -> &str {
        "search_code"
    }

    fn description(&self) -> &str {
        "Search the workspace for a regular expression. Returns file:line matches."
    }

    fn schema(&self) -> Value {
        json!({
            "type": "object",
            "properties": {
                "pattern": {"type": "string", "description": "Regular expression"},
                "path": {"type": "string", "description": "Subdirectory to search"},
                "language": {"type": "string"}
            },
            "required": ["pattern"]
        })
    }

    fn capability(&self) -> Option<&'static str> {
        Some("cap:fs.read")
    }

    fn min_level(&self) -> crate::policy::AutonomyLevel {
        crate::policy::AutonomyLevel::L0
    }

    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
        let pattern = arg_str(arguments, "pattern")?;
        let regex = regex::Regex::new(&pattern)
            .map_err(|e| anyhow!("invalid regular expression '{pattern}': {e}"))?;
        let sub = opt_str(arguments, "path");
        let language = opt_str(arguments, "language");
        let root = match &sub {
            Some(sub) => context.workspace.root().join(sub),
            None => context.workspace.root().to_path_buf(),
        };
        let mut out = String::new();
        let mut hits = 0usize;
        let walker = ignore::WalkBuilder::new(&root)
            .hidden(false)
            .git_ignore(true)
            .parents(false)
            .build();
        for entry in walker.flatten() {
            if hits >= self.max_results {
                out.push_str("... (more matches not shown)\n");
                break;
            }
            if !entry.file_type().map(|t| t.is_file()).unwrap_or(false) {
                continue;
            }
            if let Some(language) = &language {
                if crate::workspace::language_of(entry.path()) != Some(language.as_str()) {
                    continue;
                }
            }
            let Ok(content) = std::fs::read_to_string(entry.path()) else {
                continue;
            };
            for (index, line) in content.lines().enumerate() {
                if regex.is_match(line) {
                    hits += 1;
                    let relative = context.workspace.relative(entry.path());
                    out.push_str(&format!("{}:{}: {}\n", relative, index + 1, line.trim()));
                    if hits >= self.max_results {
                        break;
                    }
                }
            }
        }
        if hits == 0 {
            out.push_str("no matches\n");
        }
        Ok(ToolResult::ok("search_code", out))
    }
}

/// Registers the file tools.
pub fn register(registry: &mut crate::tools::ToolRegistry) {
    registry.register(std::sync::Arc::new(ReadFile::default()));
    registry.register(std::sync::Arc::new(WriteFile));
    registry.register(std::sync::Arc::new(EditFile));
    registry.register(std::sync::Arc::new(DeleteFile));
    registry.register(std::sync::Arc::new(ListFiles::default()));
    registry.register(std::sync::Arc::new(SearchCode::default()));
}

/// The workspace type, re-exported for the tools' signature.
pub type AgentWorkspace = Workspace;

#[cfg(test)]
mod tests {
    use super::*;
    use crate::policy::{AutonomyLevel, LocalPolicy};
    use crate::tools::{ToolCall, ToolRegistry};
    use serde_json::json;
    use std::sync::Arc;

    fn registry_and_context(dir: &std::path::Path) -> (ToolRegistry, ToolContext) {
        let mut registry = ToolRegistry::new();
        register(&mut registry);
        let workspace = Arc::new(Workspace::new(dir).unwrap());
        let policy = Arc::new(LocalPolicy::new(
            AutonomyLevel::L3,
            vec![
                "cap:fs.read".to_string(),
                "cap:fs.write".to_string(),
                "cap:fs.delete".to_string(),
            ],
            vec![dir.to_path_buf()],
        ));
        let context = ToolContext {
            workspace,
            policy,
            cwd: dir.to_path_buf(),
            now_epoch: 100,
            approval: None,
        };
        (registry, context)
    }

    #[test]
    fn reads_a_file_with_line_numbers() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("a.txt"), "one\ntwo\n").unwrap();
        let (registry, context) = registry_and_context(dir.path());
        let result = registry.dispatch(
            &ToolCall {
                name: "read_file".into(),
                arguments: json!({"path": "a.txt"}),
            },
            &context,
        );
        assert!(result.ok, "{}", result.output);
        assert!(result.output.contains("1\tone"));
        assert!(result.output.contains("2\ttwo"));
    }

    #[test]
    fn an_ambiguous_edit_changes_nothing() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("a.txt"), "x = 1\nx = 1\n").unwrap();
        let (registry, context) = registry_and_context(dir.path());
        let result = registry.dispatch(
            &ToolCall {
                name: "edit_file".into(),
                arguments: json!({"path": "a.txt", "old": "x = 1", "new": "x = 2"}),
            },
            &context,
        );
        assert!(!result.ok);
        assert_eq!(result.reason_code.as_deref(), Some("OLD_TEXT_AMBIGUOUS"));
        let content = std::fs::read_to_string(dir.path().join("a.txt")).unwrap();
        assert_eq!(content, "x = 1\nx = 1\n", "the file must not be touched");
    }

    #[test]
    fn an_exact_edit_is_applied_once() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("a.txt"), "x = 1\nx = 1\n").unwrap();
        let (registry, context) = registry_and_context(dir.path());
        let result = registry.dispatch(
            &ToolCall {
                name: "edit_file".into(),
                arguments: json!({"path": "a.txt", "old": "x = 1\nx = 1", "new": "x = 2"}),
            },
            &context,
        );
        assert!(result.ok, "{}", result.output);
        let content = std::fs::read_to_string(dir.path().join("a.txt")).unwrap();
        assert_eq!(content, "x = 2\n");
    }

    #[test]
    fn a_delete_without_an_approval_is_refused() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("a.txt"), "x").unwrap();
        let (registry, context) = registry_and_context(dir.path());
        let result = registry.dispatch(
            &ToolCall {
                name: "delete_file".into(),
                arguments: json!({"path": "a.txt"}),
            },
            &context,
        );
        assert!(!result.ok);
        assert_eq!(result.reason_code.as_deref(), Some("APPROVAL_REQUIRED"));
        assert!(dir.path().join("a.txt").exists(), "the file must still be there");
    }

    #[test]
    fn searching_finds_the_symbol() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::create_dir_all(dir.path().join("src")).unwrap();
        std::fs::write(dir.path().join("src/a.rs"), "fn main() {}\n").unwrap();
        let (registry, context) = registry_and_context(dir.path());
        let result = registry.dispatch(
            &ToolCall {
                name: "search_code".into(),
                arguments: json!({"pattern": "fn main"}),
            },
            &context,
        );
        assert!(result.ok);
        assert!(result.output.contains("src/a.rs:1"));
    }
}
