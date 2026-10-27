#!/usr/bin/env bash
# =====================================================================================
# Start / stop the terminal agent (the one that serves the console).
#
#   harness-agent.sh start     start in the background, wait until it is polling
#   harness-agent.sh stop      stop it
#   harness-agent.sh restart
#   harness-agent.sh status    is it running, what is it serving
#   harness-agent.sh logs      tail the log
#
# The agent needs:
#   --config  the terminal's configuration (platform.url, client.id, secret, terminal.id)
#   --identity the directory with the device identity and the grant
#   --workspace the directory the agent may work in
#
# A model is optional: without HARNESS_MODEL_API_KEY a request is executed as a command
# (still under the terminal's policy) instead of being answered by a model.
# =====================================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENT_BIN="${HARNESS_AGENT_BIN:-$ROOT/../harness-terminal/target/release/harness-agent}"
RUN_DIR="$HOME/.harness/run"
LOG_FILE="$HOME/.harness/agent.log"
PID_FILE="$RUN_DIR/agent.pid"
WORKSPACE="${HARNESS_AGENT_WORKSPACE:-$HOME/.harness/terminal/repo}"
IDENTITY="${HARNESS_AGENT_IDENTITY:-$HOME/.harness/terminal/identity}"
CONFIG="${HARNESS_AGENT_CONFIG:-$HOME/.harness/terminal/terminal.properties}"

is_running() {
  [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

start() {
  if is_running; then
    echo "harness-agent: already running (pid $(cat "$PID_FILE"))"
    return 0
  fi
  if [[ ! -x "$AGENT_BIN" ]]; then
    echo "harness-agent: $AGENT_BIN is missing. Build it: (cd $ROOT/../harness-terminal && cargo build --release)" >&2
    exit 1
  fi
  mkdir -p "$RUN_DIR" "$(dirname "$LOG_FILE")"
  setsid nohup "$AGENT_BIN" serve \
    --workspace "$WORKSPACE" --identity "$IDENTITY" --config "$CONFIG" \
    >>"$LOG_FILE" 2>&1 </dev/null &
  local pid=$!
  echo "$pid" > "$PID_FILE"

  # The agent prints its banner when it is up. If the process dies, it never will.
  for _ in $(seq 1 30); do
    if ! kill -0 "$pid" 2>/dev/null; then
      rm -f "$PID_FILE"
      echo "harness-agent: the process exited; last lines of $LOG_FILE:" >&2
      tail -20 "$LOG_FILE" >&2
      exit 1
    fi
    if grep -q "serving terminal" "$LOG_FILE" 2>/dev/null; then
      echo "harness-agent: up (pid ${pid}), log: $LOG_FILE"
      return 0
    fi
    sleep 1
  done
  echo "harness-agent: did not report itself ready; last lines of $LOG_FILE:" >&2
  tail -20 "$LOG_FILE" >&2
  exit 1
}

stop() {
  if ! is_running; then
    echo "harness-agent: not running"
    rm -f "$PID_FILE"
    return 0
  fi
  local pid
  pid="$(cat "$PID_FILE")"
  kill "$pid" 2>/dev/null || true
  for _ in $(seq 1 20); do
    kill -0 "$pid" 2>/dev/null || break
    sleep 0.5
  done
  kill -9 "$pid" 2>/dev/null || true
  rm -f "$PID_FILE"
  echo "harness-agent: stopped"
}

status() {
  if is_running; then
    echo "harness-agent: running (pid $(cat "$PID_FILE"))"
    tail -3 "$LOG_FILE" 2>/dev/null || true
  else
    echo "harness-agent: not running"
  fi
}

case "${1:-status}" in
  start) start ;;
  stop) stop ;;
  restart) stop; start ;;
  status) status ;;
  logs) tail -f "$LOG_FILE" ;;
  *) echo "usage: $(basename "$0") {start|stop|restart|status|logs}" >&2; exit 2 ;;
esac
