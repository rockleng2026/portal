//! The agent loop: think, act, verify, repeat.
//!
//! This is the part with the value (01 §8.1). The loop is deliberately boring and explicit:
//!
//! ```text
//!   task + context  ->  model  ->  tool calls  ->  policy check  ->  run  ->  results
//!         ^                                                              |
//!         +------------------ the results go back to the model ---------|
//! ```
//!
//! Three things make it an agent rather than a script:
//!
//! * **the model chooses the next step**, and the loop keeps the transcript;
//! * **the results are real** - a tool returns what actually happened, and the model reads
//!   that, so a wrong step is visible instead of being argued away;
//! * **it stops**. A budget on steps and on tokens, and a final answer that says what was
//!   done and what was not.

use crate::model::{Message, Model, Turn};
use crate::policy::LocalPolicy;
use crate::tools::{ToolContext, ToolRegistry, ToolResult};
use anyhow::Result;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::sync::Arc;

/// How the agent is configured.
#[derive(Debug, Clone)]
pub struct AgentConfig {
    /// The task the agent was given.
    pub task: String,
    /// The maximum number of model turns.
    pub max_steps: usize,
    /// The maximum number of tokens the context may grow to.
    pub max_context_tokens: usize,
    /// The system prompt.
    pub system_prompt: String,
    /// Whether the agent may change files.
    pub allow_writes: bool,
}

impl Default for AgentConfig {
    fn default() -> Self {
        Self {
            task: String::new(),
            max_steps: 40,
            max_context_tokens: 120_000,
            system_prompt: DEFAULT_SYSTEM_PROMPT.to_string(),
            allow_writes: true,
        }
    }
}

/// The system prompt.
///
/// It is short on purpose. The prompt is not the security boundary - the policy is - and a
/// long prompt is a long thing to get wrong.
pub const DEFAULT_SYSTEM_PROMPT: &str = "\
You are a digital employee that works inside a code repository.
Work in small steps: understand what the code does before you change it, then change one thing,
then check the result.
Use the tools to look at the code (list_files, read_file, search_code), to change it
(write_file, edit_file), and to find out whether your change worked (run_tests, shell_exec).
When a tool returns an error, read the error and fix the cause rather than retrying the same
call. When you are done, state what you changed and what you verified.";

/// Something that happened during the run.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "kind", rename_all = "snake_case")]
pub enum AgentEvent {
    /// A model turn.
    Model {
        step: usize,
        text: Option<String>,
        tools: Vec<String>,
    },
    /// A tool call and what it did.
    Tool {
        step: usize,
        tool: String,
        ok: bool,
        reason_code: Option<String>,
        output: String,
    },
    /// The run finished.
    Finished {
        steps: usize,
        tokens: usize,
        outcome: String,
    },
}

/// What the agent achieved.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TaskOutcome {
    /// The agent's final answer.
    pub answer: String,
    /// How many model turns it took.
    pub steps: usize,
    /// How many tokens the context grew to.
    pub tokens: usize,
    /// The files that were touched.
    pub touched: Vec<String>,
    /// Why the run stopped.
    pub stop_reason: StopReason,
}

/// Why the run stopped.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum StopReason {
    /// The model said it was done.
    Finished,
    /// The step budget ran out.
    OutOfSteps,
    /// The context budget ran out.
    OutOfContext,
    /// The model or a tool failed in a way the loop could not recover from.
    Failed,
}

/// The agent.
pub struct Agent {
    config: AgentConfig,
    model: Arc<dyn Model>,
    tools: ToolRegistry,
    policy: Arc<LocalPolicy>,
    context: Vec<Message>,
    transcript: Vec<AgentEvent>,
    touched: Vec<String>,
}

impl Agent {
    pub fn new(
        config: AgentConfig,
        model: Arc<dyn Model>,
        tools: ToolRegistry,
        policy: Arc<LocalPolicy>,
    ) -> Self {
        Self {
            config,
            model,
            tools,
            policy,
            context: Vec::new(),
            transcript: Vec::new(),
            touched: Vec::new(),
        }
    }

    /// The transcript so far.
    pub fn transcript(&self) -> &[AgentEvent] {
        &self.transcript
    }

    /// The policy the agent runs under. The tools need it, and so does the caller that
    /// builds the tool context.
    pub fn policy(&self) -> Arc<LocalPolicy> {
        self.policy.clone()
    }

    /// The files the agent touched.
    pub fn touched(&self) -> &[String] {
        &self.touched
    }

