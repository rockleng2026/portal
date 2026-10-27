#!/usr/bin/env bash
# =====================================================================================
# Start / stop the harness platform.
#
#   harness-platform.sh start     start in the background, wait until it answers
#   harness-platform.sh stop      stop it
#   harness-platform.sh status    is it running, what port, what is the health
#   harness-platform.sh restart
#   harness-platform.sh logs      tail the log
#
# The parameters (including the secrets) live in $HARNESS_ENV_FILE, by default
# ~/.harness/platform.env - outside the repository, mode 0600. Secrets never enter git.
# =====================================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${HARNESS_ENV_FILE:-$HOME/.harness/platform.env}"
RUN_DIR="$HOME/.harness/run"
LOG_FILE="$HOME/.harness/platform.log"
PID_FILE="$RUN_DIR/platform.pid"
JAR="$ROOT/harness-platform/target/harness-platform-0.1.0-SNAPSHOT.jar"

load_env() {
  if [[ ! -f "$ENV_FILE" ]]; then
    echo "harness-platform: no $ENV_FILE. Create it first (see deliverable/09-本地部署与验证手册.md)." >&2
    exit 2
  fi
  # The file uses plain VAR=value (systemd's EnvironmentFile syntax), so it has to be
  # sourced with auto-export on: the variables have to reach the java process.
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
}

port_of() {
  load_env
  echo "${HARNESS_PORT:-8080}"
}

is_running() {
  [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

start() {
  load_env
  if is_running; then
    echo "harness-platform: already running (pid $(cat "$PID_FILE"))"
    return 0
  fi
  if [[ ! -f "$JAR" ]]; then
    echo "harness-platform: $JAR is missing. Build it: (cd $ROOT && mvn -B clean package)" >&2
    exit 1
  fi
  mkdir -p "$RUN_DIR" "$(dirname "$LOG_FILE")"
  setsid nohup "$JAVA_HOME/bin/java" -jar "$JAR" >"$LOG_FILE" 2>&1 </dev/null &
  echo $! > "$PID_FILE"

  local port="${HARNESS_PORT:-8080}"
  for _ in $(seq 1 60); do
    if curl -fsS -o /dev/null "http://127.0.0.1:${port}/actuator/health" 2>/dev/null; then
      echo "harness-platform: up on port ${port} (pid $(cat "$PID_FILE")), log: $LOG_FILE"
      return 0
    fi
    sleep 1
  done
  echo "harness-platform: did not come up within 60s; last lines of $LOG_FILE:" >&2
  tail -20 "$LOG_FILE" >&2
  exit 1
}

stop() {
  if ! is_running; then
    echo "harness-platform: not running"
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
  echo "harness-platform: stopped"
}

status() {
  local port
  port="$(port_of)"
  if is_running; then
    echo "harness-platform: running (pid $(cat "$PID_FILE")) on port ${port}"
    curl -fsS "http://127.0.0.1:${port}/actuator/health" && echo
  else
    echo "harness-platform: not running"
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
