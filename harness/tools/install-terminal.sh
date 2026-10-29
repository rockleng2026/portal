#!/usr/bin/env bash
# =====================================================================================
# Install the harness terminal on a machine.
#
# Two modes:
#
#   On the build machine - make a bundle to copy over:
#     ./harness/tools/install-terminal.sh bundle /tmp/harness-terminal
#
#   On the target machine - install it:
#     ./install.sh --platform http://platform:18080 --agent-key agent:leon:sales:sh001 \
#                  --client-id harness-bootstrap --client-secret <secret>
#
# What it installs:
#   <install-dir>/harness-terminal.jar   the device shell (Java 6 class files)
#   <install-dir>/harness-agent          the agent runtime (a single binary)
#   ~/.harness/terminal/                 the configuration, the device identity and the grant
#   a systemd user service                the agent, serving the console
#
# The device identity is generated on the target machine and never leaves it. The agent asks
# the platform for what it may do; it does not decide that for itself.
# =====================================================================================
set -euo pipefail

BUNDLE_DIR="${HARNESS_BUNDLE_DIR:-$PWD/harness-terminal-bundle}"
INSTALL_DIR="${HARNESS_INSTALL_DIR:-$HOME/.harness/terminal}"
PLATFORM_URL=""
AGENT_KEY=""
CLIENT_ID="harness-bootstrap"
CLIENT_SECRET=""
WORKSPACE=""
NO_SERVICE=0
MODE="install"

usage() {
  sed -n '2,25p' "$0" | sed 's/^# \{0,1\}//'
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    bundle) MODE="bundle"; shift ;;
    install) MODE="install"; shift ;;
    --platform) PLATFORM_URL="$2"; shift 2 ;;
    --agent-key) AGENT_KEY="$2"; shift 2 ;;
    --client-id) CLIENT_ID="$2"; shift 2 ;;
    --client-secret) CLIENT_SECRET="$2"; shift 2 ;;
    --install-dir) INSTALL_DIR="$2"; shift 2 ;;
    --workspace) WORKSPACE="$2"; shift 2 ;;
    --no-service) NO_SERVICE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) POSITIONAL+=("$1"); shift ;;
  esac
