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
use anyhow::{anyhow, Context, Result};
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
    /// The device side: register, fetch the grant, heartbeat.
    Device(DeviceArgs),
    /// The skills: fetch them from the platform and install them locally.
    Skills(SkillsArgs),
}

#[derive(Parser, Debug)]
struct SkillsArgs {
    #[command(subcommand)]
    command: SkillsCommand,
}

#[derive(Subcommand, Debug)]
enum SkillsCommand {
    /// Fetch the skills this terminal has been given and install them.
    Sync(SkillsSyncArgs),
    /// Show the skills that are installed.
    List(SkillsListArgs),
}

#[derive(Parser, Debug)]
struct SkillsSyncArgs {
    /// The directory the skills are installed into.
    #[arg(long)]
    dir: Option<PathBuf>,
    /// The configuration file of the terminal (platform.url, client.id, secret).
    #[arg(long)]
    config: Option<PathBuf>,
}

#[derive(Parser, Debug)]
struct SkillsListArgs {
    /// The directory the skills are installed into.
    #[arg(long)]
    dir: Option<PathBuf>,
}

#[derive(Parser, Debug)]
struct DeviceArgs {
    #[command(subcommand)]
    command: DeviceCommand,
}

#[derive(Subcommand, Debug)]
enum DeviceCommand {
    /// Register this machine and ask for a binding code.
    Hello,
    /// Fetch the grant from the platform and write it where the agent reads it.
    Grant,
    /// Send one heartbeat.
    Heartbeat,
    /// What the platform currently says this machine may do.
    Status,
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
    /// The directory the skills are installed into.
    #[arg(long)]
    skills: Option<PathBuf>,
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
        Command::Device(args) => device(args).await,
        Command::Skills(args) => skills(args).await,
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

/// The skills: fetch them from the platform and install them locally.
///
/// The platform is the shelf; this machine is the copy. A skill the platform withdrew is
/// removed from the disk, because a skill that is not on the shelf any more must not keep
/// running here.
async fn skills(args: SkillsArgs) -> Result<()> {
    match args.command {
        SkillsCommand::Sync(sync_args) => {
            let config_path = sync_args
                .config
                .clone()
                .unwrap_or_else(crate::platform::PlatformConfig::default_path);
            let config = crate::platform::PlatformConfig::read(&config_path)?;
            if config.terminal_id.is_empty() {
                return Err(anyhow::anyhow!(
                    "the configuration {} has no terminal.id - run 'harness-terminal device hello' first",
                    config_path.display()
                ));
            }
            let platform = crate::platform::PlatformClient::new(&config)?;
            let root = sync_args
                .dir
                .clone()
                .unwrap_or_else(crate::skills::default_skills_dir);
            let report = sync_skills(&platform, &config.terminal_id, &root).await?;
            println!("skills: {}", root.display());
            for name in &report.installed {
                println!("  installed {name}");
            }
            for name in &report.removed {
                println!("  removed {name}");
            }
            for (name, reason) in &report.rejected {
                eprintln!("  refused {name}: {reason}");
            }
            Ok(())
        }
        SkillsCommand::List(list_args) => {
            let root = list_args
                .dir
                .clone()
                .unwrap_or_else(crate::skills::default_skills_dir);
            let library = SkillLibrary::load_from(&root)?;
            println!("# Skills ({}):", library.len());
            for name in library.names() {
                let skill = library.get(&name).expect("skill");
                println!("  {name}: {}", skill.description);
            }
            Ok(())
        }
    }
}

/// Fetches the skills from the platform and puts them on disk.
///
/// The digest is checked before anything is written, and a skill that does not load is refused
/// rather than left behind.
async fn sync_skills(
    platform: &crate::platform::PlatformClient,
    terminal_id: &str,
    root: &std::path::Path,
) -> Result<crate::skills::InstallReport> {
    let answer = platform.skills(terminal_id).await?;
    let mut packages = Vec::new();
    for item in answer {
        match crate::skills::SkillPackage::from_json(&item) {
            Ok(package) => packages.push(package),
            Err(error) => eprintln!("the platform sent a skill that cannot be read: {error:#}"),
        }
    }
    crate::skills::install_all(root, &packages)
}

/// Serves the console: takes requests from the platform, answers them.
///
/// The loop is the whole point of the terminal being a *digital employee* rather than a
/// tool: somebody asks a question in the console, and the machine that is bound to that
/// digital employee answers it - under its own policy, with its own grant.
async fn serve(args: ServeArgs) -> Result<()> {
    // --identity is the directory with the device identity and the grant; the configuration
    // file (platform.url, client.id, secret) sits next to it.
    let config_path = args.config.clone().unwrap_or_else(crate::platform::PlatformConfig::default_path);
    let platform_config = crate::platform::PlatformConfig::read(&config_path)?;
    // The configuration knows where the identity is; fall back to the standard place.
    let identity_dir = args
        .identity
        .clone()
        .or_else(|| platform_config.identity_dir.clone())
        .unwrap_or_else(crate::device::default_identity_dir);
    if platform_config.terminal_id.is_empty() {
        return Err(anyhow::anyhow!(
            "the configuration {} has no terminal.id - run 'harness-terminal hello' first",
            config_path.display()
        ));
    }
    let platform = Arc::new(crate::platform::PlatformClient::new(&platform_config)?);

    // The roots the command line narrows the grant to. The startup and the refresh must use
    // the same list, or a refresh would quietly widen what the agent may touch.
    let roots: Vec<std::path::PathBuf> = Vec::new();
    let (workspace, tools, policy, authority) = build_environment(
        &args.workspace,
        2,
        &roots,
        Some(&identity_dir),
    )?;
    println!("authority: {authority}");
    println!(
        "serving terminal {} on {}",
        platform_config.terminal_id, platform_config.base_url
    );

    // The model configuration comes from the platform, so the operator can set it in the
    // console. The command line and the environment are the fallback for a terminal that is
    // not bound to a platform yet.
    let mut brain: Brain = Brain::Command;
    let mut model_fingerprint = String::new();
    match platform.model_config(&platform_config.terminal_id).await {
        Ok(Some(config)) => {
            println!(
                "model: {} / {} (from the platform)",
                config.provider, config.model_name
            );
            model_fingerprint =
                format!("{}|{}|{}", config.provider, config.model_name, config.api_key);
            brain = Brain::Model(model_of(
                &config.provider,
                &config.model_name,
                &config.base_url,
                &config.api_key,
            )?);
        }
        Ok(None) => {}
        Err(error) => eprintln!("cannot read the model configuration: {error:#}"),
    }
    if matches!(brain, Brain::Command) {
        if let Some(brain_from_env) = brain_from_environment(&args)? {
            brain = brain_from_env;
        }
    }

    let mut served = 0usize;
    let mut announced = false;
    let mut since_heartbeat = 0u64;
    let mut policy_fingerprint = String::new();
    // The policy is re-read from the grant, not held from the start: the platform can take a
    // capability away or give one at any moment.
    let mut policy = policy;

    // The skills live on the platform's shelf. The terminal keeps a copy, checks the copy
    // against the digest the platform published, and takes back the skills the platform
    // withdrew - a withdrawn skill must not keep running here.
    let skills_dir = args
        .skills
        .clone()
        .unwrap_or_else(crate::skills::default_skills_dir);
    let mut library = match sync_skills(&platform, &platform_config.terminal_id, &skills_dir).await {
        Ok(report) => {
            if !report.installed.is_empty() || !report.removed.is_empty() {
                println!(
                    "skills: {} installed, {} removed ({})",
                    report.installed.len(),
                    report.removed.len(),
                    skills_dir.display()
                );
            }
            for (name, reason) in &report.rejected {
                eprintln!("the skill {name} was refused: {reason}");
            }
            SkillLibrary::load_from(&skills_dir)?
        }
        Err(error) => {
            eprintln!("cannot fetch the skills: {error:#}");
            SkillLibrary::new()
        }
    };
    loop {
        // The heartbeat is the device's liveness. Whoever runs on the machine says it - the
        // agent is usually the thing that stays up, so it says it.
        since_heartbeat += 1;
        if since_heartbeat * args.poll_seconds >= HEARTBEAT_INTERVAL_SECONDS {
            since_heartbeat = 0;
            // The grant can change at any time - the platform can take a capability away or
            // give one. An agent that read it once at startup would keep acting with the
            // authority it had then, which is the hole R-01 is about.
            //
            // The platform is asked, not the file on the machine: the file is only a copy of
            // the platform's answer, and a copy that nobody refreshes is the hole itself.
            match refresh_grant(
                &platform,
                &platform_config,
                &identity_dir,
                &roots,
                &mut policy,
                &mut policy_fingerprint,
            )
            .await
            {
                Ok(true) => {}
                Ok(false) => {}
                Err(error) => eprintln!("cannot refresh the grant: {error:#}"),
            }
            // The model configuration may have changed in the console. Pick it up without a
            // restart - an operator should not have to touch the machine to change the brain.
            if let Ok(Some(config)) = platform.model_config(&platform_config.terminal_id).await {
                let fingerprint = format!("{}|{}|{}", config.provider, config.model_name, config.api_key);
                if fingerprint != model_fingerprint {
                    model_fingerprint = fingerprint.clone();
                    match model_of(&config.provider, &config.model_name, &config.base_url, &config.api_key) {
                        Ok(model) => {
                            println!("model: {} / {}", config.provider, config.model_name);
                            brain = Brain::Model(model);
                        }
                        Err(error) => eprintln!("cannot use the model configuration: {error:#}"),
                    }
                }
            }
            match platform.heartbeat(&platform_config.terminal_id).await {
                Ok(status) => {
                    if status == "revoked" {
                        println!("the terminal was revoked; stopping");
                        return Ok(());
                    }
                }
                Err(error) => eprintln!("heartbeat failed: {error:#}"),
            }
            // The shelf changes while the machine is running: a skill is published, withdrawn
            // or upgraded. The copy on the disk follows, the same way the grant does.
            match sync_skills(&platform, &platform_config.terminal_id, &skills_dir).await {
                Ok(report) => {
                    if !report.installed.is_empty() || !report.removed.is_empty() {
                        println!(
                            "skills changed: {} installed, {} removed",
                            report.installed.len(),
                            report.removed.len()
                        );
                        library = SkillLibrary::load_from(&skills_dir)?;
                    }
                }
                Err(error) => eprintln!("cannot fetch the skills: {error:#}"),
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

        let outcome = answer(
            &prompt,
            &args,
            &brain,
            &library,
            workspace.clone(),
            tools.clone(),
            policy.clone(),
        )
        .await;
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

/// Builds a model from a configuration the platform handed out.
fn model_of(
    provider: &str,
    model_name: &str,
    base_url: &str,
    api_key: &str,
) -> Result<Arc<dyn Model>> {
    match provider {
        "anthropic" => {
            let mut model = AnthropicModel::new(api_key, model_name);
            if !base_url.is_empty() {
                model = model.with_base_url(base_url.to_string());
            }
            Ok(Arc::new(model))
        }
        "openai" => {
            let mut model = OpenAiModel::new(api_key, model_name);
            if !base_url.is_empty() {
                model = model.with_base_url(base_url.to_string());
            }
            Ok(Arc::new(model))
        }
        other => Err(anyhow::anyhow!("unknown provider '{other}'")),
    }
}

/// The model from the command line or the environment - the fallback when the platform has
/// no configuration for this terminal.
fn brain_from_environment(args: &ServeArgs) -> Result<Option<Brain>> {
    let api_key = args
        .api_key
        .clone()
        .or_else(|| std::env::var("HARNESS_MODEL_API_KEY").ok());
    let Some(key) = api_key else {
        println!(
            "no model configured: a request is executed as a command, not answered by a model.\n\
             Set one in the console (终端 -> 配置模型) or export HARNESS_MODEL_API_KEY."
        );
        return Ok(None);
    };
    let name = args.model.clone();
    Ok(Some(Brain::Model(model_of(
        &args.provider,
        &name,
        args.base_url.as_deref().unwrap_or(""),
        &key,
    )?)))
}

/// Asks the platform what this machine may do right now, and applies the answer.
///
/// The grant is the authority (01 §5.2). It changes when the platform grants or revokes
/// something, so the agent has to look again - otherwise it keeps acting with the
/// authority it had when it started.
///
/// Returns whether the grant changed. The file on the machine is rewritten from the platform's
/// answer, so the shell and the agent enforce the same decision and the next start does not
/// need a shell command to be up to date.
async fn refresh_grant(
    platform: &crate::platform::PlatformClient,
    config: &crate::platform::PlatformConfig,
    identity_dir: &std::path::Path,
    roots: &[std::path::PathBuf],
    policy: &mut Arc<LocalPolicy>,
    fingerprint: &mut String,
) -> Result<bool> {
    let answer = platform
        .send(
            "GET",
            &format!("/api/harness/terminal/{}/grant", config.terminal_id),
            None,
        )
        .await?;
    let grant: grant::Grant = serde_json::from_value(answer)
        .with_context(|| "the platform's grant cannot be read")?;
    let current = format!(
        "{}|{}|{}",
        grant.autonomy_level,
        grant.capabilities.join(","),
        grant
            .dept_ids
            .iter()
            .map(|id| id.to_string())
            .collect::<Vec<_>>()
            .join(",")
    );
    if current == *fingerprint {
        return Ok(false);
    }
    *fingerprint = current;

    // Written through a temporary name: the agent reads this file while it runs, and a
    // half-written file would read as "no grant" for one moment.
    let path = grant::grant_file(identity_dir);
    let temporary = path.with_extension("json.tmp");
    std::fs::write(&temporary, serde_json::to_string_pretty(&grant)?)?;
    restrict(&temporary);
    std::fs::rename(&temporary, &path)?;
    restrict(&path);

    println!(
        "grant changed: autonomy L{}, capabilities [{}]",
        grant.autonomy_level,
        grant.capabilities.join(", ")
    );
    *policy = Arc::new(grant::policy_from(&grant, roots));
    Ok(true)
}

/// Makes a file readable by its owner only.
fn restrict(path: &std::path::Path) {
    #[cfg(unix)]
    {
        use std::os::unix::fs::PermissionsExt;
        let _ = std::fs::set_permissions(path, std::fs::Permissions::from_mode(0o600));
    }
    #[cfg(not(unix))]
    let _ = path;
}

/// The device side of the terminal.
///
/// These are the four operations a machine needs from the platform before it can work: register
/// (and get a binding code a human redeems), fetch the grant, heartbeat, and say what the
/// platform currently allows.
async fn device(args: DeviceArgs) -> Result<()> {
    let config_path = std::env::var("HARNESS_TERMINAL_CONFIG")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|_| crate::device::default_config_path());
    let config = crate::platform::PlatformConfig::read(&config_path)?;
    let identity_dir = config
        .identity_dir
        .clone()
        .unwrap_or_else(crate::device::default_identity_dir);
    let identity = crate::device::DeviceIdentity::load_or_create(&identity_dir)?;

    match args.command {
        DeviceCommand::Hello => {
            let hello = crate::device::hello(&config, &identity).await?;
            println!("terminalId: {}", hello.terminal_id);
            println!("status: {}", hello.status);
            if hello.binding_code.is_empty() {
                println!("this device is already registered; nothing to bind");
            } else {
                println!(
                    "binding code (valid {}s): {}",
                    hello.binding_code_ttl_seconds, hello.binding_code
                );
                println!("A natural human has to enter it in the console to bind this device.");
            }
        }
        DeviceCommand::Grant => {
            let grant = crate::device::grant(&config).await?;
            let path = crate::device::grant_path(&config)?;
            println!("grant written to {}", path.display());
            let capabilities = grant
                .get("capabilities")
                .and_then(Value::as_array)
                .map(|items| {
                    items
                        .iter()
                        .filter_map(Value::as_str)
                        .collect::<Vec<_>>()
                        .join(", ")
                })
                .unwrap_or_default();
            println!("  capabilities: {}", capabilities);
            println!(
                "  autonomyLevel: {}",
                grant.get("autonomyLevel").and_then(Value::as_str).unwrap_or("0")
            );
        }
        DeviceCommand::Heartbeat => {
            let status = crate::device::heartbeat(&config).await?;
            println!("status: {status}");
            if status == "revoked" {
                std::process::exit(3);
            }
        }
        DeviceCommand::Status => {
            let grant = crate::device::status(&config).await?;
            println!("{}", serde_json::to_string_pretty(&grant)?);
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
    skills: &SkillLibrary,
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
            Ok((
                format!(
                    "{}\n\n（本终端没有配置模型，请求被当作命令执行。要用自然语言提问，\
                     请在控制台的「终端 → 配置模型」里设置。）",
                    result.output
                ),
                json!({"mode": "command"}),
                result.touched.clone(),
            ))
        } else {
            Err(anyhow::anyhow!(
                "{}: {}\n（本终端没有配置模型，请求被当作命令执行，命令失败了。                 要用自然语言提问，请在控制台的「终端 → 配置模型」里设置。）",
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
            // The skills that match the request go into the system prompt. They are content,
            // not authority: whatever they say, every action still goes through the policy.
            system_prompt: {
                let mut system = crate::agent::DEFAULT_SYSTEM_PROMPT.to_string();
                let skill_text = skills.render(prompt, 3);
                if !skill_text.is_empty() {
                    system.push_str("\n\n");
                    system.push_str(&skill_text);
                }
                system
            },
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
