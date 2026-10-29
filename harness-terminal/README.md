# harness-agent — 终端（设备侧 + 智能体）

> **一个二进制**。设备侧（身份、报到、绑定码、授权交接、心跳）和干活的智能体
> （上下文、工具、验证循环）都在这里。目标机器只需要这一个文件，**不需要 Java**。
>
> ```bash
> harness-agent device hello        # 报到，拿绑定码（10 分钟有效）
> harness-agent device grant        # 取回平台给的授权
> harness-agent device heartbeat   # 心跳
> harness-agent device status      # 平台现在允许什么
> harness-agent serve              # 智能体常驻，接管理台的活
> ```
>
> 安装包：`harness/tools/install-terminal.sh bundle <目录>`

> 这是"第一版功能"里那个 Rust 工程的**完成版**。它不是终端的设备外壳（那是
> `harness/harness-terminal`，Java，负责设备身份 / 绑定码 / 心跳 / 本地策略），
> 而是真正在机器上**干活**的那个智能体：收集上下文 → 动手 → 验证 → 再动手。

## 它做什么

| 能力 | 实现 |
|---|---|
| **收集上下文** | 走遍工作区（识别 40+ 种语言、按语言统计、体积过滤、忽略噪声目录），把任务相关的文件打进一个预算内的"上下文包" |
| **动手** | 工具集：读文件 / 写文件 / 精确编辑 / 列目录 / 搜索代码 / 执行 Shell / 跑测试 / git 状态 / git 提交 |
| **验证结果** | 工具返回**原样**的输出（编译错误、测试输出、diff），智能体据此决定下一步 |
| **循环** | `模型 → 工具调用 → 策略检查 → 执行 → 结果回灌模型 → …`，直到模型说完成、步骤预算用完或上下文预算用完 |
| **扩展** | 技能（SKILL.md + scripts/）与 MCP（stdio JSON-RPC）都是插件：加一个目录或起一个 MCP server 就能接入新能力 |
| **多模型** | Anthropic Messages API、OpenAI chat-completions，或 `scripted`（离线回放，用于测试） |

## 授权从哪来：平台 → 外壳 → 智能体

智能体的能力集**不是自己定的**：

```
平台 harness_grant ──HMAC──▶ Java 设备外壳 ──写 grant.json(0600)──▶ 本智能体
   （唯一权威）              （取回 + 落地）              （读同一份文件并执行）
```

```bash
# 外壳取回授权（一次性）
java -jar harness-terminal.jar grant

# 智能体带 --identity 启动 → 以 grant 为准；没有 grant 就什么都不能做
harness-agent run "..." --workspace /path/to/repo --identity ~/.harness/terminal
```

不给 `--identity` 是"有人坐在机器前"的独立运行模式，命令行会明说
`standalone: no platform grant, the command line decides`。

授权文件里只有能力集、自治等级和允许的根目录，**没有审批令牌**——审批是给单条命令签的，
跟着命令走，绝不预先分发。

## 和普通 coding agent 的区别：它受治理约束

这是本项目最重要的一点。智能体**不是**权限主体：

* 每次工具调用先过 `policy::LocalPolicy`——能力是否授予、自治等级是否够、路径是否在允许的根目录内、
  破坏性操作是否有**绑定到本次命令与路径**的人工审批令牌；
* 平台被攻破、边缘层撒谎、工具参数被投毒，都**绕不过**本地的拒绝规则（red-team R-01）；
* 技能与 MCP 是**内容**，不是授权：它们只能告诉智能体"该做什么"，动作仍然逐个过策略；
* MCP server **不能自授能力**：每个 MCP 工具映射到一个 `cap:mcp.<server>.<tool>`，没映射就没有。

## 目录

```
src/
├── lib.rs            库的说明与公开接口
├── workspace.rs      工作区：遍历、语言识别、路径归一
├── policy.rs         本地策略：能力 / 等级 / 路径白名单 / 审批令牌
├── tools/
│   ├── mod.rs        Tool trait、注册表、调度（策略检查在这里）
│   ├── fs_ops.rs     读 / 写 / 精确编辑 / 删除 / 列目录 / 搜索
│   └── exec.rs       Shell / 测试 / git
├── agent/mod.rs      智能体循环与上下文打包
├── model/mod.rs      Anthropic / OpenAI / Scripted
├── skills/mod.rs     技能加载（SKILL.md frontmatter）
├── mcp/mod.rs        MCP stdio 客户端
└── cli.rs            命令行
```

## 构建与测试

```bash
cargo build --release
cargo test           # 38 tests
```

## 用法

```bash
# 看一眼智能体会看到什么：工作区、语言统计、技能
harness-agent inspect --workspace /path/to/repo --skills ~/.harness/skills

# 工具清单（模型看到的就是这个）
harness-agent tools

# 真正跑一个任务
export HARNESS_MODEL_API_KEY=...
harness-agent run "修复登录接口的空指针，并让测试通过" \
    --workspace /path/to/repo \
    --provider anthropic \
    --model claude-sonnet-4-5 \
    --autonomy 2 \
    --allowed-root /path/to/repo \
    --transcript /tmp/trace.jsonl

# 不接模型，回放一段脚本（用来测循环本身）
harness-agent replay --script turns.json --workspace /path/to/repo
```

`turns.json` 的形状：

```json
[
  {"tools": [{"name": "list_files", "arguments": {}}]},
  {"tools": [{"name": "read_file", "arguments": {"path": "src/app.rs"}}]},
  {"final": "我看完了，问题在 src/app.rs:12。"}
]
```

## 技能

一个技能就是一个目录：

```
~/.harness/skills/release-check/
├── SKILL.md          # frontmatter: name / description，正文是步骤
└── scripts/check.sh  # 可选：随技能附带的脚本
```

技能按任务描述匹配后进入系统提示。**frontmatter 坏了会报错，不会被静默忽略**——
一份读不懂的技能等于没有。

## MCP

```rust
let mut server = McpServer::start("gitlab", PathBuf::from("gitlab-mcp"), &[], "cap:mcp.gitlab.").await?;
server.call("list_issues", &json!({"project": "core"})).await?;
```

握手是 `initialize` → `tools/list`，之后每个工具调用都经过策略。
