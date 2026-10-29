//! The device half of the terminal: identity, registration, the grant handover.
//!
//! This is what the terminal needs from the platform before it can work: a device id the
//! platform recognises, a binding code a human redeems in the console, and the grant that says
//! what this machine may do (01 §5.2, 03 §3.5).
//!
//! It lives in the agent binary on purpose: a machine that runs the agent should not need a
//! second runtime installed for four operations. The device identity never leaves the machine
//! (red-team R-01).

use crate::platform::{PlatformClient, PlatformConfig};
use anyhow::{anyhow, Context, Result};
use serde_json::{json, Value};
use std::path::{Path, PathBuf};

/// The device's own identity: an id the platform recognises and a secret only this machine has.
#[derive(Debug, Clone)]
pub struct DeviceIdentity {
    pub device_id: String,
    pub secret: String,
    pub path: PathBuf,
}

impl DeviceIdentity {
    /// Loads the identity, creating it on first use.
    pub fn load_or_create(identity_dir: &Path) -> Result<Self> {
        std::fs::create_dir_all(identity_dir)
            .with_context(|| format!("cannot create {}", identity_dir.display()))?;
        restrict(identity_dir, true);
        let file = identity_dir.join("device.key");
        if file.exists() {
            let raw = std::fs::read_to_string(&file)
                .with_context(|| format!("cannot read {}", file.display()))?;
            let mut parts = raw.trim().splitn(3, ':');
            let tag = parts.next().unwrap_or_default();
            let device_id = parts.next().unwrap_or_default().to_string();
            let secret = parts.next().unwrap_or_default().to_string();
            if tag != "harness-device" || device_id.is_empty() || secret.is_empty() {
                return Err(anyhow!(
                    "{} is not a device identity file - move it aside to register again",
                    file.display()
                ));
            }
            return Ok(Self {
                device_id,
                secret,
                path: file,
            });
        }
        let device_id = format!("dev-{}", random_hex(16));
        let secret = random_hex(32);
        let tmp = identity_dir.join("device.key.tmp");
        std::fs::write(&tmp, format!("harness-device:{device_id}:{secret}"))?;
        restrict(&tmp, false);
        std::fs::rename(&tmp, &file)?;
        restrict(&file, false);
        Ok(Self {
            device_id,
            secret,
            path: file,
        })
    }
}

/// The registration answer.
#[derive(Debug, Clone)]
pub struct Hello {
    pub terminal_id: String,
    pub status: String,
    pub binding_code: String,
    pub binding_code_ttl_seconds: i64,
}

/// Registers the device and asks for a binding code.
pub async fn hello(config: &PlatformConfig, identity: &DeviceIdentity) -> Result<Hello> {
    let client = PlatformClient::new(config)?;
    let device = json!({
        "deviceId": identity.device_id,
        "os": os_name(),
        "osVersion": std::env::var("VERSION").unwrap_or_default(),
        "hostname": hostname(),
        "agentVersion": env!("CARGO_PKG_VERSION"),
        "capabilities": json!({}),
    });
    let answer = client.send("POST", "/api/harness/terminal/hello", Some(&device)).await?;
    let hello = Hello {
        terminal_id: string_of(&answer, "terminalId"),
        status: string_of(&answer, "status"),
        binding_code: string_of(&answer, "bindingCode"),
        binding_code_ttl_seconds: answer
            .get("bindingCodeTtlSeconds")
            .and_then(Value::as_i64)
            .unwrap_or(0),
    };
    if !hello.terminal_id.is_empty() {
        remember_terminal_id(config, &hello.terminal_id)?;
    }
    Ok(hello)
}

/// Fetches the grant and writes it where the agent reads it.
pub async fn grant(config: &PlatformConfig) -> Result<Value> {
    let client = PlatformClient::new(config)?;
    let terminal_id = terminal_id(config)?;
    let grant = client
        .send("GET", &format!("/api/harness/terminal/{terminal_id}/grant"), None)
        .await?;
    let path = grant_path(config)?;
    std::fs::write(&path, serde_json::to_string_pretty(&grant)?)?;
    restrict(&path, false);
    Ok(grant)
}