done
if [[ ${#POSITIONAL[@]} -gt 0 ]]; then
  BUNDLE_DIR="${POSITIONAL[0]}"
fi

# ---------------------------------------------------------------- the bundle
if [[ "$MODE" == "bundle" ]]; then
  REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
  JAR="$REPO/harness/harness-terminal/target/harness-terminal-0.1.0-SNAPSHOT.jar"
  AGENT="$REPO/harness-terminal/target/release/harness-agent"
  if [[ ! -f "$JAR" ]]; then
    echo "install-terminal: $JAR is missing. Build it: (cd $REPO/harness && mvn -B -pl harness-terminal -am package)" >&2
    exit 1
  fi
  if [[ ! -x "$AGENT" ]]; then
    echo "install-terminal: $AGENT is missing. Build it: (cd $REPO/harness-terminal && cargo build --release)" >&2
    exit 1
  fi
  rm -rf "$BUNDLE_DIR"
  mkdir -p "$BUNDLE_DIR"
  cp "$JAR" "$BUNDLE_DIR/harness-terminal.jar"
  cp "$AGENT" "$BUNDLE_DIR/harness-agent"
  cp "${BASH_SOURCE[0]}" "$BUNDLE_DIR/install.sh"
  chmod +x "$BUNDLE_DIR/install.sh" "$BUNDLE_DIR/harness-agent"
  cat > "$BUNDLE_DIR/README.md" <<'EOF'
# Harness 终端安装包

## 这台机器上要做什么

1. 装 Java（终端外壳是 Java 6 的 class，Java 8 及以上都能跑）：
   ```bash
   sudo apt-get update && sudo apt-get install -y openjdk-17-jre-headless
   ```
2. 解压并安装：
   ```bash
   tar xzf harness-terminal-bundle.tar.gz
   cd harness-terminal-bundle
   ./install.sh --platform http://<平台地址>:18080 \
                --agent-key agent:leon:sales:sh001 \
                --client-id harness-bootstrap \
                --client-secret <平台的 HARNESS_BOOTSTRAP_SECRET>
   ```
3. 报到，拿绑定码（10 分钟有效）：
   ```bash
   ~/.harness/terminal/harness-terminal.jar hello
   ```
4. **请自然人在管理台**输入绑定码，把这台设备绑到某个数字员工或员工账号上。
5. 取回授权（平台 → 外壳 → 智能体读同一份文件）：
   ```bash
   ~/.harness/terminal/harness-terminal.jar grant
   ```
6. 智能体常驻（安装脚本已经注册了 systemd 用户服务）：
   ```bash
   systemctl --user status harness-agent
   tail -f ~/.harness/agent.log
   ```

## 装了什么

| 路径 | 是什么 |
|---|---|
| `~/.harness/terminal/harness-terminal.jar` | 设备外壳：设备身份、绑定码、心跳、授权交接 |
| `~/.harness/terminal/harness-agent` | 智能体运行时：上下文、工具、验证循环 |
| `~/.harness/terminal/terminal.properties` | 配置（含密钥，0600） |
| `~/.harness/terminal/identity/device.key` | 设备私钥（0600，**不出这台机器**） |
| `~/.harness/terminal/identity/grant.json` | 平台给的授权（智能体读它） |
| `~/.harness/agent.log` | 智能体日志 |

## 卸载

```bash
systemctl --user disable --now harness-agent
rm -rf ~/.harness/terminal ~/.config/systemd/user/harness-agent.service ~/.harness/agent.log
```
EOF
  (cd "$BUNDLE_DIR" && tar czf "$BUNDLE_DIR.tar.gz" .)
  echo "install-terminal: bundle in $BUNDLE_DIR.tar.gz"
  echo "  copy it to the target machine and run: tar xzf harness-terminal-bundle.tar.gz && cd harness-terminal-bundle && ./install.sh --help"
  exit 0
fi

# ---------------------------------------------------------------- the install
echo "install-terminal: installing into $INSTALL_DIR"

if ! command -v java >/dev/null 2>&1; then
  echo "install-terminal: java is not on the PATH." >&2
  echo "  sudo apt-get update && sudo apt-get install -y openjdk-17-jre-headless" >&2
  exit 1
fi
JAVA_MAJOR=$(java -version 2>&1 | head -1 | sed -E 's/.*"([0-9]+).*/\1/')
if [[ -n "$JAVA_MAJOR" && "$JAVA_MAJOR" -lt 8 ]]; then
  echo "install-terminal: java $JAVA_MAJOR is too old (the terminal needs 8 or newer)" >&2
  exit 1
fi

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$INSTALL_DIR"
for artifact in harness-terminal.jar harness-agent; do
  if [[ ! -f "$HERE/$artifact" ]]; then
    echo "install-terminal: $HERE/$artifact is missing - is this the bundle?" >&2
    exit 1
  fi
done
cp "$HERE/harness-terminal.jar" "$INSTALL_DIR/harness-terminal.jar"
cp "$HERE/harness-agent" "$INSTALL_DIR/harness-agent"
chmod +x "$INSTALL_DIR/harness-agent"
mkdir -p "$INSTALL_DIR/identity" "$INSTALL_DIR/workspace"
chmod 700 "$INSTALL_DIR/identity"

if [[ -z "$PLATFORM_URL" ]]; then
  echo "install-terminal: --platform is required (the address of the harness platform)" >&2
  exit 2
fi
if [[ -z "$CLIENT_SECRET" ]]; then
  CLIENT_SECRET="${HARNESS_CLIENT_SECRET:-}"
fi
if [[ -z "$CLIENT_SECRET" ]]; then
  echo "install-terminal: --client-secret is required (the platform's service account secret)" >&2
  exit 2
fi
[[ -z "$WORKSPACE" ]] && WORKSPACE="$INSTALL_DIR/workspace"

# the configuration
SECRET="$CLIENT_SECRET" \
PLATFORM_URL="$PLATFORM_URL" \
CLIENT_ID="$CLIENT_ID" \
AGENT_KEY="$AGENT_KEY" \
WORKSPACE="$WORKSPACE" \
INSTALL_DIR="$INSTALL_DIR" \
python3 - <<'PYEOF'
import os, pathlib
install = pathlib.Path(os.environ["INSTALL_DIR"])
props = install / "terminal.properties"
lines = [
    "# harness terminal configuration - the secret in here is the platform's service account secret",
    "platform.url=%s" % os.environ["PLATFORM_URL"],
    "client.id=%s" % os.environ["CLIENT_ID"],
    "secret=%s" % os.environ["SECRET"],
    "agent.key=%s" % os.environ.get("AGENT_KEY", ""),
    "allowed.roots=%s" % os.environ["WORKSPACE"],
    "autonomy.level=0",
    "identity.directory=%s" % (install / "identity"),
    "",
]
props.write_text("\n".join(lines), encoding="utf-8")
props.chmod(0o600)
print(f"install-terminal: wrote {props}")
PYEOF

# the device identity (the jar is run with java, not executed directly)
if ! java -jar "$INSTALL_DIR/harness-terminal.jar" --config "$INSTALL_DIR/terminal.properties" \
        --identity "$INSTALL_DIR/identity" install "$PLATFORM_URL" ${AGENT_KEY:+"$AGENT_KEY"} \
        "$CLIENT_ID" "$CLIENT_SECRET" >/dev/null; then
  echo "install-terminal: the device identity could not be created - check the log" >&2
  exit 1
fi

# the agent, as a service
if [[ "$NO_SERVICE" == "0" ]] && command -v systemctl >/dev/null 2>&1; then
  UNIT_DIR="$HOME/.config/systemd/user"
  mkdir -p "$UNIT_DIR"
  cat > "$UNIT_DIR/harness-agent.service" <<EOF
[Unit]
Description=Harness 终端智能体（服务管理台的任务）
After=network-online.target

[Service]
Type=simple
ExecStart=$INSTALL_DIR/harness-agent serve \\
  --workspace $WORKSPACE \\
  --identity $INSTALL_DIR/identity \\
  --config $INSTALL_DIR/terminal.properties
Restart=always
RestartSec=10
StandardOutput=append:$HOME/.harness/agent.log
StandardError=append:$HOME/.harness/agent.log

[Install]
WantedBy=default.target
EOF
  mkdir -p "$HOME/.harness"
  systemctl --user daemon-reload
  systemctl --user enable --now harness-agent.service 2>/dev/null \
    && echo "install-terminal: the agent runs as a systemd user service (harness-agent.service)" \
    || echo "install-terminal: could not register the service; run the agent by hand:"
  echo "  $INSTALL_DIR/harness-agent serve --workspace $WORKSPACE --identity $INSTALL_DIR/identity --config $INSTALL_DIR/terminal.properties"
fi

echo
echo "install-terminal: done. Next:"
echo "  1. java -jar $INSTALL_DIR/harness-terminal.jar --config $INSTALL_DIR/terminal.properties --identity $INSTALL_DIR/identity hello"
echo "     (拿绑定码，10 分钟有效)"
echo "  2. 请自然人在管理台输入绑定码，绑定这台设备"
echo "  3. java -jar $INSTALL_DIR/harness-terminal.jar --config $INSTALL_DIR/terminal.properties --identity $INSTALL_DIR/identity grant"
echo "     (取回平台给的授权，智能体读同一份文件)"
echo
echo "  日志: ~/.harness/agent.log"