    /// Runs the task.
    pub async fn run(&mut self, tool_context: &ToolContext) -> Result<TaskOutcome> {
        self.context.push(Message::user(self.config.task.clone()));
        let catalogue = self.tools.catalogue();
        let mut steps = 0usize;

        while steps < self.config.max_steps {
            steps += 1;
            let turn = match self.model.next_turn(&self.context, &catalogue).await {
                Ok(turn) => turn,
                Err(error) => {
                    self.transcript.push(AgentEvent::Finished {
                        steps,
                        tokens: self.tokens(),
                        outcome: format!("the model failed: {error}"),
                    });
                    return Ok(TaskOutcome {
                        answer: format!("the model failed: {error}"),
                        steps,
                        tokens: self.tokens(),
                        touched: self.touched.clone(),
                        stop_reason: StopReason::Failed,
                    });
                }
            };

            match turn {
                Turn::Final(answer) => {
                    self.transcript.push(AgentEvent::Model {
                        step: steps,
                        text: Some(answer.clone()),
                        tools: Vec::new(),
                    });
                    self.transcript.push(AgentEvent::Finished {
                        steps,
                        tokens: self.tokens(),
                        outcome: answer.clone(),
                    });
                    return Ok(TaskOutcome {
                        answer,
                        steps,
                        tokens: self.tokens(),
                        touched: self.touched.clone(),
                        stop_reason: StopReason::Finished,
                    });
                }
                Turn::Tools(calls) => {
                    let names: Vec<String> = calls.iter().map(|c| c.name.clone()).collect();
                    self.transcript.push(AgentEvent::Model {
                        step: steps,
                        text: None,
                        tools: names,
                    });
                    for call in calls {
                        let result = self.tools.dispatch(&call, tool_context);
                        self.record(&result);
                    }
                    self.context.push(Message::tool(self.render_results()));
                    if self.tokens() > self.config.max_context_tokens {
                        self.transcript.push(AgentEvent::Finished {
                            steps,
                            tokens: self.tokens(),
                            outcome: "the context budget ran out".to_string(),
                        });
                        return Ok(TaskOutcome {
                            answer: "the context budget ran out".to_string(),
                            steps,
                            tokens: self.tokens(),
                            touched: self.touched.clone(),
                            stop_reason: StopReason::OutOfContext,
                        });
                    }
                }
            }
        }

        self.transcript.push(AgentEvent::Finished {
            steps,
            tokens: self.tokens(),
            outcome: "the step budget ran out".to_string(),
        });
        Ok(TaskOutcome {
            answer: "the step budget ran out before the task was finished".to_string(),
            steps,
            tokens: self.tokens(),
            touched: self.touched.clone(),
            stop_reason: StopReason::OutOfSteps,
        })
    }

    /// Records a tool result in the transcript and in the touched-files list.
    fn record(&mut self, result: &ToolResult) {
        for path in &result.touched {
            if !self.touched.contains(path) {
                self.touched.push(path.clone());
            }
        }
        self.transcript.push(AgentEvent::Tool {
            step: self.transcript.len(),
            tool: result.tool.clone(),
            ok: result.ok,
            reason_code: result.reason_code.clone(),
            output: result.output.clone(),
        });
    }

    /// The tool results, rendered for the model.
    fn render_results(&self) -> String {
        let mut out = String::new();
        for event in self.transcript.iter().rev() {
            if let AgentEvent::Tool {
                tool,
                ok,
                reason_code,
                output,
                ..
            } = event
            {
                out.push_str(&format!(
                    "<tool_result tool=\"{tool}\" ok=\"{ok}\" reason_code=\"{reason}\">\n{output}\n</tool_result>\n",
                    ok = ok,
                    reason = reason_code.as_deref().unwrap_or(""),
                    output = output,
                ));
                break;
            }
        }
        out
    }

    /// The size of the context, in tokens.
    pub fn tokens(&self) -> usize {
        self.context
            .iter()
            .map(|message| crate::estimate_tokens(&message.content))
            .sum()
    }

    /// The context as the model sees it.
    pub fn context(&self) -> &[Message] {
        &self.context
    }
}

/// Builds the context pack for a task: the workspace shape, the files that look relevant, and
/// the task itself.
///
/// The point is not to dump the repository into the prompt. It is to give the model enough to
/// start, and to make it cheap for the model to ask for more.
pub fn build_context_packs(
    workspace: &crate::workspace::Workspace,
    task: &str,
    budget_tokens: usize,
) -> Vec<String> {
    let mut packs = Vec::new();
    let tree = workspace.tree(500).unwrap_or_default();
    packs.push(format!("# Workspace\n\n{tree}"));

    // The files whose name or path mentions something from the task are the likely candidates.
    let mut keywords: Vec<String> = Vec::new();
    for word in task.split_whitespace() {
        let cleaned: String = word
            .chars()
            .filter(|c| c.is_alphanumeric() || *c == '_' || *c == '-')
            .collect();
        if cleaned.len() >= 3 {
            keywords.push(cleaned.to_lowercase());
        }
    }
    let files = workspace.list_files().unwrap_or_default();
    let mut used = crate::estimate_tokens(&packs[0]);
    for file in files {
        if keywords.is_empty() {
            break;
        }
        let path_lower = file.path.to_lowercase();
        if !keywords.iter().any(|keyword| path_lower.contains(keyword)) {
            continue;
        }
        let Ok(content) = workspace.read_file(&file.path) else {
            continue;
        };
        let tokens = crate::estimate_tokens(&content);
        if used + tokens > budget_tokens {
            continue;
        }
        used += tokens;
        packs.push(format!("# File: {}\n\n```\n{}\n```", file.path, content));
    }
    packs
}

