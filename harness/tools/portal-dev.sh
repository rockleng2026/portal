#!/usr/bin/env bash
# =====================================================================================
# The portal round trip: change the code, compile it, put it into the deployment, restart
# Tomcat, and check that the harness namespace still answers.
#
# The portal is a 2011-era Grails/Struts2 application (03 §9) with a JDK 6 classpath, a
# Tomcat 6 and a mix of GBK and UTF-8 sources. Every one of those four things has its own
# way of failing, and the failures look like "it did not take effect" rather than like
# "the build is wrong". This script takes care of the parts that are the same every time,
# so the next person only has to look at the parts that really changed.
#
#   ./harness/tools/portal-dev.sh              # compile, deploy, restart, verify
#   ./harness/tools/portal-dev.sh --no-restart # compile and deploy, leave Tomcat alone
#   ./harness/tools/portal-dev.sh --check      # only verify what is running
#
# Environment
#   PORTAL_DEPLOY_DIR   where the portal is deployed.
#                       Default: /mnt/data/project/tomcat/webapps/portal
#   PORTAL_TOMCAT_HOME  the Tomcat. Default: /mnt/data/project/tomcat
#   PORTAL_JDK6         the JDK 6 to compile with. Default: the one under ~/tools
#
# What it does, and why each step is there, is written down in
# document/portal/portal-维护手册.md - read that before changing the portal.
# =====================================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DEPLOY_DIR="${PORTAL_DEPLOY_DIR:-/mnt/data/project/tomcat/webapps/portal}"
TOMCAT_HOME="${PORTAL_TOMCAT_HOME:-/mnt/data/project/tomcat}"
CLASSES="$ROOT/target/portal-classes"
DO_RESTART=1
DO_COMPILE=1

log() { printf '%s\n' "$*"; }
step() { printf '\n== %s\n' "$*"; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-restart) DO_RESTART=0 ;;
    --check) DO_COMPILE=0 ;;
    -h|--help) sed -n '2,25p' "$0"; exit 0 ;;
    *) echo "portal-dev: unknown option $1" >&2; exit 2 ;;
  esac
  shift
done

# ---------------------------------------------------------------- 1) compile
if [[ $DO_COMPILE -eq 1 ]]; then
  step "编译（harness 相关文件，JDK 6）"
  # The sources are a mix of GBK and UTF-8, and the build detects the encoding per file.
  # Files that need Oracle's JDK 6 internals do not compile on Zulu 6; they are listed in the
  # output and are not the files this project changes.
  "$ROOT/harness/tools/build-portal.sh" --harness
fi

# ---------------------------------------------------------------- 2) deploy
step "部署到 $DEPLOY_DIR"
# Only the classes and the resources that really changed are copied, and everything that
# changes is backed up first. web.xml / struts.xml / applicationContext.xml are never
# overwritten - they carry the operator's own configuration.
python3 "$ROOT/harness/tools/deploy-portal.py" "$CLASSES" "$ROOT" "$DEPLOY_DIR"

# ---------------------------------------------------------------- 3) restart
PORT="$(grep -o 'Connector port="[0-9]*"' "$TOMCAT_HOME/conf/server.xml" 2>/dev/null \
  | head -1 | grep -o '[0-9]*' || echo 8080)"

if [[ $DO_RESTART -eq 1 ]]; then
  step "重启 Tomcat"
  # The classes are read when the web application starts, so a restart is the only way to
  # pick them up. shutdown.sh waits for the port to be free; starting right after it is
  # what makes "the new classes did not take effect" happen.
  if [[ -x "$TOMCAT_HOME/bin/shutdown.sh" ]]; then
    "$TOMCAT_HOME/bin/shutdown.sh" >/dev/null 2>&1 || true
    for _ in $(seq 1 30); do
      ss -ltn 2>/dev/null | grep -q ':8080 ' || break
      sleep 1
    done
    sleep 3
    "$TOMCAT_HOME/bin/startup.sh" >/dev/null 2>&1 || true
    log "Tomcat 起来了，等它把应用加载完"
    for _ in $(seq 1 60); do
      if curl -fsS -o /dev/null "http://127.0.0.1:${PORT}/portal/api/harness/health.do" 2>/dev/null; then
        break
      fi
      sleep 1
    done
  else
    log "没有 $TOMCAT_HOME/bin/shutdown.sh，跳过重启（请自己重启）"
  fi
fi

# ---------------------------------------------------------------- 4) verify
step "验证"
# The port comes from the deployment's own Tomcat, not from a guess: the connector may be
# on 8080, on 18301, or on anything else the operator set.
PORT="$(grep -o 'Connector port="[0-9]*"' "$TOMCAT_HOME/conf/server.xml" 2>/dev/null \
  | head -1 | grep -o '[0-9]*' || echo 8080)"
STATUS="$(curl -sS -o /dev/null -w '%{http_code}' "http://127.0.0.1:${PORT}/portal/api/harness/health.do" 2>/dev/null || echo 000)"
if [[ "$STATUS" == "401" ]]; then
  log "✓ harness 命名空间在应答（401 = 签名闸门在，正是应该的）"
elif [[ "$STATUS" == "200" ]]; then
  log "✓ harness 命名空间在应答（200）"
else
  log "✗ harness 命名空间没有应答（HTTP $STATUS）——看 $TOMCAT_HOME/logs/catalina.out"
  exit 1
fi

log ""
log "改了什么、怎么验的，写在 document/portal/portal-维护手册.md 里。"
