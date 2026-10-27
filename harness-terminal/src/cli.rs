//! The command line.
//!
//! The agent is used in two ways: interactively (a person asks for something and watches),
//! and unattended (a digital employee runs a task and reports what it did). Both go through
//! the same loop; only the reporting differs.

use crate::agent::{Agent, AgentConfig, AgentEvent, TaskOutcome};
use crate::model::{AnthropicModel, Message, Model, OpenAiModel, ScriptedModel, Turn};
use crate::policy::{AutonomyLevel, LocalPolicy};
use crate::grant;
use crate::skills::SkillLibrary;
use crate::tools::{ToolRegistry, ToolResult};
use crate::workspace::Workspace;
use anyhow::{anyhow, Result};
use clap::{Parser, Subcommand};
use serde_json::{json, Value};
use std::io::Write;
use std::path::PathBuf;
use std::sync::Arc;

#[derive(Parser, Debug)]
#[command(
    name = "harness-agent",
    version,
    about = "The harness terminal agent: collect context, act with tools, verify, repeat."
)]
struct Cli {
    #[command(subcommand)]
    command: Command,
}

#[derive(Subcommand, Debug)]
enum Command {
    /// Run a task in the workspace.
    Run(RunArgs),
    /// Show what the agent would do: the workspace, the tools, the skills.
    Inspect(InspectArgs),
    /// Print the tool catalogue as JSON.
    Tools,
    /// Replay a task from a script, without a model. Used to test the loop.
    Replay(ReplayArgs),
    /// Serve the console: pick up requests from the platform and answer them.
    Serve(ServeArgs),
}

#[derive(Parser, Debug)]
struct RunArgs {
    /// The task, in words.
    task: String,
    /// The workspace root.
    #[arg(long, default_value = ".")]
    workspace: PathBuf,
    /// The model to use: `anthropic`, `openai` or `scripted`.
    #[arg(long, default_value = "anthropic")]
    provider: String,
    /// The model name.
    #[arg(long, default_value = "claude-sonnet-4-5")]
    model: String,
    /// The API key. Read from HARNESS_MODEL_API_KEY when not given.
    #[arg(long)]
    api_key: Option<String>,
    /// The base URL of the model API.
    #[arg(long)]
    base_url: Option<String>,
    /// The maximum number of model turns.
    #[arg(long, default_value_t = 40)]
    max_steps: usize,
    /// The autonomy level the agent runs at.
    #[arg(long, default_value_t = 2)]
    autonomy: u8,
    /// The directories the agent may touch. Defaults to the workspace.
    #[arg(long)]
    allowed_root: Vec<PathBuf>,
    /// The directory with the skills.
    #[arg(long)]
    skills: Option<PathBuf>,
    /// The directory with the device identity; the grant is read from here.
    #[arg(long)]
    identity: Option<PathBuf>,
    /// Write the transcript as JSON lines to this file.
    #[arg(long)]
    transcript: Option<PathBuf>,
}

#[derive(Parser, Debug)]
struct InspectArgs {
    /// The workspace root.
    #[arg(long, default_value = ".")]
    workspace: PathBuf,
    /// The directory with the skills.
    #[arg(long)]
    skills: Option<PathBuf>,
}

#[derive(Parser, Debug)]
struct ServeArgs {
    /// The workspace the agent works in.
    #[arg(long, default_value = ".")]
    workspace: PathBuf,
    /// The directory with the device identity; the grant and the platform parameters come
    /// from here.
    #[arg(long)]
    identity: Option<PathBuf>,
    /// The configuration file of the terminal (platform.url, client.id, secret).
    #[arg(long)]
    config: Option<PathBuf>,
    /// The model to use: `anthropic` or `openai`.
    #[arg(long, default_value = "anthropic")]
    provider: String,
    /// The model name.
    #[arg(long, default_value = "claude-sonnet-4-5")]
    model: String,
    /// The API key. Read from HARNESS_MODEL_API_KEY when not given.
    #[arg(long)]
    api_key: Option<String>,
    /// The base URL of the model API.
    #[arg(long)]
    base_url: Option<String>,
    /// The maximum number of model turns per request.
    #[arg(long, default_value_t = 40)]
    max_steps: usize,
    /// How often to look for new work, in seconds.
    #[arg(long, default_value_t = 2)]
    poll_seconds: u64,
    /// Stop after this many requests (0 = never stop).
    #[arg(long, default_value_t = 0)]
    max_tasks: usize,
}

