//! MCP: tools from outside, spoken over the Model Context Protocol.
//!
//! An MCP server is a program that speaks JSON-RPC 2.0 over stdio. The agent connects to it,
//! asks what tools it has, and calls them. The point is that a capability the harness has
//! never heard of becomes usable without touching the agent's code - which is exactly the
//! extension point the requirement asks for.
//!
//! The security consequence is the same as for any other tool, and it is handled the same way:
//! **an MCP tool is a tool**. Its calls go through the policy like the built-in ones, and a
//! server cannot grant itself a capability.

use crate::policy::AutonomyLevel;
use crate::tools::{Tool, ToolContext, ToolResult};
use anyhow::{anyhow, Context, Result};
use serde_json::{json, Value};
use std::collections::BTreeMap;
use std::io::{BufRead, BufReader, Write};
use std::path::PathBuf;
use std::process::{Child, ChildStdin, ChildStdout, Command, Stdio};

/// A running MCP server.
pub struct McpServer {
    name: String,
    child: Child,
    stdin: ChildStdin,
    stdout: BufReader<ChildStdout>,
    next_id: i64,
    /// The tools the server offers, keyed by name.
    tools: BTreeMap<String, McpTool>,
}

/// A tool an MCP server offers.
#[derive(Debug, Clone)]
pub struct McpTool {
    pub name: String,
    pub description: String,
    pub input_schema: Value,
    /// The capability key the harness maps this tool to. An MCP tool that maps to nothing is
    /// not usable - the server cannot hand out authority.
    pub cap_key: String,
    pub min_level: AutonomyLevel,
}

impl McpServer {
    /// Starts a server and asks it what it can do.
    ///
    /// `cap_prefix` is prepended to the tool names to build the capability keys, e.g.
    /// `cap:mcp.gitlab.` + `list_issues` = `cap:mcp.gitlab.list_issues`.
    pub async fn start(
        name: impl Into<String>,
        command: PathBuf,
        args: &[String],
        cap_prefix: &str,
    ) -> Result<Self> {
        let name = name.into();
        let mut child = Command::new(&command)
            .args(args)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::null())
            .spawn()
            .with_context(|| format!("cannot start MCP server {}", command.display()))?;
        let stdin = child.stdin.take().expect("mcp stdin");
        let stdout = BufReader::new(child.stdout.take().expect("mcp stdout"));

        let mut server = McpServer {
            name,
            child,
            stdin,
            stdout,
            next_id: 0,
            tools: BTreeMap::new(),
        };
        server.initialize().await?;
        server.list_tools(cap_prefix).await?;
        Ok(server)
    }

    /// The MCP handshake.
    async fn initialize(&mut self) -> Result<()> {
        let response = self
            .request(
                "initialize",
                json!({
                    "protocolVersion": "2024-11-05",
                    "capabilities": {"tools": {}},
                    "clientInfo": {"name": "harness-agent", "version": "0.1.0"},
                }),
            )
            .await?;
        if response.get("error").is_some() {
            return Err(anyhow!("the MCP server refused the handshake"));
        }
        Ok(())
    }

    /// Asks the server which tools it has.
    async fn list_tools(&mut self, cap_prefix: &str) -> Result<()> {
        let response = self.request("tools/list", json!({})).await?;
        let tools = response
            .get("result")
            .and_then(|r| r.get("tools"))
            .and_then(Value::as_array)
            .cloned()
            .unwrap_or_default();
        for tool in tools {
            let name = tool
                .get("name")
                .and_then(Value::as_str)
                .unwrap_or_default()
                .to_string();
            if name.is_empty() {
                continue;
            }
            let description = tool
                .get("description")
                .and_then(Value::as_str)
                .unwrap_or_default()
                .to_string();
            let input_schema = tool
                .get("inputSchema")
                .cloned()
                .unwrap_or_else(|| json!({"type": "object"}));
            self.tools.insert(
                name.clone(),
                McpTool {
                    name,
                    description,
                    input_schema,
                    cap_key: format!("{cap_prefix}{}", tool_name(&tool)),
                    min_level: AutonomyLevel::L2,
                },
            );
        }
        Ok(())
    }

    /// Calls a tool on the server.
    pub async fn call(&mut self, tool: &str, arguments: &Value) -> Result<Value> {
        let response = self
            .request(
                "tools/call",
                json!({"name": tool, "arguments": arguments}),
            )
            .await?;
        if let Some(error) = response.get("error") {
            return Err(anyhow!("MCP call failed: {error}"));
        }
        Ok(response.get("result").cloned().unwrap_or(Value::Null))
    }

    /// Sends a JSON-RPC request and reads the answer.
    async fn request(&mut self, method: &str, params: Value) -> Result<Value> {
        self.next_id += 1;
        let id = self.next_id;
        let message = json!({
            "jsonrpc": "2.0",
            "id": id,
            "method": method,
            "params": params,
        });
        let line = serde_json::to_string(&message)?;
        self.stdin.write_all(line.as_bytes())?;
        self.stdin.write_all(b"\n")?;
        self.stdin.flush()?;

        loop {
            let mut buffer = String::new();
            let read = self.stdout.read_line(&mut buffer)?;
            if read == 0 {
                return Err(anyhow!("the MCP server closed the connection"));
            }
            let trimmed = buffer.trim();
            if trimmed.is_empty() {
                continue;
            }
            let value: Value = serde_json::from_str(trimmed)
                .with_context(|| format!("the MCP server sent something that is not JSON: {trimmed}"))?;
            if value.get("id").and_then(Value::as_i64) == Some(id) {
                return Ok(value);
            }
            // Notifications and answers to other requests are ignored.
        }
    }

    /// The tools this server offers.
    pub fn tools(&self) -> &BTreeMap<String, McpTool> {
        &self.tools
    }

    /// The server's name.
    pub fn name(&self) -> &str {
        &self.name
    }

    /// Stops the server.
    pub fn shutdown(&mut self) {
        let _ = self.child.kill();
    }
}

