//! The model: what the agent thinks with.
//!
//! The loop does not care which model is behind it. There are three implementations:
//!
//! * [`AnthropicModel`] - the Messages API, which is what most coding agents speak;
//! * [`OpenAiModel`] - the chat-completions API, which most self-hosted models speak;
//! * [`ScriptedModel`] - a model that replays a fixed list of turns. It exists so the loop
//!   can be tested end to end without a network and without a bill.

use anyhow::{anyhow, Result};
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};

/// One turn of the conversation.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Message {
    /// `user`, `assistant` or `tool`.
    pub role: String,
    pub content: String,
}

impl Message {
    pub fn user(content: impl Into<String>) -> Self {
        Self {
            role: "user".into(),
            content: content.into(),
        }
    }

    pub fn assistant(content: impl Into<String>) -> Self {
        Self {
            role: "assistant".into(),
            content: content.into(),
        }
    }

    pub fn tool(content: impl Into<String>) -> Self {
        Self {
            role: "tool".into(),
            content: content.into(),
        }
    }
}

/// What the model wants to do next.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Turn {
    /// The model is done.
    Final(String),
    /// The model wants one or more tools to run.
    Tools(Vec<crate::tools::ToolCall>),
}

/// A model the agent can talk to.
#[async_trait::async_trait]
pub trait Model: Send + Sync {
    /// The next turn, given the conversation so far.
    async fn next_turn(&self, messages: &[Message], tools: &Value) -> Result<Turn>;
}

/// The Anthropic Messages API.
pub struct AnthropicModel {
    client: reqwest::Client,
    api_key: String,
    model: String,
    base_url: String,
    max_tokens: usize,
}

impl AnthropicModel {
    pub fn new(api_key: impl Into<String>, model: impl Into<String>) -> Self {
        Self {
            client: reqwest::Client::new(),
            api_key: api_key.into(),
            model: model.into(),
            base_url: "https://api.anthropic.com/v1/messages".to_string(),
            max_tokens: 8192,
        }
    }

    pub fn with_base_url(mut self, base_url: impl Into<String>) -> Self {
        self.base_url = base_url.into();
        self
    }

    pub fn with_max_tokens(mut self, max_tokens: usize) -> Self {
        self.max_tokens = max_tokens;
        self
    }
}

#[async_trait::async_trait]
impl Model for AnthropicModel {
    async fn next_turn(&self, messages: &[Message], tools: &Value) -> Result<Turn> {
        let mut system = String::new();
        let mut turns = Vec::new();
        for message in messages {
            if message.role == "system" {
                system = message.content.clone();
            } else {
                turns.push(json!({"role": message.role, "content": message.content}));
            }
        }
        let mut body = json!({
            "model": self.model,
            "max_tokens": self.max_tokens,
            "messages": turns,
        });
        if !system.is_empty() {
            body["system"] = json!(system);
        }
        if let Some(catalogue) = tools.get("tools") {
            body["tools"] = catalogue.clone();
        }
        let response = self
            .client
            .post(&self.base_url)
            .header("x-api-key", &self.api_key)
            .header("anthropic-version", "2023-06-01")
            .json(&body)
            .send()
            .await
            .map_err(|e| anyhow!("model request failed: {e}"))?;
        let status = response.status();
        let text = response.text().await.unwrap_or_default();
        if !status.is_success() {
            return Err(anyhow!("model returned HTTP {status}: {text}"));
        }
        let parsed: Value = serde_json::from_str(&text)
            .map_err(|e| anyhow!("model response is not JSON: {e}"))?;
        Ok(parse_anthropic_turn(&parsed))
    }
}

/// The OpenAI chat-completions API.
pub struct OpenAiModel {
    client: reqwest::Client,
    api_key: String,
    model: String,
    base_url: String,
    max_tokens: usize,
}

impl OpenAiModel {
    pub fn new(api_key: impl Into<String>, model: impl Into<String>) -> Self {
        Self {
            client: reqwest::Client::new(),
            api_key: api_key.into(),
            model: model.into(),
            base_url: "https://api.openai.com/v1/chat/completions".to_string(),
            max_tokens: 4096,
        }
    }

    pub fn with_base_url(mut self, base_url: impl Into<String>) -> Self {
        self.base_url = base_url.into();
        self
    }
}

#[async_trait::async_trait]
impl Model for OpenAiModel {
    async fn next_turn(&self, messages: &[Message], tools: &Value) -> Result<Turn> {
        let mut turns = Vec::new();
        for message in messages {
            turns.push(json!({"role": message.role, "content": message.content}));
        }
        let catalogue: Vec<Value> = tools
            .get("tools")
            .and_then(Value::as_array)
            .cloned()
            .unwrap_or_default();
        let tools_payload: Vec<Value> = catalogue
            .iter()
            .map(|tool| {
                json!({
                    "type": "function",
                    "function": {
                        "name": tool.get("name").cloned().unwrap_or(json!("")),
                        "description": tool.get("description").cloned().unwrap_or(json!("")),
                        "parameters": tool.get("input_schema").cloned().unwrap_or(json!({})),
                    }
                })
            })
            .collect();
        let mut body = json!({
            "model": self.model,
            "messages": turns,
            "max_tokens": self.max_tokens,
        });
        if !tools_payload.is_empty() {
            body["tools"] = json!(tools_payload);
        }
        let response = self
            .client
            .post(&self.base_url)
            .bearer_auth(&self.api_key)
            .json(&body)
            .send()
            .await
            .map_err(|e| anyhow!("model request failed: {e}"))?;
        let status = response.status();
        let text = response.text().await.unwrap_or_default();
        if !status.is_success() {
            return Err(anyhow!("model returned HTTP {status}: {text}"));
        }
        let parsed: Value = serde_json::from_str(&text)
            .map_err(|e| anyhow!("model response is not JSON: {e}"))?;
        Ok(parse_openai_turn(&parsed))
    }
}

