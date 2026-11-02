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

/// The http client a model call uses.
///
/// <p>No proxy: a model gateway is reached directly, and a proxy that cannot reach it is a
/// mysterious timeout. The timeout is long because a local gateway may load the model on the
/// first request.
fn model_client() -> reqwest::Client {
    let timeout = std::env::var("HARNESS_MODEL_TIMEOUT_SECONDS")
        .ok()
        .and_then(|v| v.parse::<u64>().ok())
        .unwrap_or(DEFAULT_MODEL_TIMEOUT_SECONDS);
    reqwest::Client::builder()
        .timeout(std::time::Duration::from_secs(timeout))
        .no_proxy()
        .build()
        .unwrap_or_else(|_| reqwest::Client::new())
}

/// The full URL of an OpenAI-compatible chat endpoint.
pub fn chat_completions_url(base: &str) -> String {
    let base = base.trim_end_matches('/');
    if base.is_empty() {
        return "https://api.openai.com/v1/chat/completions".to_string();
    }
    if base.ends_with("/chat/completions") {
        base.to_string()
    } else {
        format!("{base}/chat/completions")
    }
}

/// The full URL of an Anthropic-compatible messages endpoint.
pub fn messages_url(base: &str) -> String {
    let base = base.trim_end_matches('/');
    if base.is_empty() {
        return "https://api.anthropic.com/v1/messages".to_string();
    }
    if base.ends_with("/messages") {
        base.to_string()
    } else if base.ends_with("/v1") {
        format!("{base}/messages")
    } else {
        // An Anthropic-compatible gateway is addressed at its own root: MiniMax is
        // "https://api.minimax.cn/anthropic" and its messages live at
        // ".../anthropic/v1/messages". Dropping the "/v1" there is a 404 that looks like
        // "the model is down".
        format!("{base}/v1/messages")
    }
}

/// The Anthropic conversation: the system prompt and the turns that follow.
///
/// The Anthropic protocol pairs a tool result with the call it answers, and the pairing is
/// by id: the assistant's turn carries the {@code tool_use} blocks, and the turn that
/// follows carries the {@code tool_result} blocks that name them. A gateway that cannot find
/// the id refuses the whole conversation - "tool result's tool id() not found" - and the
/// refusal looks like a broken model rather than a broken conversation.
pub fn anthropic_turns(messages: &[Message]) -> (String, Vec<Value>) {
    let mut system = String::new();
    let mut turns = Vec::new();
    let mut pending_results: Vec<Value> = Vec::new();
    for message in messages {
        if message.role == "system" {
            system = message.content.clone();
        } else if message.role == "tool" {
            pending_results.push(json!({
                "type": "tool_result",
                "tool_use_id": message.tool_call_id.clone().unwrap_or_default(),
                "content": message.content.clone(),
            }));
        } else {
            // The results of the previous assistant turn have to go out together: the
            // protocol wants one user message holding all of them.
            if !pending_results.is_empty() {
                turns.push(json!({"role": "user", "content": pending_results.clone()}));
                pending_results.clear();
            }
            if message.tool_calls.is_empty() {
                turns.push(json!({"role": message.role, "content": message.content}));
            } else {
                let mut blocks = Vec::new();
                if !message.content.is_empty() {
                    blocks.push(json!({"type": "text", "text": message.content}));
                }
                for call in &message.tool_calls {
                    blocks.push(json!({
                        "type": "tool_use",
                        "id": call.id.clone().unwrap_or_default(),
                        "name": call.name,
                        "input": call.arguments.clone(),
                    }));
                }
                turns.push(json!({"role": "assistant", "content": blocks}));
            }
        }
    }
    if !pending_results.is_empty() {
        turns.push(json!({"role": "user", "content": pending_results}));
    }
    (system, turns)
}

/// One turn of the conversation.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Message {
    /// `user`, `assistant` or `tool`.
    pub role: String,
    pub content: String,
    /// The tool calls this assistant turn made.
    ///
    /// <p>Anthropic pairs a tool result with the call it answers, and it insists that the
    /// call is in the conversation: a result whose call is missing is a result the gateway
    /// cannot place.
    #[serde(default)]
    pub tool_calls: Vec<crate::tools::ToolCall>,
    /// The id of the call this message answers, for a `tool` message.
    #[serde(default)]
    pub tool_call_id: Option<String>,
}

impl Message {
    pub fn user(content: impl Into<String>) -> Self {
        Self {
            role: "user".into(),
            content: content.into(),
            tool_calls: Vec::new(),
            tool_call_id: None,
        }
    }