/// The capability suffix of an MCP tool.
///
/// MCP tool names often look like `server__tool`; the harness maps the tool part onto a
/// capability, and the server part identifies where it came from.
pub fn tool_name(tool: &Value) -> &str {
    let name = tool.get("name").and_then(Value::as_str).unwrap_or_default();
    match name.split_once("__") {
        Some((_, rest)) => rest,
        None => name,
    }
}

/// Wraps an MCP tool so the agent can call it like any other tool.
pub struct McpToolAdapter {
    pub server: String,
    pub tool: McpTool,
}

impl Tool for McpToolAdapter {
    fn name(&self) -> &str {
        &self.tool.name
    }

    fn description(&self) -> &str {
        &self.tool.description
    }

    fn schema(&self) -> Value {
        self.tool.input_schema.clone()
    }

    fn capability(&self) -> Option<&'static str> {
        None
    }

    fn min_level(&self) -> AutonomyLevel {
        self.tool.min_level
    }

    fn run(&self, _context: &ToolContext, _arguments: &Value) -> Result<ToolResult> {
        // The call itself is made by the MCP session, which owns the process. The adapter
        // exists so the catalogue and the policy see the tool; the session does the work.
        Ok(ToolResult::failure(
            &self.tool.name,
            "MCP_SESSION_REQUIRED",
            format!(
                "the MCP tool {} on {} is called through its session",
                self.tool.name, self.server
            ),
        ))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn splits_a_namespaced_tool_name() {
        let tool = json!({"name": "gitlab__list_issues"});
        assert_eq!(tool_name(&tool), "list_issues");
        let plain = json!({"name": "list_issues"});
        assert_eq!(tool_name(&plain), "list_issues");
    }

    #[tokio::test]
    async fn talks_to_a_server_over_stdio() {
        // A tiny MCP server, written as a shell script, so the handshake is exercised for
        // real rather than mocked.
        let dir = tempfile::tempdir().unwrap();
        let script = dir.path().join("server.sh");
        std::fs::write(
            &script,
            r#"#!/bin/sh
while IFS= read -r line; do
  case "$line" in
    *'"initialize"'*) printf '%s\n' '{"jsonrpc":"2.0","id":1,"result":{"protocolVersion":"2024-11-05"}}' ;;
    *'"tools/list"'*) printf '%s\n' '{"jsonrpc":"2.0","id":2,"result":{"tools":[{"name":"demo__echo","description":"echo","inputSchema":{"type":"object"}}]}}' ;;
    *) printf '%s\n' '{"jsonrpc":"2.0","id":9,"result":{}}' ;;
  esac
done
"#,
        )
        .unwrap();
        #[cfg(unix)]
        {
            use std::os::unix::fs::PermissionsExt;
            std::fs::set_permissions(&script, std::fs::Permissions::from_mode(0o755)).unwrap();
        }
        let mut server = McpServer::start(
            "demo",
            script,
            &[],
            "cap:mcp.demo.",
        )
        .await
        .unwrap();
        assert_eq!(server.tools().len(), 1);
        let tool = server.tools().get("demo__echo").unwrap();
        assert_eq!(tool.cap_key, "cap:mcp.demo.echo");
        assert_eq!(tool.description, "echo");
        server.shutdown();
    }
}