/// A model that replays a fixed script.
///
/// It exists so the loop - the part with the actual value - can be tested without a network.
pub struct ScriptedModel {
    turns: std::sync::Mutex<std::collections::VecDeque<Result<Turn, String>>>,
    /// How many times `next_turn` was called.
    pub calls: std::sync::atomic::AtomicUsize,
}

impl ScriptedModel {
    pub fn new(turns: Vec<Result<Turn, String>>) -> Self {
        Self {
            turns: std::sync::Mutex::new(turns.into()),
            calls: std::sync::atomic::AtomicUsize::new(0),
        }
    }

    /// A model that answers with one tool call and then finishes.
    pub fn once(call: crate::tools::ToolCall) -> Self {
        Self::new(vec![
            Ok(Turn::Tools(vec![call])),
            Ok(Turn::Final("done".to_string())),
        ])
    }

    /// A model that only ever finishes.
    pub fn final_answer(text: impl Into<String>) -> Self {
        Self::new(vec![Ok(Turn::Final(text.into()))])
    }
}

#[async_trait::async_trait]
impl Model for ScriptedModel {
    async fn next_turn(&self, _messages: &[Message], _tools: &Value) -> Result<Turn> {
        self.calls
            .fetch_add(1, std::sync::atomic::Ordering::SeqCst);
        let mut turns = self.turns.lock().expect("scripted model lock");
        match turns.pop_front() {
            Some(Ok(turn)) => Ok(turn),
            Some(Err(message)) => Err(anyhow!(message)),
            None => Ok(Turn::Final("the script ran out of turns".to_string())),
        }
    }
}

/// Reads an Anthropic response into a turn.
pub fn parse_anthropic_turn(response: &Value) -> Turn {
    let mut calls = Vec::new();
    let mut text = String::new();
    if let Some(content) = response.get("content").and_then(Value::as_array) {
        for block in content {
            match block.get("type").and_then(Value::as_str) {
                Some("text") => {
                    if let Some(chunk) = block.get("text").and_then(Value::as_str) {
                        text.push_str(chunk);
                    }
                }
                Some("tool_use") => {
                    calls.push(crate::tools::ToolCall {
                        name: block
                            .get("name")
                            .and_then(Value::as_str)
                            .unwrap_or_default()
                            .to_string(),
                        arguments: block
                            .get("input")
                            .cloned()
                            .unwrap_or_else(|| json!({})),
                    });
                }
                _ => {}
            }
        }
    }
    if calls.is_empty() {
        Turn::Final(text)
    } else {
        Turn::Tools(calls)
    }
}

/// Reads an OpenAI response into a turn.
pub fn parse_openai_turn(response: &Value) -> Turn {
    let mut calls = Vec::new();
    let mut text = String::new();
    if let Some(choice) = response
        .get("choices")
        .and_then(Value::as_array)
        .and_then(|choices| choices.first())
    {
        if let Some(message) = choice.get("message") {
            if let Some(chunk) = message.get("content").and_then(Value::as_str) {
                text.push_str(chunk);
            }
            if let Some(tool_calls) = message.get("tool_calls").and_then(Value::as_array) {
                for call in tool_calls {
                    let name = call
                        .get("function")
                        .and_then(|f| f.get("name"))
                        .and_then(Value::as_str)
                        .unwrap_or_default()
                        .to_string();
                    let arguments = call
                        .get("function")
                        .and_then(|f| f.get("arguments"))
                        .and_then(Value::as_str)
                        .and_then(|raw| serde_json::from_str::<Value>(raw).ok())
                        .unwrap_or_else(|| json!({}));
                    calls.push(crate::tools::ToolCall { name, arguments });
                }
            }
        }
    }
    if calls.is_empty() {
        Turn::Final(text)
    } else {
        Turn::Tools(calls)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn reads_an_anthropic_tool_call() {
        let response = json!({
            "content": [
                {"type": "text", "text": "let me look"},
                {"type": "tool_use", "name": "read_file", "input": {"path": "a.txt"}}
            ]
        });
        let turn = parse_anthropic_turn(&response);
        match turn {
            Turn::Tools(calls) => {
                assert_eq!(calls.len(), 1);
                assert_eq!(calls[0].name, "read_file");
                assert_eq!(calls[0].arguments["path"], "a.txt");
            }
            Turn::Final(text) => panic!("expected a tool call, got {text}"),
        }
    }

    #[test]
    fn reads_an_anthropic_final_answer() {
        let response = json!({"content": [{"type": "text", "text": "all good"}]});
        assert_eq!(parse_anthropic_turn(&response), Turn::Final("all good".into()));
    }

    #[test]
    fn reads_an_openai_tool_call() {
        let response = json!({
            "choices": [{
                "message": {
                    "content": null,
                    "tool_calls": [{
                        "function": {"name": "list_files", "arguments": "{\"path\":\"src\"}"}
                    }]
                }
            }]
        });
        let turn = parse_openai_turn(&response);
        match turn {
            Turn::Tools(calls) => {
                assert_eq!(calls[0].name, "list_files");
                assert_eq!(calls[0].arguments["path"], "src");
            }
            Turn::Final(text) => panic!("expected a tool call, got {text}"),
        }
    }
}