#[derive(Parser, Debug)]
struct ReplayArgs {
    /// A JSON file with the model's turns.
    #[arg(long)]
    script: PathBuf,
    /// The workspace root.
    #[arg(long, default_value = ".")]
    workspace: PathBuf,
    /// The directory with the device identity; the grant is read from here.
    #[arg(long)]
    identity: Option<PathBuf>,
    /// Write the transcript as JSON lines to this file.
    #[arg(long)]
    transcript: Option<PathBuf>,
}

/// The entry point. The binary calls this; it is async because the model and the tools are.
pub async fn main() -> Result<()> {
    if std::env::var("RUST_LOG").is_err() {
        std::env::set_var("RUST_LOG", "harness_agent=info");
    }
    tracing_subscriber::fmt()
        .with_env_filter(tracing_subscriber::EnvFilter::from_default_env())
        .init();

    let cli = Cli::parse();
    let result = match cli.command {
        Command::Run(args) => run(args).await,
        Command::Inspect(args) => inspect(args),
        Command::Tools => {
            let mut registry = ToolRegistry::new();
            crate::tools::fs_ops::register(&mut registry);
            crate::tools::exec::register(&mut registry);
            let catalogue = serde_json::to_string_pretty(&registry.catalogue())?;
            println!("{catalogue}");
            Ok(())
        }
        Command::Replay(args) => replay(args).await,
        Command::Serve(args) => serve(args).await,
    };
    result
}

/// The capabilities an agent has when it runs standalone, without a platform.
const STANDALONE_CAPABILITIES: &[&str] = crate::tools::capabilities::ALL;

/// Builds the workspace, the tools and the policy.
///
/// The authority is the platform. When an identity directory is given, the grant the shell
/// fetched is the policy - capabilities, level and roots all come from it, and without a grant
/// the agent may do nothing. Without an identity directory the agent runs standalone with the
/// capabilities below, which is the "somebody is sitting in front of it" case, not the
/// "digital employee" case.
fn build_environment(
    workspace_root: &PathBuf,
    autonomy: u8,
    allowed_roots: &[PathBuf],
    identity: Option<&PathBuf>,
) -> Result<(Arc<Workspace>, ToolRegistry, Arc<LocalPolicy>, String)> {
    let workspace = Workspace::new(workspace_root)?;
    let roots: Vec<PathBuf> = if allowed_roots.is_empty() {
        vec![workspace.root().to_path_buf()]
    } else {
        allowed_roots.to_vec()
    };
    // The command line may only narrow the grant's roots, never widen them.
    let narrowed_roots: Vec<PathBuf> = roots
        .iter()
        .map(|root| crate::workspace::normalize(root))
        .collect();
    let (policy, authority) = match identity {
        Some(directory) => {
            let (policy, grant) =
                grant::policy_for_machine_narrowed(directory, &narrowed_roots);
            match grant {
                Some(grant) => (
                    policy,
                    format!(
                        "platform grant for terminal {} (L{}, {} capabilities)",
                        grant.terminal_id,
                        grant.autonomy_level,
                        grant.capabilities.len()
                    ),
                ),
                None => (
                    LocalPolicy::empty(),
                    "no grant: this agent may do nothing until the shell fetches one".to_string(),
                ),
            }
        }
        None => (
            LocalPolicy::new(
                AutonomyLevel::from_u8(autonomy),
                STANDALONE_CAPABILITIES.iter().map(|c| c.to_string()),
                roots,
            ),
            "standalone: no platform grant, the command line decides".to_string(),
        ),
    };
    let mut registry = ToolRegistry::new();
    crate::tools::fs_ops::register(&mut registry);
    crate::tools::exec::register(&mut registry);
    Ok((Arc::new(workspace), registry, Arc::new(policy), authority))
}

