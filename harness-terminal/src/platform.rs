//! The agent's side of the console-to-terminal channel.
//!
//! The terminal shell (Java) already knows the platform, the device identity and the client
//! secret - they are in `terminal.properties`. The agent reads the same file, so there is one
//! place where the machine's identity lives, and the agent can pick up a request from the
//! console without anybody typing a secret into it again.
//!
//! The requests are signed exactly like the shell's (03 §9): the same canonical string, the
//! same key derivation. `harness/tools/verify-portal-interop.sh` checks the three
//! implementations against each other.

use anyhow::{anyhow, Context, Result};
use hmac::{Hmac, Mac};
use reqwest::Client;
use serde_json::{json, Value};
use sha2::Sha256;
use std::collections::HashMap;
use std::path::Path;
use std::time::Duration;

/// The platform's parameters, read from the shell's configuration file.
#[derive(Debug, Clone, Default)]
pub struct PlatformConfig {
    pub base_url: String,
    pub client_id: String,
    pub secret: String,
    pub terminal_id: String,
    /// Where the configuration itself lives, so it can be written back.
    pub config_file: Option<std::path::PathBuf>,
    /// The directory with the device identity and the grant.
    pub identity_dir: Option<std::path::PathBuf>,
}

impl PlatformConfig {
    /// Reads `terminal.properties` (the shell's format: `key=value`, `#` comments).
    pub fn read(path: &Path) -> Result<Self> {
        let text = std::fs::read_to_string(path)
            .with_context(|| format!("cannot read {}", path.display()))?;
        let mut config = Self::default();
        config.config_file = Some(path.to_path_buf());
        let mut values: HashMap<String, String> = HashMap::new();
        for line in text.lines() {
            let line = line.trim();
            if line.is_empty() || line.starts_with('#') {
                continue;
            }
            if let Some((key, value)) = line.split_once('=') {
                values.insert(key.trim().to_string(), unescape_java(value.trim()));
            }
        }
        config.base_url = values.get("platform.url").cloned().unwrap_or_default();
        config.client_id = values.get("client.id").cloned().unwrap_or_default();
        config.secret = values.get("secret").cloned().unwrap_or_default();
        config.terminal_id = values.get("terminal.id").cloned().unwrap_or_default();
        if let Some(identity) = values.get("identity.directory") {
            config.identity_dir = Some(std::path::PathBuf::from(identity));
        }
        Ok(config)
    }

    /// The configuration the shell writes next to the device identity.
    pub fn default_path() -> std::path::PathBuf {
        let home = std::env::var("HOME").unwrap_or_else(|_| ".".to_string());
        std::path::PathBuf::from(home)
            .join(".harness")
            .join("terminal")
            .join("terminal.properties")
    }
}

/// A signed client for the platform.
#[derive(Debug, Clone)]
pub struct PlatformClient {
    client: Client,
    base_url: String,
    client_id: String,
    key: Vec<u8>,
}

impl PlatformClient {
    pub fn new(config: &PlatformConfig) -> Result<Self> {
        if config.base_url.is_empty() {
            return Err(anyhow!("no platform.url in the terminal configuration"));
        }
        if config.secret.is_empty() {
            return Err(anyhow!("no client secret in the terminal configuration"));
        }
        Ok(Self {
            client: Client::builder()
                .timeout(Duration::from_secs(30))
                // The terminal talks to its platform directly. A machine that sits behind a
                // corporate proxy must not route its control channel through it - the request
                // carries a signature, and a proxy that cannot reach the platform is a
                // mysterious "the platform did not answer".
                .no_proxy()
                .build()
                .context("cannot build the http client")?,
            base_url: config.base_url.trim_end_matches('/').to_string(),
            client_id: config.client_id.clone(),
            key: derive_key(&config.secret),
        })
    }

    /// The signing key: the ASCII of hex(sha256(secret)) - the same value the platform stores.
    pub fn derive_key(secret: &str) -> Vec<u8> {
        derive_key(secret)
    }

