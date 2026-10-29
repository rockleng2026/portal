#!/usr/bin/env bash
# =====================================================================================
# Start / stop the harness platform.
#
#   harness-platform.sh start     start it and wait until it answers
#   harness-platform.sh stop      stop it
#   harness-platform.sh restart
#   harness-platform.sh status    is it running, on which port, what is the health
#   harness-platform.sh logs      tail the log
#
# The parameters (including the secrets) live in $HARNESS_ENV_FILE, by default
# ~/.harness/platform.env - outside the repository, mode 0600. Secrets never enter git.
#
# Two ways to run it:
#   * as a systemd **user** service (harness-platform.service) - the normal case;
#   * as a plain background process - the fallback when there is no systemd.
# The script picks the systemd one whenever the unit exists, so the two never fight over
# the port: an instance that loses the port race must not report success just because
# somebody else is answering on that port.
# =====================================================================================
set -euo pipefail

# No external commands here: the systemd unit runs this script with a minimal PATH, and
# "dirname: command not found" is a confusing way to learn that.
SCRIPT_DIR="${BASH_SOURCE[0]%/*}"
[[ "$SCRIPT_DIR" == "${BASH_SOURCE[0]}" ]] && SCRIPT_DIR="."
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="${HARNESS_ENV_FILE:-$HOME/.harness/platform.env}"
RUN_DIR="$HOME/.harness/run"
LOG_FILE="$HOME/.harness/platform.log"
PID_FILE="$RUN_DIR/platform.pid"
UNIT="harness-platform.service"
JAR="$ROOT/harness-platform/target/harness-platform-0.1.0-SNAPSHOT.jar"
EXPLODED="$ROOT/harness-platform/target/exploded"
MAIN_CLASS="com.fuao.harness.platform.PlatformApplication"

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

# The systemd unit exists?
have_unit() {
  command -v systemctl >/dev/null 2>&1 \
    && [[ -f "$HOME/.config/systemd/user/$UNIT" ]] \
    && systemctl --user cat "$UNIT" >/dev/null 2>&1
}

unit_active() {
  have_unit && [[ "$(systemctl --user is-active "$UNIT" 2>/dev/null || true)" == "active" ]]
}