/// Runs a task.
async fn run(args: RunArgs) -> Result<()> {
    let (workspace, tools, policy, authority) = build_environment(
        &args.workspace,
        args.autonomy,
        &args.allowed_root,
        args.identity.as_ref(),
    )?;
    println!("authority: {authority}");

    let api_key = args
        .api_key
        .clone()
        .or_else(|| std::env::var("HARNESS_MODEL_API_KEY").ok())
        .ok_or_else(|| {
            anyhow!("no API key: pass --api-key or set HARNESS_MODEL_API_KEY")
        })?;

    let model: Arc<dyn Model> = match args.provider.as_str() {
        "anthropic" => {
            let mut model = AnthropicModel::new(api_key, args.model.clone());
            if let Some(base_url) = &args.base_url {
                model = model.with_base_url(base_url.clone());
            }
            Arc::new(model)
        }
        "openai" => {
            let mut model = OpenAiModel::new(api_key, args.model.clone());
            if let Some(base_url) = &args.base_url {
                model = model.with_base_url(base_url.clone());
            }
            Arc::new(model)
        }
        other => return Err(anyhow!("unknown provider '{other}'")),
    };

    let skills = match &args.skills {
        Some(path) => SkillLibrary::load_from(path)?,
        None => SkillLibrary::new(),
    };

    let mut system = crate::agent::DEFAULT_SYSTEM_PROMPT.to_string();
    let skill_text = skills.render(&args.task, 3);
    if !skill_text.is_empty() {
        system.push_str("\n\n");
        system.push_str(&skill_text);
    }

    let mut config = AgentConfig {
        task: args.task.clone(),
        max_steps: args.max_steps,
        system_prompt: system,
        ..Default::default()
    };
    // The context pack is the first thing the model sees.
    let packs = crate::agent::build_context_packs(
        &workspace,
        &config.task,
        config.max_context_tokens / 2,
    );
    config.task = format!(
        "{}\n\n# Context\n\n{}",
        config.task,
        packs.join("\n")
    );

    let mut agent = Agent::new(config, model, tools, policy);
    let tool_context = crate::tools::ToolContext {
        workspace: workspace.clone(),
        policy: agent.policy(),
        cwd: workspace.root().to_path_buf(),
        now_epoch: now_epoch(),
        approval: None,
    };

    let outcome = agent.run(&tool_context).await?;
    let transcript = agent.transcript().to_vec();
    report(&outcome, &transcript, args.transcript.as_deref())?;
    Ok(())
}

/// Replays a scripted run, without a model.
async fn replay(args: ReplayArgs) -> Result<()> {
    let script = std::fs::read_to_string(&args.script)?;
    let turns: Vec<Result<Turn, String>> = serde_json::from_str::<Vec<Value>>(&script)?
        .into_iter()
        .map(|turn| {
            if let Some(final_text) = turn.get("final").and_then(|v| v.as_str()) {
                Ok(Turn::Final(final_text.to_string()))
            } else {
                let calls = turn
                    .get("tools")
                    .and_then(|v| v.as_array())
                    .map(|calls| {
                        calls
                            .iter()
                            .map(|call| crate::tools::ToolCall {
                                name: call
                                    .get("name")
                                    .and_then(|v| v.as_str())
                                    .unwrap_or_default()
                                    .to_string(),
                                arguments: call.get("arguments").cloned().unwrap_or(json!({})),
                            })
                            .collect()
                    })
                    .unwrap_or_default();
                Ok(Turn::Tools(calls))
            }
        })
        .collect();

    let (workspace, tools, policy, authority) = build_environment(
        &args.workspace,
        2,
        &[],
        args.identity.as_ref(),
    )?;
    println!("authority: {authority}");
    let mut agent = Agent::new(
        AgentConfig {
            task: "replay".to_string(),
            ..Default::default()
        },
        Arc::new(ScriptedModel::new(turns)),
        tools,
        policy.clone(),
    );
    let tool_context = crate::tools::ToolContext {
        workspace,
        policy,
        cwd: args.workspace.clone(),
        now_epoch: now_epoch(),
        approval: None,
    };
    let outcome = agent.run(&tool_context).await?;
    let transcript = agent.transcript().to_vec();
    report(&outcome, &transcript, args.transcript.as_deref())?;
    Ok(())
}