    /// Signs and sends a request.
    pub async fn send(&self, method: &str, path: &str, body: Option<&Value>) -> Result<Value> {
        let body_bytes = match body {
            Some(value) => serde_json::to_vec(value)?,
            None => Vec::new(),
        };
        let timestamp = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .map(|d| d.as_secs())
            .unwrap_or(0);
        let nonce = uuid::Uuid::new_v4().to_string();
        let canonical = format!(
            "{}\n{}\n{}\n{}\n{}",
            method.to_uppercase(),
            path,
            timestamp,
            nonce,
            hex::encode(sha256(&body_bytes))
        );
        let signature = sign(&self.key, canonical.as_bytes());

        let mut request = self
            .client
            .request(
                reqwest::Method::from_bytes(method.to_uppercase().as_bytes())
                    .map_err(|e| anyhow!("bad method: {e}"))?,
                format!("{}{}", self.base_url, path),
            )
            .header("X-Harness-Client", &self.client_id)
            .header("X-Harness-Timestamp", timestamp.to_string())
            .header("X-Harness-Nonce", nonce)
            .header("X-Harness-Signature", signature);
        if body.is_some() {
            request = request.header("Content-Type", "application/json").body(body_bytes);
        }
        let response = request.send().await.context("the platform did not answer")?;
        let status = response.status();
        let text = response.text().await.unwrap_or_default();
        if !status.is_success() {
            return Err(anyhow!("the platform refused {method} {path}: HTTP {status} {text}"));
        }
        if text.is_empty() {
            return Ok(Value::Null);
        }
        serde_json::from_str(&text).context("the platform's answer is not JSON")
    }

    /// The next task for this terminal, if there is one.
    pub async fn next_task(&self, terminal_id: &str) -> Result<Option<Value>> {
        let answer = self
            .send(
                "GET",
                &format!("/api/harness/terminal/{terminal_id}/tasks/next"),
                None,
            )
            .await?;
        let task = answer.get("taskId").and_then(Value::as_str).unwrap_or("");
        if task.is_empty() {
            Ok(None)
        } else {
            Ok(Some(answer))
        }
    }

    /// The model configuration of this terminal, with the key.
    ///
    /// The platform holds it so the operator can set it from the console; the terminal only has
    /// to be able to reach it. An empty answer means "no model configured" - the terminal then
    /// runs a request as a command instead of pretending a model is there.
    pub async fn model_config(&self, terminal_id: &str) -> Result<Option<ModelConfig>> {
        let answer = self
            .send("GET", &format!("/api/harness/terminal/{terminal_id}/model"), None)
            .await?;
        let provider = answer.get("provider").and_then(Value::as_str).unwrap_or("");
        if provider.is_empty() {
            return Ok(None);
        }
        Ok(Some(ModelConfig {
            provider: provider.to_string(),
            model_name: answer
                .get("modelName")
                .and_then(Value::as_str)
                .unwrap_or("")
                .to_string(),
            base_url: answer
                .get("baseUrl")
                .and_then(Value::as_str)
                .unwrap_or("")
                .to_string(),
            api_key: answer
                .get("apiKey")
                .and_then(Value::as_str)
                .unwrap_or("")
                .to_string(),
        }))
    }

    /// One heartbeat.
    ///
    /// The device's liveness is what the platform uses to decide whether the machine is still
    /// there. Fifteen minutes of silence demotes the terminal to read-only (red-team R-01), so
    /// whatever runs on the machine has to say something.
    pub async fn heartbeat(&self, terminal_id: &str) -> Result<String> {
        let answer = self
            .send(
                "POST",
                &format!("/api/harness/terminal/{terminal_id}/heartbeat"),
                Some(&Value::Null),
            )
            .await?;
        Ok(answer
            .get("status")
            .and_then(Value::as_str)
            .unwrap_or("unknown")
            .to_string())
    }

