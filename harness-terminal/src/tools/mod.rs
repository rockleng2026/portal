//! The tools: the agent's hands.
//!
//! A tool is a capability with a name, a schema the model can see, and a function that does
//! one thing and reports exactly what happened. Three properties matter:
//!
//! * **the result is the truth** - a tool returns the compiler output, the test output, the
//!   diff. The agent verifies against that, not against what it expected;
//! * **a failure is a result, not an exception** - a test that fails is information the agent
//!   needs, so it comes back as a `ToolResult` with `ok = false`, not as a panic;
//! * **every call is checked by the policy first** - the tool does not decide whether it may
//!   run.

pub mod capabilities;
pub mod exec;
pub mod fs_ops;

use crate::policy::{ApprovalToken, AutonomyLevel, LocalPolicy, PolicyDecision};
use crate::workspace::Workspace;
use anyhow::{anyhow, Context, Result};
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};
use std::collections::BTreeMap;
use std::path::PathBuf;
use std::sync::Arc;

/// A call the model wants to make.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToolCall {
    /// The tool name, e.g. `read_file`.
    pub name: String,
    /// The arguments, as the model produced them.
    #[serde(default)]
    pub arguments: Value,
}

// `serde_json::Value` is `PartialEq` but not `Eq`, so the equality is spelled out here. Two
// calls are the same when they name the same tool and carry the same arguments - which is
// exactly what the idempotency check needs.
impl PartialEq for ToolCall {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name && self.arguments == other.arguments
    }
}

impl Eq for ToolCall {}

/// What a tool did.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToolResult {
    /// The tool that ran.
    pub tool: String,
    /// Whether it did what was asked.
    pub ok: bool,
    /// The output, in the shape the model should read.
    pub output: String,
    /// A machine-readable reason code for a refusal or a failure.
    #[serde(default)]
    pub reason_code: Option<String>,
    /// Files the tool touched, for the diff and the transcript.
    #[serde(default)]
    pub touched: Vec<String>,
}

impl ToolResult {
    pub fn ok(tool: &str, output: impl Into<String>) -> Self {
        Self {
            tool: tool.to_string(),
            ok: true,
            output: output.into(),
            reason_code: None,
            touched: Vec::new(),
        }
    }

    pub fn failure(tool: &str, reason_code: &str, output: impl Into<String>) -> Self {
        Self {
            tool: tool.to_string(),
            ok: false,
            output: output.into(),
            reason_code: Some(reason_code.to_string()),
            touched: Vec::new(),
        }
    }
}

/// What a tool needs before it runs.
pub struct ToolContext {
    pub workspace: Arc<Workspace>,
    pub policy: Arc<LocalPolicy>,
    /// The working directory for shell commands.
    pub cwd: PathBuf,
    /// Unix seconds, for approval expiry.
    pub now_epoch: u64,
    /// The approval that came with the call, if any.
    pub approval: Option<ApprovalToken>,
}

/// One tool.
pub trait Tool: Send + Sync {
    /// The name the model calls.
    fn name(&self) -> &str;

    /// What the tool does, in one line - this is what the model reads to decide.
    fn description(&self) -> &str;

    /// The JSON schema of the arguments.
    fn schema(&self) -> Value;

    /// The capability the tool needs, if any.
    fn capability(&self) -> Option<&'static str> {
        None
    }

    /// The lowest autonomy level at which this tool may run.
    fn min_level(&self) -> AutonomyLevel {
        AutonomyLevel::L1
    }

    /// Whether this tool needs a human approval.
    fn requires_approval(&self) -> bool {
        false
    }

    /// The path the tool touches, if any. Used by the policy's root check.
    ///
    /// The path is resolved against the workspace here, not in the tool, so that the policy
    /// compares two absolute, normalised paths - a relative path and an absolute root never
    /// match, and a tool that "forgot" to resolve it would silently escape the check.
    fn target_path(&self, context: &ToolContext, arguments: &Value) -> Option<PathBuf> {
        arguments
            .get("path")
            .and_then(Value::as_str)
            .and_then(|raw| context.workspace.resolve(raw).ok())
    }

    /// Runs the tool.
    fn run(&self, context: &ToolContext, arguments: &Value) -> Result<ToolResult>;
}

/// The tools the agent has.
#[derive(Clone, Default)]
pub struct ToolRegistry {
    tools: BTreeMap<String, Arc<dyn Tool>>,
}

impl ToolRegistry {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn register(&mut self, tool: Arc<dyn Tool>) {
        self.tools.insert(tool.name().to_string(), tool);
    }

    pub fn get(&self, name: &str) -> Option<Arc<dyn Tool>> {
        self.tools.get(name).cloned()
    }

    pub fn names(&self) -> Vec<String> {
        self.tools.keys().cloned().collect()
    }

    pub fn is_empty(&self) -> bool {
        self.tools.is_empty()
    }

    /// The tool catalogue the model sees.
    pub fn catalogue(&self) -> Value {
        let mut tools = Vec::new();
        for tool in self.tools.values() {
            tools.push(json!({
                "name": tool.name(),
                "description": tool.description(),
                "input_schema": tool.schema(),
                "requires_approval": tool.requires_approval(),
            }));
        }
        json!({ "tools": tools })
    }