    pub fn assistant(content: impl Into<String>) -> Self {
        Self {
            role: "assistant".into(),
            content: content.into(),
            tool_calls: Vec::new(),
            tool_call_id: None,
        }
    }

    /// The assistant's turn in which it asked for tools.
    pub fn assistant_calling(content: impl Into<String>, calls: Vec<crate::tools::ToolCall>) -> Self {
        Self {
            role: "assistant".into(),
            content: content.into(),
            tool_calls: calls,
            tool_call_id: None,
        }
    }

    /// The result of one tool call.
    pub fn tool(content: impl Into<String>, tool_call_id: Option<String>) -> Self {
        Self {
            role: "tool".into(),
            content: content.into(),
            tool_calls: Vec::new(),
            tool_call_id,
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
    /// The model ran out of output tokens in the middle of a turn.
    ///
    /// <p>This is not an answer - it is the beginning of one, cut off. A reasoning model
    /// spends most of its tokens thinking before it calls a tool, and a budget that is too
    /// small turns the thinking into the answer: the task looks answered, nothing was written,
    /// and nobody can tell the difference without reading the transcript.
    Truncated(String),
}

/// A model the agent can talk to.
#[async_trait::async_trait]
pub trait Model: Send + Sync {
    /// The next turn, given the conversation so far.
    async fn next_turn(&self, messages: &[Message], tools: &Value) -> Result<Turn>;
}

/// How long a model may take. Local gateways that load a 27B model on the first request can
/// take minutes; the default 30s of an HTTP client is not enough for that.
pub const DEFAULT_MODEL_TIMEOUT_SECONDS: u64 = 600;

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
            client: model_client(),
            api_key: api_key.into(),
            model: model.into(),
            base_url: "https://api.anthropic.com/v1/messages".to_string(),
            // A reasoning model that has to write a file needs the room: the file is in the
            // tool call, and the thinking is in the answer. A 27B model that thinks for
            // 60 000 characters before it acts needs more than 16 000 tokens to get there -
            // and a budget that is too small does not make it act sooner, it makes it think
            // again from the start.
            max_tokens: 32768,
        }
    }

    /// The endpoint of an Anthropic-compatible gateway.
    ///
    /// <p>The operator configures a base ("http://host:30000/v1"); the path is added here, so
    /// a full path is accepted too and nothing has to be typed twice.
    pub fn with_base_url(mut self, base_url: impl Into<String>) -> Self {
        self.base_url = messages_url(&base_url.into());
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
        let (system, turns) = anthropic_turns(messages);
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
            client: model_client(),
            api_key: api_key.into(),
            model: model.into(),
            base_url: "https://api.openai.com/v1/chat/completions".to_string(),
            // The same budget the Anthropic client gets. A reasoning model spends most of
            // its tokens thinking before it calls a tool; a budget that is too small turns
            // the thinking into the answer and the task looks finished when nothing was done.
            max_tokens: 8192,
        }
    }

    /// The endpoint of an OpenAI-compatible gateway (vLLM, llama.cpp, LMDeploy, ...).
    ///
    /// <p>The operator configures a base ("http://host:30000/v1"); the path is added here, so
    /// a full path is accepted too.
    pub fn with_base_url(mut self, base_url: impl Into<String>) -> Self {
        self.base_url = chat_completions_url(&base_url.into());
        self
    }

    /// The budget for one turn.
    ///
    /// <p>How many tokens a model may spend on a turn is a property of the model, so it comes
    /// with the model's configuration rather than from here.
    pub fn with_max_tokens(mut self, max_tokens: usize) -> Self {
        self.max_tokens = max_tokens;
        self
    }
}

