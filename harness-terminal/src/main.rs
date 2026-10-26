use clap::{App, Arg, Subcommand};
use tracing_subscriber::EnvFilter;
use tracing::{info, error, warn, debug};
use pymysql::*;
use rand::Rng;
use hmac::{Hmac, Mac};
use sha2::Sha256;

fn setup_logging() {
    // 初始化结构化日志，输出到 stderr，带时间戳和模块信息
    tracing_subscriber::fmt()
        .with_env_filter(EnvFilter::from_default_env())
        .init();
}

/// 查询 terminal 当前状态
async fn cmd_status() {
    info!("=== Harness Terminal Status ===");

    // 连接 harness_terminal 数据库
    let conn = connect(
        host = "localhost",
        user = "root",
        password = "Leng@mysqlOk",
        db = "harness_terminal",
        charset = "utf8mb4"
    ).await;

    match conn {
        Ok(mut conn) => {
            // 查询 terminal 记录
            let rows = query_desc(
                &mut conn,
                "SELECT terminal_id, status, bound_at, revoked_at, created_at FROM harness_terminal LIMIT 1"
            ).await;

            match rows {
                Ok(result) => {
                    if let Some(term) = result.fetch_one().await {
                        info!("Terminal ID: {}", term.get::<_, String>("terminal_id"));
                        info!("Status: {}", term.get::<_, String>("status"));
                        info!("Bound at: {}", term.get::<_, i64>("bound_at"));
                        info!("Revoked at: {}", term.get::<_, Option<i64>("revoked_at"));
                        info!("Created at: {}", term.get::<_, i64>("created_at"));
                    } else {
                        info!("No terminal records found in harness_terminal database");
                    }
                }
                Err(e) => error!("DB query failed: {}", e),
            }

            // 查询绑定码统计
            let codes_query = query_desc(
                &mut conn,
                "SELECT status, COUNT(*) as count FROM harness_binding_codes GROUP BY status"
            ).await;

            if let Ok(codes) = codes_query {
                if let Some(row) = codes.fetch_one().await {
                    let status_val: String = row.get("status");
                    let count: i64 = row.get("count");
                    info!("Binding codes - Status: {}, Count: {}", status_val, count);
                }
            }
        }
        Err(e) => error!("Failed to connect to harness_terminal DB: {}", e),
    }
}

/// 发送一次心跳探活
async fn cmd_heartbeat() {
    info!("=== Harness Terminal Heartbeat ===");
    info!("Heartbeat sent successfully (simulated)");

    // 可选：实际写入数据库更新 last heartbeat
    // let conn = connect(...).await;
    // let _ = exec_excl(&mut conn, "UPDATE harness_terminal SET updated_at = NOW() WHERE ...").await;
}

/// 生成绑定码 (改进版，集成数据库)
async fn cmd_gen_code() {
    info!("=== Generate Binding Code ===");

    // 生成随机密钥和 HMAC code_hash
    let mut rng = rand::thread_rng();
    let key: [u8; 16] = rng.gen();

    let mut mac: Hmac<Sha256> = Mac::new_from_slice(&key).unwrap();
    mac.update(b"harness-terminal-boundary").unwrap();
    let result = mac.finalize();
    let code_hash = format!("{:x}", result.into_bytes());

    // 构造 terminal_id
    let terminal_id = format!("terminal-{:03x}", rng.gen::<u32>() % 10000);

    // 计算过期时间 (24小时后)
    let expires_at = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_secs() + 86400;

    // 写入 harness_binding_codes 表
    let conn = connect(
        host = "localhost",
        user = "root",
        password = "Leng@mysqlOk",
        db = "harness_terminal",
        charset = "utf8mb4"
    ).await;

    match conn {
        Ok(mut conn) => {
            let affected = exec_excl(
                &mut conn,
                "INSERT INTO harness_binding_codes (code_hash, terminal_id, status, expires_at) VALUES (?, ?, 'available', ?)",
                params![code_hash, terminal_id, expires_at]
            ).await;

            match affected {
                Ok(_) => {
                    info!("Binding code generated successfully!");
                    info!("Code hash: {}", code_hash);
                    info!("Terminal ID: {}", terminal_id);
                    info!("Expires at: {} seconds from now", expires_at - std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).unwrap().as_secs());
                    info!("Use: harness-terminal --bind-code {}", code_hash);
                }
                Err(e) => error!("Failed to insert binding code: {}", e),
            }
        }
        Err(e) => error!("Failed to connect to DB: {}", e),
    }
}

/// 执行指定任务
async fn cmd_execute() {
    info!("=== Execute Task ===");
    info!("Task execution mode: simulation");
    info!("Use harness API for actual task execution.");
    info!("Example: harness-api exec <mission_id>");
}

/// 显示配置信息
async fn cmd_config() {
    info!("=== Harness Terminal Config ===");
    info!("Configuration displayed above.");
    info!("Database: harness_terminal");
    info!("Terminal ID format: terminal-XXXX");
    info!("Binding code TTL: 24 hours");
}

async fn run_install_wizard() {
    info!("=== Harness Terminal Installation Wizard ===");
    info!("This wizard will guide you through the terminal installation process.");

    // TODO: 后续阶段实现实际的安装逻辑
    // - 收集企业信息、部门、责任人等
    // - 生成安装配置文件
    // - 下载并验证二进制包
    // - 写入系统服务/启动项

    info!("Installation wizard completed.");
    info!("Next steps:");
    info!("  1. Run 'harness-terminal --status' to check status");
    info!("  2. Run 'harness-terminal --gen-code' to generate a binding code");
    info!("  3. Run 'harness-terminal --heartbeat' to send a heartbeat");
    info!("  4. Run 'harness-terminal --execute' to execute a task");
}

#[tokio::main]
async fn main() {
    setup_logging();

    let matches = App::new("Harness Terminal")
        .version("0.1.0")
        .about("Agent Terminal Install & Bind - Rust implementation with CLI")
        .author("Harness System")
        .subcommand(Subcommand::new("status").about("Query terminal status"))
        .subcommand(Subcommand::new("heartbeat").about("Send a heartbeat"))
        .subcommand(Subcommand::new("gen-code").about("Generate a binding code"))
        .subcommand(Subcommand::new("execute").about("Execute a task"))
        .subcommand(Subcommand::new("config").about("Display configuration"))
        .get_matches();

    if matches.is_present("install") {
        run_install_wizard().await;
    } else if let Some(matches) = matches.subcommand_matches("status") {
        cmd_status().await;
    } else if let Some(matches) = matches.subcommand_matches("heartbeat") {
        cmd_heartbeat().await;
    } else if let Some(matches) = matches.subcommand_matches("gen-code") {
        cmd_gen_code().await;
    } else if let Some(matches) = matches.subcommand_matches("execute") {
        cmd_execute().await;
    } else if let Some(matches) = matches.subcommand_matches("config") {
        cmd_config().await;
    } else if matches.is_present("install") {
        info!("Binding code generation not yet implemented in Phase 1");
        info!("Use: harness-terminal --install first, then use CLI commands");
    } else {
        // 无参数：显示帮助
        App::print_help(&std::io::stdout(), &App::new("Harness Terminal"))
            .unwrap_or_else(|e| error!("Failed to print help: {}", e));
        std::process::exit(1);
    }
}