/// Serves the console: takes requests from the platform, answers them.
///
/// The loop is the whole point of the terminal being a *digital employee* rather than a
/// tool: somebody asks a question in the console, and the machine that is bound to that
/// digital employee answers it - under its own policy, with its own grant.
async fn serve(args: ServeArgs) -> Result<()> {
    // --identity is the directory with the device identity and the grant; the shell's
    // configuration file (platform.url, client.id, secret) sits next to it.
    let identity_dir = args.identity.clone().unwrap_or_else(|| {
        crate::platform::PlatformConfig::default_path()
            .parent()
            .map(|p| p.to_path_buf())
            .unwrap_or_default()
    });
    let config_path = args.config.clone().unwrap_or_else(|| {
        identity_dir.join("terminal.properties")
    });
    let platform_config = crate::platform::PlatformConfig::read(&config_path)?;
    if platform_config.terminal_id.is_empty() {
        return Err(anyhow::anyhow!(
            "the configuration {} has no terminal.id - run 'harness-terminal hello' first",
            config_path.display()
        ));
    }
    let platform = Arc::new(crate::platform::PlatformClient::new(&platform_config)?);

    let (workspace, tools, policy, authority) = build_environment(
        &args.workspace,
        2,
        &[],
        Some(&identity_dir),
    )?;
    println!("authority: {authority}");
    println!(
        "serving terminal {} on {}",
        platform_config.terminal_id, platform_config.base_url
    );

    let api_key = args
        .api_key
        .clone()
        .or_else(|| std::env::var("HARNESS_MODEL_API_KEY").ok());
    let brain: Brain = match (args.provider.as_str(), api_key) {
        ("anthropic", Some(key)) => {
            let mut model = AnthropicModel::new(key, args.model.clone());
            if let Some(base_url) = &args.base_url {
                model = model.with_base_url(base_url.clone());
            }
            Brain::Model(Arc::new(model))
        }
        ("openai", Some(key)) => {
            let mut model = OpenAiModel::new(key, args.model.clone());
            if let Some(base_url) = &args.base_url {
                model = model.with_base_url(base_url.clone());
            }
            Brain::Model(Arc::new(model))
        }
        (_, None) => {
            println!(
                "no HARNESS_MODEL_API_KEY: a request is executed as a command, not answered by a model"
            );
            Brain::Command
        }
        (other, _) => return Err(anyhow::anyhow!("unknown provider '{other}'")),
    };

    let mut served = 0usize;
    let mut announced = false;
    let mut since_heartbeat = 0u64;
    loop {
        // The heartbeat is the device's liveness. Whoever runs on the machine says it - the
        // agent is usually the thing that stays up, so it says it.
        since_heartbeat += 1;
        if since_heartbeat * args.poll_seconds >= HEARTBEAT_INTERVAL_SECONDS {
            since_heartbeat = 0;
            match platform.heartbeat(&platform_config.terminal_id).await {
                Ok(status) => {
                    if status == "revoked" {
                        println!("the terminal was revoked; stopping");
                        return Ok(());
                    }
                }
                Err(error) => eprintln!("heartbeat failed: {error:#}"),
            }
        }

        let task = match platform.next_task(&platform_config.terminal_id).await {
            Ok(task) => task,
            Err(error) => {
                // The whole chain, not just the top line: "the platform did not answer" on its
                // own says nothing about why.
                eprintln!("cannot reach the platform: {error:#}");
                tokio::time::sleep(std::time::Duration::from_secs(args.poll_seconds)).await;
                continue;
            }
        };
        let Some(task) = task else {
            if !announced {
                announced = true;
                println!(
                    "waiting for requests. Open {} and use 终端 -> 对话.",
                    console_url(&platform_config.base_url)
                );
            }
            tokio::time::sleep(std::time::Duration::from_secs(args.poll_seconds)).await;
            continue;
        };
        let task_id = task
            .get("taskId")
            .and_then(Value::as_str)
            .unwrap_or_default()
            .to_string();
        let prompt = task
            .get("prompt")
            .and_then(Value::as_str)
            .unwrap_or_default()
            .to_string();
        println!("--- task {task_id}: {prompt}");

        let outcome = answer(&prompt, &args, &brain, workspace.clone(), tools.clone(), policy.clone()).await;
        let result = match outcome {
            Ok((answer, transcript, touched)) => {
                crate::platform::task_result(&answer, transcript, touched, None)
            }
            Err(error) => crate::platform::task_result(
                &format!("the request failed: {error}"),
                json!({}),
                Vec::new(),
                Some(error.to_string()),
            ),
        };
        if let Err(error) = platform.complete_task(&task_id, &result).await {
            eprintln!("cannot post the answer: {error}");
        } else {
            let first = result
                .get("answer")
                .and_then(Value::as_str)
                .unwrap_or("")
                .lines()
                .next()
                .unwrap_or("")
                .to_string();
            println!("--- answered: {first}");
        }
        served += 1;
        if args.max_tasks > 0 && served >= args.max_tasks {
            break;
        }
    }
    Ok(())
}