/// One heartbeat.
pub async fn heartbeat(config: &PlatformConfig) -> Result<String> {
    let client = PlatformClient::new(config)?;
    let terminal_id = terminal_id(config)?;
    let answer = client
        .send(
            "POST",
            &format!("/api/harness/terminal/{terminal_id}/heartbeat"),
            Some(&Value::Null),
        )
        .await?;
    Ok(string_of(&answer, "status"))
}

/// What the platform currently says this machine may do.
pub async fn status(config: &PlatformConfig) -> Result<Value> {
    let client = PlatformClient::new(config)?;
    let terminal_id = terminal_id(config)?;
    client
        .send("GET", &format!("/api/harness/terminal/{terminal_id}/grant"), None)
        .await
}

/// Writes the terminal id into the configuration, so the next command finds the device.
pub fn remember_terminal_id(config: &PlatformConfig, terminal_id: &str) -> Result<()> {
    let path = config_path(config)?;
    let mut lines = std::fs::read_to_string(&path)
        .with_context(|| format!("cannot read {}", path.display()))?
        .lines()
        .map(str::to_string)
        .collect::<Vec<_>>();
    let mut found = false;
    for line in lines.iter_mut() {
        if line.starts_with("terminal.id=") {
            *line = format!("terminal.id={terminal_id}");
            found = true;
        }
    }
    if !found {
        lines.push(format!("terminal.id={terminal_id}"));
    }
    let mut body = lines.join("\n");
    body.push('\n');
    std::fs::write(&path, body)?;
    restrict(&path, false);
    Ok(())
}

/// The configuration file of this terminal.
pub fn config_path(config: &PlatformConfig) -> Result<PathBuf> {
    if let Some(path) = &config.config_file {
        return Ok(path.clone());
    }
    Ok(default_config_path())
}

/// Where the grant is written - next to the identity, where the agent looks for it.
pub fn grant_path(config: &PlatformConfig) -> Result<PathBuf> {
    let identity = config
        .identity_dir
        .clone()
        .ok_or_else(|| anyhow!("no identity directory in the configuration"))?;
    Ok(identity.join("grant.json"))
}

/// The terminal id the platform gave us.
pub fn terminal_id(config: &PlatformConfig) -> Result<String> {
    if config.terminal_id.is_empty() {
        return Err(anyhow!(
            "this terminal has no id yet - run 'device hello' first"
        ));
    }
    Ok(config.terminal_id.clone())
}

/// The default configuration path.
pub fn default_config_path() -> PathBuf {
    std::env::var("HOME")
        .map(|home| PathBuf::from(home).join(".harness").join("terminal").join("terminal.properties"))
        .unwrap_or_else(|_| PathBuf::from("terminal.properties"))
}

/// The default identity directory.
pub fn default_identity_dir() -> PathBuf {
    std::env::var("HOME")
        .map(|home| PathBuf::from(home).join(".harness").join("terminal").join("identity"))
        .unwrap_or_else(|_| PathBuf::from("identity"))
}

fn string_of(value: &Value, key: &str) -> String {
    value
        .get(key)
        .and_then(Value::as_str)
        .unwrap_or_default()
        .to_string()
}

fn random_hex(bytes: usize) -> String {
    let mut buffer = vec![0u8; bytes];
    if let Ok(mut source) = std::fs::File::open("/dev/urandom") {
        use std::io::Read;
        let _ = source.read_exact(&mut buffer);
    }
    hex::encode(buffer)
}

fn os_name() -> String {
    let os = std::env::var("OS").unwrap_or_default().to_lowercase();
    if os.contains("win") {
        "windows".to_string()
    } else if os.contains("mac") || os.contains("darwin") {
        "macos".to_string()
    } else {
        "linux".to_string()
    }
}

fn hostname() -> String {
    std::fs::read_to_string("/proc/sys/kernel/hostname")
        .map(|value| value.trim().to_string())
        .unwrap_or_else(|_| "unknown-host".to_string())
}

/// Owner-only permissions; the device secret and the grant live in these files.
fn restrict(path: &Path, directory: bool) {
    #[cfg(unix)]
    {
        use std::os::unix::fs::PermissionsExt;
        let mode = if directory { 0o700 } else { 0o600 };
        if let Ok(metadata) = std::fs::metadata(path) {
            let mut permissions = metadata.permissions();
            permissions.set_mode(mode);
            let _ = std::fs::set_permissions(path, permissions);
        }
    }
    #[cfg(not(unix))]
    let _ = (path, directory);
}
