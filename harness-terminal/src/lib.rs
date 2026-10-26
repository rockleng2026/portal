//! # harness-agent
//!
//! The terminal agent runtime (01 §11.1, 01 §8.1).
//!
//! It does what a coding agent does, and it does it inside the harness' governance:
//!
//! 1. **collect context** - walk the workspace, read the files that matter, search for the
//!    symbols the task is about, and pack all of it into a budget;
//! 2. **act** - edit files, run tests, run shell commands, through a tool registry;
//! 3. **verify** - look at what the tool actually produced (compiler errors, test output,
//!    the diff) and feed that back;
//! 4. **repeat** - until the task is done, the budget is spent, or the agent gives up.
//!
//! Every tool call goes through [`policy::LocalPolicy`] first. The platform may be wrong and
//! the edge may be compromised; the agent still refuses what it was not authorised to do
//! (red-team R-01). The agent is a tool user, not an authority.

pub mod agent;
pub mod cli;
pub mod grant;
pub mod mcp;
pub mod model;
pub mod policy;
pub mod skills;
pub mod tools;
pub mod workspace;

pub use agent::{Agent, AgentConfig, AgentEvent, TaskOutcome};
pub use policy::{ApprovalToken, LocalPolicy, PolicyDecision};
pub use tools::{Tool, ToolCall, ToolRegistry, ToolResult};

/// Rough token estimate.
///
/// Deliberately over-counting: a context pack that thinks it is smaller than it is will
/// overflow the model's window, and the failure mode of that is a confusing truncation in
/// the middle of a tool call.
pub fn estimate_tokens(text: &str) -> usize {
    // ~4 characters per token is the usual rule of thumb for English and code; non-ASCII
    // (especially CJK) is denser, so count it more.
    let mut ascii = 0usize;
    let mut wide = 0usize;
    for ch in text.chars() {
        if ch.is_ascii() {
            ascii += 1;
        } else {
            wide += 1;
        }
    }
    ascii / 4 + wide
}