    /// Runs a call, after checking it against the policy.
    ///
    /// The check happens here, not inside the tools, so that no tool can forget it and every
    /// refusal is recorded the same way.
    pub fn dispatch(&self, call: &ToolCall, context: &ToolContext) -> ToolResult {
        let Some(tool) = self.get(&call.name) else {
            return ToolResult::failure(
                &call.name,
                "UNKNOWN_TOOL",
                format!("there is no tool called {}", call.name),
            );
        };
        let target = tool.target_path(context, &call.arguments);
        let decision: PolicyDecision = context.policy.check(
            &call.name,
            tool.capability(),
            target.as_deref(),
            context.approval.as_ref(),
            tool.min_level(),
            tool.requires_approval(),
            context.now_epoch,
        );
        if !decision.allowed {
            return ToolResult::failure(&call.name, decision.reason_code, decision.reason);
        }
        match tool.run(context, &call.arguments) {
            Ok(result) => result,
            Err(error) => ToolResult::failure(&call.name, "TOOL_ERROR", error.to_string()),
        }
    }
}

// ------------------------------------------------------------------ arguments

/// Reads a required string argument.
pub fn arg_str(arguments: &Value, name: &str) -> Result<String> {
    arguments
        .get(name)
        .and_then(Value::as_str)
        .map(str::to_string)
        .ok_or_else(|| anyhow!("missing argument '{name}'"))
}

/// Reads an optional string argument.
pub fn opt_str(arguments: &Value, name: &str) -> Option<String> {
    arguments
        .get(name)
        .and_then(Value::as_str)
        .map(str::to_string)
}

/// Reads an optional integer argument.
pub fn opt_i64(arguments: &Value, name: &str) -> Option<i64> {
    arguments.get(name).and_then(Value::as_i64)
}

/// Reads an optional boolean argument.
pub fn opt_bool(arguments: &Value, name: &str) -> bool {
    arguments
        .get(name)
        .and_then(Value::as_bool)
        .unwrap_or(false)
}

/// The path an argument names, resolved against the workspace.
pub fn arg_path(context: &ToolContext, arguments: &Value, name: &str) -> Result<PathBuf> {
    let raw = arg_str(arguments, name)?;
    context
        .workspace
        .resolve(&raw)
        .with_context(|| format!("cannot resolve path '{raw}'"))
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::Arc;

    struct Echo;

    impl Tool for Echo {
        fn name(&self) -> &str {
            "echo"
        }
        fn description(&self) -> &str {
            "echo the arguments back"
        }
        fn schema(&self) -> Value {
            json!({"type": "object", "properties": {"text": {"type": "string"}}})
        }
        fn capability(&self) -> Option<&'static str> {
            Some("cap:echo")
        }
        fn run(&self, _context: &ToolContext, arguments: &Value) -> Result<ToolResult> {
            Ok(ToolResult::ok("echo", arg_str(arguments, "text")?))
        }
    }

    fn context() -> ToolContext {
        let dir = tempfile::tempdir().unwrap();
        let workspace = Arc::new(Workspace::new(dir.path()).unwrap());
        ToolContext {
            workspace,
            policy: Arc::new(LocalPolicy::new(
                AutonomyLevel::L2,
                vec!["cap:echo".to_string()],
                vec![dir.path().to_path_buf()],
            )),
            cwd: dir.path().to_path_buf(),
            now_epoch: 100,
            approval: None,
        }
    }

    #[test]
    fn an_unknown_tool_is_reported_not_ignored() {
        let registry = ToolRegistry::new();
        let result = registry.dispatch(
            &ToolCall {
                name: "nope".into(),
                arguments: json!({}),
            },
            &context(),
        );
        assert!(!result.ok);
        assert_eq!(result.reason_code.as_deref(), Some("UNKNOWN_TOOL"));
    }

    #[test]
    fn a_tool_without_the_capability_is_refused() {
        let mut registry = ToolRegistry::new();
        registry.register(Arc::new(Echo));
        let mut ctx = context();
        // A context whose policy grants nothing.
        ctx.policy = Arc::new(LocalPolicy::empty());
        let result = registry.dispatch(
            &ToolCall {
                name: "echo".into(),
                arguments: json!({"text": "hi"}),
            },
            &ctx,
        );
        assert!(!result.ok);
        assert_eq!(result.reason_code.as_deref(), Some("CAPABILITY_NOT_GRANTED"));
    }

    #[test]
    fn a_tool_with_the_capability_runs() {
        let mut registry = ToolRegistry::new();
        registry.register(Arc::new(Echo));
        let mut ctx = context();
        let policy = LocalPolicy::new(
            AutonomyLevel::L2,
            vec!["cap:echo".to_string()],
            vec![ctx.cwd.clone()],
        );
        ctx.policy = Arc::new(policy);
        let result = registry.dispatch(
            &ToolCall {
                name: "echo".into(),
                arguments: json!({"text": "hi"}),
            },
            &ctx,
        );
        assert!(result.ok, "{}", result.output);
        assert_eq!(result.output, "hi");
    }
}