/// The tool catalogue, as JSON, for a model that wants it.
pub fn catalogue(tools: &ToolRegistry) -> Value {
    tools.catalogue()
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::model::ScriptedModel;
    use crate::policy::{AutonomyLevel, LocalPolicy};
    use crate::tools::{ToolCall, ToolRegistry};
    use serde_json::json;

    fn context(dir: &std::path::Path) -> ToolContext {
        let workspace = Arc::new(crate::workspace::Workspace::new(dir).unwrap());
        let policy = Arc::new(LocalPolicy::new(
            AutonomyLevel::L3,
            vec!["cap:fs.read".to_string(), "cap:fs.write".to_string()],
            vec![dir.to_path_buf()],
        ));
        ToolContext {
            workspace,
            policy,
            cwd: dir.to_path_buf(),
            now_epoch: 100,
            approval: None,
        }
    }

    /// A context whose policy grants nothing.
    fn closed_context(dir: &std::path::Path) -> ToolContext {
        let mut ctx = context(dir);
        ctx.policy = Arc::new(LocalPolicy::empty());
        ctx
    }

    #[tokio::test]
    async fn the_loop_runs_a_tool_and_finishes() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("a.txt"), "hello\n").unwrap();

        let model = Arc::new(ScriptedModel::once(ToolCall {
            name: "read_file".into(),
            arguments: json!({"path": "a.txt"}),
        }));
        let mut tools = ToolRegistry::new();
        crate::tools::fs_ops::register(&mut tools);
        let mut agent = Agent::new(
            AgentConfig {
                task: "read a.txt".into(),
                ..Default::default()
            },
            model.clone(),
            tools,
            Arc::new(LocalPolicy::empty()),
        );

        let outcome = agent.run(&context(dir.path())).await.unwrap();
        assert_eq!(outcome.stop_reason, StopReason::Finished);
        assert_eq!(outcome.steps, 2, "one tool turn and one final answer");
        assert_eq!(outcome.answer, "done");
        assert_eq!(model.calls.load(std::sync::atomic::Ordering::SeqCst), 2);
    }

    #[tokio::test]
    async fn a_refused_tool_stops_the_agent_from_acting() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("a.txt"), "hello\n").unwrap();

        let model = Arc::new(ScriptedModel::once(ToolCall {
            name: "read_file".into(),
            arguments: json!({"path": "a.txt"}),
        }));
        let mut tools = ToolRegistry::new();
        crate::tools::fs_ops::register(&mut tools);
        // The policy grants nothing, so the call is refused.
        let mut agent = Agent::new(
            AgentConfig {
                task: "read a.txt".into(),
                ..Default::default()
            },
            model,
            tools,
            Arc::new(LocalPolicy::empty()),
        );

        let outcome = agent.run(&closed_context(dir.path())).await.unwrap();
        assert_eq!(outcome.stop_reason, StopReason::Finished);
        // The refusal is in the transcript, and nothing was read.
        let has_refusal = agent.transcript().iter().any(|event| {
            matches!(event, AgentEvent::Tool { ok: false, reason_code: Some(code), .. } if code == "CAPABILITY_NOT_GRANTED")
        });
        assert!(has_refusal, "the refusal must be recorded: {:#?}", agent.transcript());
    }

    #[tokio::test]
    async fn the_step_budget_stops_a_runaway_agent() {
        let dir = tempfile::tempdir().unwrap();
        let model = Arc::new(ScriptedModel::new(vec![
            Ok(Turn::Tools(vec![ToolCall {
                name: "list_files".into(),
                arguments: json!({}),
            }])),
            Ok(Turn::Tools(vec![ToolCall {
                name: "list_files".into(),
                arguments: json!({}),
            }])),
            Ok(Turn::Tools(vec![ToolCall {
                name: "list_files".into(),
                arguments: json!({}),
            }])),
        ]));
        let mut tools = ToolRegistry::new();
        crate::tools::fs_ops::register(&mut tools);
        let mut agent = Agent::new(
            AgentConfig {
                task: "loop".into(),
                max_steps: 2,
                ..Default::default()
            },
            model,
            tools,
            Arc::new(LocalPolicy::empty()),
        );

        let outcome = agent.run(&context(dir.path())).await.unwrap();
        assert_eq!(outcome.stop_reason, StopReason::OutOfSteps);
        assert_eq!(outcome.steps, 2);
    }

    #[test]
    fn the_context_pack_contains_the_tree_and_the_relevant_files() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::create_dir_all(dir.path().join("src")).unwrap();
        std::fs::write(dir.path().join("src/login.rs"), "fn login() {}").unwrap();
        std::fs::write(dir.path().join("README.md"), "hello").unwrap();
        let workspace = crate::workspace::Workspace::new(dir.path()).unwrap();
        let packs = build_context_packs(&workspace, "fix the login function", 10_000);
        assert!(packs[0].contains("src/login.rs"));
        assert!(packs.iter().any(|pack| pack.contains("fn login")));
    }
}