/// What answers a request: a language model, or the command pass-through.
enum Brain {
    Model(Arc<dyn Model>),
    /// No model is configured, so the request is run as a command. The terminal's policy
    /// decides whether it may run - the same policy as everything else.
    Command,
}

/// Answers one request with the agent loop.
async fn answer(
    prompt: &str,
    args: &ServeArgs,
    brain: &Brain,
    workspace: Arc<Workspace>,
    tools: ToolRegistry,
    policy: Arc<LocalPolicy>,
) -> Result<(String, Value, Vec<String>)> {
    if matches!(brain, Brain::Command) {
        let context = crate::tools::ToolContext {
            workspace: workspace.clone(),
            policy: policy.clone(),
            cwd: workspace_root(&args.workspace),
            now_epoch: now_epoch(),
            approval: None,
        };
        let call = crate::tools::ToolCall {
            name: "shell_exec".to_string(),
            arguments: json!({"command": prompt}),
        };
        let result = tools.dispatch(&call, &context);
        if result.ok {
            Ok((result.output.clone(), json!({"mode": "command"}), result.touched.clone()))
        } else {
            Err(anyhow::anyhow!(
                "{}: {}",
                result.reason_code.clone().unwrap_or_else(|| "REFUSED".to_string()),
                result.output
            ))
        }
    } else {
    let model = match brain {
        Brain::Model(model) => model.clone(),
        Brain::Command => unreachable!("handled above"),
    };
    let mut agent = Agent::new(
        AgentConfig {
            task: prompt.to_string(),
            max_steps: args.max_steps,
            ..Default::default()
        },
        model.clone(),
        tools,
        policy.clone(),
    );
    let tool_context = crate::tools::ToolContext {
        workspace,
        policy,
        cwd: workspace_root(&args.workspace),
        now_epoch: now_epoch(),
        approval: None,
    };
    let outcome = agent.run(&tool_context).await?;
    let transcript = serde_json::to_value(agent.transcript())?;
    Ok((outcome.answer, transcript, outcome.touched))
    }
}

/// How often the terminal says it is alive (03 §3.1: heartbeat 10s).
const HEARTBEAT_INTERVAL_SECONDS: u64 = 10;

/// The console URL for the platform this terminal serves.
fn console_url(base_url: &str) -> String {
    format!("{}/console/index.html", base_url.trim_end_matches('/'))
}

fn workspace_root(path: &std::path::Path) -> std::path::PathBuf {
    crate::workspace::normalize(path)
}

/// Shows what the agent sees.
fn inspect(args: InspectArgs) -> Result<()> {
    let workspace = Workspace::new(&args.workspace)?;
    println!("# Workspace: {}", workspace.root().display());
    println!("{}", workspace.tree(200)?);
    println!("\n# Languages known: {}", crate::workspace::supported_language_count());
    if let Some(path) = &args.skills {
        let library = SkillLibrary::load_from(path)?;
        println!("\n# Skills ({}):", library.len());
        for name in library.names() {
            let skill = library.get(&name).expect("skill");
            println!("  {name}: {}", skill.description);
        }
    }
    Ok(())
}

/// Prints what happened.
fn report(
    outcome: &TaskOutcome,
    transcript: &[AgentEvent],
    transcript_file: Option<&std::path::Path>,
) -> Result<()> {
    println!("\n=== outcome ===");
    println!("steps: {}", outcome.steps);
    println!("tokens: {}", outcome.tokens);
    println!("stop reason: {:?}", outcome.stop_reason);
    if !outcome.touched.is_empty() {
        println!("files touched:");
        for path in &outcome.touched {
            println!("  {path}");
        }
    }
    println!("\n=== answer ===");
    println!("{}", outcome.answer);

    if let Some(path) = transcript_file {
        let mut file = std::fs::File::create(path)?;
        for event in transcript {
            writeln!(file, "{}", serde_json::to_string(event)?)?;
        }
        eprintln!("transcript written to {}", path.display());
    }
    Ok(())
}

/// The current time, in unix seconds.
fn now_epoch() -> u64 {
    std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .map(|d| d.as_secs())
        .unwrap_or(0)
}

/// Keeps the unused import warning away for `Message` and `ToolResult`.
#[allow(dead_code)]
fn _type_anchors(_m: Message, _r: ToolResult) {}
