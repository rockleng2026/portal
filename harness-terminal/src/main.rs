//! The harness terminal agent.
//!
//! See `lib.rs` for what this is. The binary is a thin shell around the library: everything
//! worth testing lives in the library, and the CLI only wires things together.

#[tokio::main]
async fn main() {
    if let Err(error) = harness_agent::cli::main().await {
        eprintln!("harness-agent: {error:#}");
        std::process::exit(1);
    }
}