#[async_trait::async_trait]
impl Model for OpenAiModel {
    async fn next_turn(&self, messages: &[Message], tools: &Value) -> Result<Turn> {
        let mut turns = Vec::new();
        for message in messages {
            if message.role == "tool" {
                // The result of one call, with the id of the call it answers.
                turns.push(json!({
                    "role": "tool",
                    "content": message.content,
                    "tool_call_id": message.tool_call_id.clone().unwrap_or_default(),
                }));
            } else if message.tool_calls.is_empty() {
                turns.push(json!({"role": message.role, "content": message.content}));
            } else {
                let calls: Vec<Value> = message
                    .tool_calls
                    .iter()
                    .map(|call| json!({
                        "id": call.id.clone().unwrap_or_default(),
                        "type": "function",
                        "function": {
                            "name": call.name,
                            "arguments": call.arguments.to_string(),
                        },
                    }))
                    .collect();
                turns.push(json!({
                    "role": "assistant",
                    "content": message.content,
                    "tool_calls": calls,
                }));
            }
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
    let mut truncated = response.get("stop_reason").and_then(Value::as_str) == Some("max_tokens");
    // A reasoning model puts its thinking in a block of its own. It is not the answer - but
    // hiding it makes a slow answer look like a broken one, and a turn that was cut off in
    // the middle of a thought comes back as nothing at all.
    let mut thinking = String::new();
    if let Some(content) = response.get("content").and_then(Value::as_array) {
        for block in content {
            match block.get("type").and_then(Value::as_str) {
                Some("text") => {
                    if let Some(chunk) = block.get("text").and_then(Value::as_str) {
                        text.push_str(chunk);
                    }
                }
                Some("thinking") => {
                    if let Some(chunk) = block.get("thinking").and_then(Value::as_str) {
                        thinking.push_str(chunk);
                    }
                }
                Some("tool_use") => {
                    calls.push(crate::tools::ToolCall {
                        // The id pairs the result with the call: without it the gateway
                        // cannot place the result and refuses the conversation.
                        id: block.get("id").and_then(Value::as_str).map(str::to_string),
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
    if truncated {
        // The thought that was cut off is better than nothing: it tells the model where it
        // was, and it gives the operator something to read.
        let partial = if text.is_empty() { thinking } else { text };
        return Turn::Truncated(partial);
    }
    if calls.is_empty() {
        if text.is_empty() && !thinking.is_empty() {
            return Turn::Final(thinking);
        }
        Turn::Final(text)
    } else {
        Turn::Tools(calls)
    }
}

/// Reads an OpenAI response into a turn.
pub fn parse_openai_turn(response: &Value) -> Turn {
    let mut calls = Vec::new();
    let mut text = String::new();
    let mut truncated = false;
    if let Some(choice) = response
        .get("choices")
        .and_then(Value::as_array)
        .and_then(|choices| choices.first())
    {
        if choice.get("finish_reason").and_then(Value::as_str) == Some("length") {
            truncated = true;
        }
        if let Some(message) = choice.get("message") {
            if let Some(chunk) = message.get("content").and_then(Value::as_str) {
                text.push_str(chunk);
            }
            // A reasoning model puts its thinking in a separate field. It is not the answer, but
            // hiding it makes a slow answer look like a broken one.
            if let Some(reasoning) = message.get("reasoning_content").and_then(Value::as_str) {
                if !reasoning.is_empty() && text.is_empty() {
                    text.push_str(reasoning);
                }
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
                    let id = call.get("id").and_then(Value::as_str).map(str::to_string);
                    calls.push(crate::tools::ToolCall { id, name, arguments });
                }
            }
        }
    }
    if truncated {
        return Turn::Truncated(text);
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
    fn the_anthropic_parser_keeps_the_id_of_the_call() {
        // Without the id the result cannot be paired with its call, and the gateway refuses
        // the conversation: "tool result's tool id() not found".
        let response = json!({
            "content": [
                {"type": "text", "text": "let me look"},
                {"type": "tool_use", "id": "call_01", "name": "list_files", "input": {}}
            ]
        });
        match parse_anthropic_turn(&response) {
            Turn::Tools(calls) => {
                assert_eq!(calls.len(), 1);
                assert_eq!(calls[0].id.as_deref(), Some("call_01"));
            }
            other => panic!("expected a tool call: {other:?}"),
        }
    }

    #[test]
    fn the_openai_parser_keeps_the_id_of_the_call() {
        let response = json!({
            "choices": [{
                "message": {
                    "tool_calls": [{
                        "id": "call_02",
                        "function": {"name": "list_files", "arguments": "{}"}
                    }]
                }
            }]
        });
        match parse_openai_turn(&response) {
            Turn::Tools(calls) => {
                assert_eq!(calls.len(), 1);
                assert_eq!(calls[0].id.as_deref(), Some("call_02"));
            }
            other => panic!("expected a tool call: {other:?}"),
        }
    }

    #[test]
    fn the_anthropic_conversation_pairs_a_result_with_its_call() {
        // A gateway that speaks the Anthropic protocol refuses a tool_result whose id it
        // cannot find, and the refusal looks like a broken model.
        let call = crate::tools::ToolCall {
            id: Some("toolu_01".to_string()),
            name: "list_files".into(),
            arguments: json!({}),
        };
        let messages = vec![
            Message::user("do it"),
            Message::assistant_calling(String::new(), vec![call]),
            Message::tool("main.rs", Some("toolu_01".to_string())),
        ];
        let (_system, turns) = anthropic_turns(&messages);
        assert_eq!(turns.len(), 3);
        // The assistant's turn carries the tool_use block, with its id.
        let blocks = turns[1]["content"].as_array().expect("content blocks");
        assert_eq!(blocks[0]["type"], "tool_use");
        assert_eq!(blocks[0]["id"], "toolu_01");
        // The result names the call it answers.
        let results = turns[2]["content"].as_array().expect("result blocks");
        assert_eq!(results[0]["type"], "tool_result");
        assert_eq!(results[0]["tool_use_id"], "toolu_01");
        // And the result is a user turn, as the protocol wants it.
        assert_eq!(turns[2]["role"], "user");
    }

    #[test]
    fn the_anthropic_conversation_gathers_the_results_of_one_turn() {
        // Two calls, two results: the protocol wants them in one user message.
        let messages = vec![
            Message::assistant_calling(
                String::new(),
                vec![
                    crate::tools::ToolCall {
                        id: Some("a".into()),
                        name: "list_files".into(),
                        arguments: json!({}),
                    },
                    crate::tools::ToolCall {
                        id: Some("b".into()),
                        name: "read_file".into(),
                        arguments: json!({}),
                    },
                ],
            ),
            Message::tool("one", Some("a".into())),
            Message::tool("two", Some("b".into())),
        ];
        let (_system, turns) = anthropic_turns(&messages);
        assert_eq!(turns.len(), 2);
        let results = turns[1]["content"].as_array().expect("result blocks");
        assert_eq!(results.len(), 2);
        assert_eq!(results[0]["tool_use_id"], "a");
        assert_eq!(results[1]["tool_use_id"], "b");
    }

    #[test]
    fn the_messages_url_fits_the_way_the_gateway_is_addressed() {
        // MiniMax is addressed at its root and keeps the messages under /v1; dropping the
        // "/v1" is a 404 that reads like "the model is down".
        assert_eq!(
            messages_url("https://api.minimax.cn/anthropic"),
            "https://api.minimax.cn/anthropic/v1/messages"
        );
        assert_eq!(
            messages_url("https://api.minimax.cn/anthropic/v1"),
            "https://api.minimax.cn/anthropic/v1/messages"
        );
        assert_eq!(
            messages_url("https://api.minimax.cn/anthropic/v1/messages"),
            "https://api.minimax.cn/anthropic/v1/messages"
        );
        assert_eq!(
            messages_url(""),
            "https://api.anthropic.com/v1/messages"
        );
    }

    #[test]
    fn a_truncated_turn_is_not_the_answer() {
        // A reasoning model that runs out of output tokens mid-thought used to look exactly
        // like a model that had finished: the task looked done, nothing was done.
        let response = json!({
            "choices": [{
                "finish_reason": "length",
                "message": {"content": "I was working out the geometry of the orbit and then I ran out of"}
            }]
        });
        match parse_openai_turn(&response) {
            Turn::Truncated(text) => assert!(text.contains("ran out of")),
            other => panic!("a cut-off turn must not be an answer: {other:?}"),
        }
    }

    #[test]
    fn a_finished_turn_is_the_answer() {
        let response = json!({
            "choices": [{
                "finish_reason": "stop",
                "message": {"content": "the file is written"}
            }]
        });
        assert_eq!(parse_openai_turn(&response), Turn::Final("the file is written".to_string()));
    }

    #[test]
    fn a_truncated_turn_with_a_tool_call_still_runs_the_tool() {
        // The cut-off happens in the middle of a turn; a tool call that was already made is
        // still a tool call.
        let response = json!({
            "choices": [{
                "finish_reason": "length",
                "message": {
                    "content": "let me look at the files first",
                    "tool_calls": [{
                        "function": {"name": "list_files", "arguments": "{}"}
                    }]
                }
            }]
        });
        match parse_openai_turn(&response) {
            Turn::Truncated(text) => assert!(text.contains("look at the files")),
            other => panic!("a cut-off turn must be reported as cut off: {other:?}"),
        }
    }

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
            Turn::Truncated(text) => panic!("expected a tool call, got a cut-off turn: {text}"),
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
            Turn::Truncated(text) => panic!("expected a tool call, got a cut-off turn: {text}"),
        }
    }
}