is_running() {
  [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

# Is anybody listening on the port? Prints the owner if we can see it.
port_busy() {
  local port="$1"
  if command -v ss >/dev/null 2>&1; then
    ss -ltnp 2>/dev/null | grep -q ":${port} " && return 0
  elif command -v lsof >/dev/null 2>&1; then
    lsof -iTCP:"$port" -sTCP:LISTEN >/dev/null 2>&1 && return 0
  fi
  return 1
}

healthy() {
  curl -fsS -o /dev/null "http://127.0.0.1:$1/actuator/health" 2>/dev/null
}

# The jar the service runs from. "mvn clean" deletes it, and then the service cannot start
# with a very unhelpful "Unable to access jarfile". So the script builds it when it is missing
# rather than leaving the operator with a log tail and no idea what to do.
ensure_jar() {
  if [[ -f "$JAR" ]]; then
    return 0
  fi
  echo "harness-platform: $JAR is missing; building it"
  if ! command -v mvn >/dev/null 2>&1; then
    echo "harness-platform: mvn is not on the PATH. Put the JDK and Maven on the PATH, or build with:" >&2
    echo "  (cd $ROOT && mvn -B -pl harness-platform -am package -DskipTests)" >&2
    exit 1
  fi
  if ! (cd "$ROOT" && mvn -B -o -q -pl harness-platform -am package -DskipTests); then
    echo "harness-platform: the build failed" >&2
    exit 1
  fi
  if [[ ! -f "$JAR" ]]; then
    echo "harness-platform: the build did not produce $JAR" >&2
    exit 1
  fi
  echo "harness-platform: built"
}

# The platform must not run as a fat jar.
#
# A Spring Boot fat jar keeps its dependencies in BOOT-INF/lib and loads them with its own
# class loader. Threads that Tomcat, Netty or the connection pool create on their own do
# not use that loader, so classes like logback's ThrowableProxy or netty's PoolArena come
# up "not found" - and the thread dies with it. A dead Lettuce event loop means every
# request that touches Redis (the nonce check on every signed call) waits for ever, and the
# browser sees a network error instead of an answer.
#
# So the jar is unpacked and the platform runs with a plain classpath: every class is then
# visible to every thread, whoever created it.
explode() {
  local classpath="$EXPLODED/application/BOOT-INF/classes"
  classpath="$classpath:$EXPLODED/application/BOOT-INF/lib/*:$EXPLODED/dependencies/BOOT-INF/lib/*"
  echo "$classpath"
}

ensure_exploded() {
  ensure_jar
  if [[ -d "$EXPLODED/application/BOOT-INF/classes" && ! "$JAR" -nt "$EXPLODED/.stamp" ]]; then
    return 0
  fi
  rm -rf "$EXPLODED"
  "$JAVA_HOME/bin/java" -Djarmode=layertools -jar "$JAR" extract --destination "$EXPLODED" >/dev/null 2>&1
  if [[ ! -d "$EXPLODED/application/BOOT-INF/classes" ]]; then
    echo "harness-platform: cannot unpack $JAR" >&2
    exit 1
  fi
  touch "$EXPLODED/.stamp"
}

run() {
  load_env
  ensure_exploded
  exec "$JAVA_HOME/bin/java" -cp "$(explode)" "$MAIN_CLASS" "$@"
}

start() {
  load_env
  ensure_jar
  local port="${HARNESS_PORT:-8080}"

  if have_unit; then
    systemctl --user start "$UNIT" 2>/dev/null || true
    for _ in $(seq 1 120); do
      if unit_active && healthy "$port"; then
        echo "harness-platform: up on port ${port} (systemd user service), log: $LOG_FILE"
        return 0
      fi
      sleep 1
    done
    echo "harness-platform: the systemd service did not come up." >&2
    echo "  last lines of $LOG_FILE:" >&2
    tail -20 "$LOG_FILE" >&2
    echo "  if the jar is missing: (cd $ROOT && mvn -B -pl harness-platform -am package -DskipTests)" >&2
    return 1
  fi

  if is_running; then
    echo "harness-platform: already running (pid $(cat "$PID_FILE"))"
    return 0
  fi
  if [[ ! -f "$JAR" ]]; then
    echo "harness-platform: $JAR is missing. Build it: (cd $ROOT && mvn -B clean package)" >&2
    exit 1
  fi
  if port_busy "$port"; then
    echo "harness-platform: port ${port} is already in use by another process." >&2
    echo "  Find it:   ss -ltnp | grep ${port}" >&2
    echo "  If that is the systemd service, use: systemctl --user stop ${UNIT}" >&2
    echo "  If it is a stale instance, use:  ${0##*/} stop" >&2
    exit 1
  fi

  ensure_exploded
  mkdir -p "$RUN_DIR" "$(dirname "$LOG_FILE")"
  setsid nohup "$JAVA_HOME/bin/java" -cp "$(explode)" "$MAIN_CLASS" >>"$LOG_FILE" 2>&1 </dev/null &
  local pid=$!
  echo "$pid" > "$PID_FILE"

  # The health check alone proves nothing: another process may be answering on that port.
  # Our own process has to still be alive *and* the port has to answer.
  for _ in $(seq 1 60); do
    if ! kill -0 "$pid" 2>/dev/null; then
      rm -f "$PID_FILE"
      echo "harness-platform: the process exited during startup; last lines of $LOG_FILE:" >&2
      tail -20 "$LOG_FILE" >&2
      exit 1
    fi
    if healthy "$port"; then
      echo "harness-platform: up on port ${port} (pid ${pid}), log: $LOG_FILE"
      return 0
    fi
    sleep 1
  done
  echo "harness-platform: did not come up within 60s; last lines of $LOG_FILE:" >&2
  tail -20 "$LOG_FILE" >&2
  exit 1
}

stop() {
  if have_unit; then
    systemctl --user stop "$UNIT" 2>/dev/null || true
    echo "harness-platform: stopped (systemd user service)"
    rm -f "$PID_FILE"
    return 0
  fi
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
  if have_unit; then
    local state
    state="$(systemctl --user is-active "$UNIT" 2>/dev/null || true)"
    echo "harness-platform: systemd user service is ${state} (port ${port})"
    if [[ "$state" == "active" ]]; then
      curl -fsS "http://127.0.0.1:${port}/actuator/health" && echo
    fi
  elif is_running; then
    echo "harness-platform: running (pid $(cat "$PID_FILE")) on port ${port}"
    curl -fsS "http://127.0.0.1:${port}/actuator/health" && echo
  else
    echo "harness-platform: not running"
  fi
}

case "${1:-status}" in
  run) shift; run "$@" ;;
  start) start ;;
  stop) stop ;;
  restart) stop; start ;;
  status) status ;;
  logs) tail -f "$LOG_FILE" ;;
  *) echo "usage: ${0##*/} {start|stop|restart|status|logs|run}" >&2; exit 2 ;;
esac