    /// Posts the answer.
    pub async fn complete_task(&self, task_id: &str, answer: &Value) -> Result<()> {
        self.send(
            "POST",
            &format!("/api/harness/tasks/{task_id}/result"),
            Some(answer),
        )
        .await
        .map(|_| ())
    }
}

/// Undoes the escaping that Java's `Properties.store` applies to a value.
///
/// The shell writes its configuration with `Properties.store`, which escapes `:` and `=` and
/// everything else that could confuse a reader (`http\://host\:18080`). Java reads that back
/// transparently; any other reader has to know the rule.
pub fn unescape_java(value: &str) -> String {
    let mut out = String::with_capacity(value.len());
    let mut chars = value.chars().peekable();
    while let Some(c) = chars.next() {
        if c != '\\' {
            out.push(c);
            continue;
        }
        match chars.next() {
            Some('n') => out.push('\n'),
            Some('t') => out.push('\t'),
            Some('r') => out.push('\r'),
            Some('u') => {
                let hex: String = chars.by_ref().take(4).collect();
                if let Ok(code) = u32::from_str_radix(&hex, 16) {
                    if let Some(ch) = char::from_u32(code) {
                        out.push(ch);
                    }
                }
            }
            Some(other) => out.push(other),
            None => out.push('\\'),
        }
    }
    out
}

/// The signing key: the ASCII of hex(sha256(secret)).
pub fn derive_key(secret: &str) -> Vec<u8> {
    hex::encode(sha256(secret.as_bytes())).into_bytes()
}

/// sha256 of a byte slice.
pub fn sha256(bytes: &[u8]) -> [u8; 32] {
    use sha2::Digest;
    let mut hasher = Sha256::new();
    hasher.update(bytes);
    hasher.finalize().into()
}

/// HMAC-SHA256, hex encoded.
pub fn sign(key: &[u8], message: &[u8]) -> String {
    let mut mac = <Hmac<Sha256> as Mac>::new_from_slice(key).expect("hmac accepts any key length");
    mac.update(message);
    hex::encode(mac.finalize().into_bytes())
}

/// The model configuration the platform handed out.
#[derive(Debug, Clone, Default)]
pub struct ModelConfig {
    pub provider: String,
    pub model_name: String,
    pub base_url: String,
    pub api_key: String,
}

/// The answer the agent posts back.
pub fn task_result(answer: &str, transcript: Value, touched: Vec<String>, error: Option<String>) -> Value {
    json!({
        "status": if error.is_some() { "failed" } else { "done" },
        "answer": answer,
        "transcript": transcript,
        "touched": touched,
        "error": error,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn reads_the_shells_configuration() {
        let dir = tempfile::tempdir().unwrap();
        let file = dir.path().join("terminal.properties");
        std::fs::write(
            &file,
            "# comment\nplatform.url=http://127.0.0.1:18080\nclient.id=harness-bootstrap\n\
             secret=abc\nterminal.id=01a1\n\n",
        )
        .unwrap();
        let config = PlatformConfig::read(&file).unwrap();
        assert_eq!(config.base_url, "http://127.0.0.1:18080");
        assert_eq!(config.client_id, "harness-bootstrap");
        assert_eq!(config.terminal_id, "01a1");
    }

    #[test]
    fn undoes_javas_property_escaping() {
        assert_eq!(unescape_java(r"http\://127.0.0.1\:18080"), "http://127.0.0.1:18080");
        assert_eq!(unescape_java(r"a\=b"), "a=b");
        assert_eq!(unescape_java(r"plain"), "plain");
    }

    #[test]
    fn the_signing_key_is_the_ascii_of_the_hex_digest() {
        // The platform signs with hex(sha256(secret)) as ASCII bytes; the Java shell does the
        // same. If this changes, every call is rejected with BAD_SIGNATURE.
        let key = derive_key("shared-secret-0123456789-abcdef");
        assert_eq!(key.len(), 64);
        assert!(key.iter().all(|b| b.is_ascii_hexdigit()));
    }
}
