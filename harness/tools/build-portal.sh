#!/usr/bin/env bash
# =====================================================================================
# Compile the portal (the legacy Grails/Struts2 application) with the JDK it expects.
#
# The project's .classpath says "Sun JDK 1.6.0_13", so the code has to compile with a JDK 6
# javac: a class file built by a newer JDK cannot be loaded by the Tomcat the portal runs in
# (and the operator's MyEclipse build is configured for 1.6).
#
#   ./harness/tools/build-portal.sh              # compile everything that can be compiled
#   ./harness/tools/build-portal.sh --harness    # only the harness files (and their deps)
#   ./harness/tools/build-portal.sh --deploy     # compile, then copy into the Tomcat deployment
#   ./harness/tools/build-portal.sh --deploy=/some/other/portal
#   ./harness/tools/build-portal.sh --clean
#
# Environment
#   PORTAL_JDK6   the JDK 6 to use. Default: the one under ~/tools.
#   PORTAL_LIBS   extra jars for the compile.
#   PORTAL_DEPLOY_DIR   where the portal is deployed.
#                  Default: /mnt/data/project/tomcat/webapps/portal
#
# What the whole project needs and the repository does not have:
#   javax.jms, javax.servlet.jsp(+tagext), javax.xml.registry.infomodel   (J2EE / JavaEE APIs)
#   com.sun.* internals (com.sun.xml.internal.*, com.sun.image.codec.jpeg,
#   com.sun.org.apache.commons.digester, com.sun.istack.internal) and
#   sun.org.mozilla.javascript.*                                          (Oracle JDK 6's rt.jar
#        plus its js.jar; Zulu 6 dropped some of these internals)
#
# MyEclipse gets the J2EE APIs from its "J2EE 5" container classpath (see .classpath:
# MYECLIPSE_JAVAEE_5_CONTAINER) and the internals from Oracle's JDK 6.
#
# The J2EE API jars are fetched from Maven Central into target/j2ee by this script; the JDK
# internals cannot be fetched - they need Oracle's JDK 6 (or a Tomcat that ships them). On
# Zulu 6 the files that use them do not compile; they are listed at the end of the output and
# they are not the files this project changed.
#
# The encoding is a mess - the sources are a mix of GBK and UTF-8, and one file carries a
# UTF-8 BOM. So the build detects the encoding of every file and compiles in two passes.
# =====================================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="${PORTAL_OUT:-$ROOT/target/portal-classes}"
MODE="all"
DEPLOY_DIR="${PORTAL_DEPLOY_DIR:-/mnt/data/project/tomcat/webapps/portal}"
DO_DEPLOY=0

for arg in "$@"; do
  case "$arg" in
    --harness) MODE="harness" ;;
    --clean) rm -rf "$ROOT/target" ;;
    --deploy) DO_DEPLOY=1 ;;
    --deploy=*) DO_DEPLOY=1; DEPLOY_DIR="${arg#--deploy=}" ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

# ---- the JDK 6 -----------------------------------------------------------------------
find_jdk6() {
  if [[ -n "${PORTAL_JDK6:-}" && -x "${PORTAL_JDK6}/bin/javac" ]]; then
    echo "$PORTAL_JDK6"; return
  fi
  for candidate in "$HOME"/tools/zulu6* "$HOME"/tools/jdk1.6* /usr/lib/jvm/*1.6*; do
    if [[ -x "$candidate/bin/javac" ]]; then
      "$candidate/bin/javac" -version 2>&1 | grep -q "1.6" && { echo "$candidate"; return; }
    fi
  done
  echo ""
}

JDK6="$(find_jdk6)"
if [[ -z "$JDK6" ]]; then
  echo "build-portal: no JDK 6 found." >&2
  echo "  Download one (Zulu 6 works):" >&2
  echo "    curl -sSLO https://cdn.azul.com/zulu/bin/zulu6.22.0.3-ca-jdk6.0.119-linux_x64.tar.gz" >&2
  echo "    tar -xzf zulu6.22.0.3-ca-jdk6.0.119-linux_x64.tar.gz -C ~/tools" >&2
  echo "  then: export PORTAL_JDK6=~/tools/zulu6.22.0.3-jdk6.0.119-linux_x64" >&2
  exit 2
fi
echo "build-portal: using $JDK6 ($("$JDK6/bin/javac" -version 2>&1 | head -1))"

# ---- the J2EE API jars, fetched once ------------------------------------------------
J2EE_DIR="$ROOT/target/j2ee"
mkdir -p "$J2EE_DIR"
fetch() { # url, file
  local file="$J2EE_DIR/$2"
  if [[ ! -s "$file" ]]; then
    echo "build-portal: fetching $2"
    curl -sSfL -o "$file" "$1" || { echo "build-portal: could not fetch $2" >&2; return 1; }
  fi
}
fetch "https://repo1.maven.org/maven2/org/apache/geronimo/specs/geronimo-jms_1.1_spec/1.1.1/geronimo-jms_1.1_spec-1.1.1.jar" geronimo-jms_1.1_spec-1.1.1.jar || true
fetch "https://repo1.maven.org/maven2/javax/servlet/jsp/javax.servlet.jsp-api/2.3.3/javax.servlet.jsp-api-2.3.3.jar" javax.servlet.jsp-api-2.3.3.jar || true
# The servlet-api in WebRoot/WEB-INF/lib is Servlet 2.3 (no getContextPath); the J2EE 5
# container had a newer one.
fetch "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar" javax.servlet-api-3.1.0.jar || true
# Tomcat's own jar carries com.sun.org.apache.commons.digester and com.sun.istack.internal,
# which two legacy files import.
fetch "https://repo1.maven.org/maven2/org/apache/tomcat/tomcat-catalina/7.0.109/tomcat-catalina-7.0.109.jar" tomcat-catalina-7.0.109.jar || true

CP="$ROOT/WebRoot/WEB-INF/lib/*"
for jar in "$J2EE_DIR"/*.jar; do
  [[ -e "$jar" ]] && CP="$CP:$jar"
done
if [[ -n "${PORTAL_LIBS:-}" ]]; then
  CP="$CP:$PORTAL_LIBS"
fi
# The Tomcat the portal runs on has the internals a few legacy files import
# (com.sun.org.apache.commons.digester, com.sun.istack.internal). Using the installation's
# own jars is both simpler and more correct than hunting for the same versions.
for tomcat_lib in "${PORTAL_TOMCAT_LIB:-/mnt/data/project/tomcat/lib}"; do
  if [[ -d "$tomcat_lib" ]]; then
    CP="$CP:$tomcat_lib/*"
  fi
done
# The JDK's own js.jar (sun.org.mozilla.javascript.internal) - javac does not look there.
for jsjar in "$JDK6"/jre/lib/js.jar "$JDK6"/lib/js.jar; do
  [[ -f "$jsjar" ]] && CP="$CP:$jsjar"
done

mkdir -p "$OUT"

# ---- the sources, split by their real encoding ----------------------------------------
SOURCES_ALL="$OUT/sources-all.txt"
SOURCES_GBK="$OUT/sources-gbk.txt"
SOURCES_UTF8="$OUT/sources-utf8.txt"
python3 - "$ROOT" "$SOURCES_ALL" "$SOURCES_GBK" "$SOURCES_UTF8" "$OUT" <<'PYEOF'
import pathlib, sys
root, allf, gbkf, utf8f, out = sys.argv[1:6]
srcs = sorted(str(p) for p in pathlib.Path(root, "src").rglob("*.java"))
gbk, utf8 = [], []
for s in srcs:
    raw = pathlib.Path(s).read_bytes()
    try:
        raw.decode("utf-8")
        utf8.append(s)
    except UnicodeDecodeError:
        gbk.append(s)
pathlib.Path(allf).write_text("\n".join(srcs))
pathlib.Path(gbkf).write_text("\n".join(gbk))
pathlib.Path(utf8f).write_text("\n".join(utf8))

# The files this project changed, split by their encoding as well.
changed = pathlib.Path(root, "harness", "tools", "portal-changed-files.txt")
if changed.exists():
    wanted = []
    for line in changed.read_text().split("\n"):
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        candidate = pathlib.Path(root, line)
        if candidate.exists() and candidate.suffix == ".java":
            wanted.append(str(candidate))
    c_gbk, c_utf8 = [], []
    for s in wanted:
        raw = pathlib.Path(s).read_bytes()
        try:
            raw.decode("utf-8")
            c_utf8.append(s)
        except UnicodeDecodeError:
            c_gbk.append(s)
    pathlib.Path(out, "changed-gbk.txt").write_text("\n".join(c_gbk) + "\n")
    pathlib.Path(out, "changed-utf8.txt").write_text("\n".join(c_utf8) + "\n")
    print(f"build-portal: {len(wanted)} changed file(s) ({len(c_gbk)} GBK, {len(c_utf8)} UTF-8)")
print(f"build-portal: {len(srcs)} java files ({len(gbk)} GBK, {len(utf8)} UTF-8)")
PYEOF

compile_changed_individually() {
  # The changed files are compiled one by one, each with its own encoding, against the classes
  # that are already there. The sources are a mix of GBK and UTF-8, and a dependency pulled in
  # on demand would be compiled with the wrong encoding - so each file stands on its own.
  local ok=0 failed=0
  for file in $(cat "$OUT/changed-gbk.txt" "$OUT/changed-utf8.txt"); do
    local encoding="GBK"
    if grep -qxF "$file" "$OUT/changed-utf8.txt"; then encoding="UTF-8"; fi
    if "$JDK6/bin/javac" -nowarn -encoding "$encoding" -source 1.6 -target 1.6 \
        -cp "$OUT:$CP" -sourcepath "$ROOT/src" -d "$OUT" "$file" >/dev/null 2>&1; then
      ok=$((ok + 1))
    else
      failed=$((failed + 1))
      echo "build-portal:   could not compile $file"
    fi
  done
  echo "build-portal: $ok changed file(s) compiled, $failed could not be compiled"
}

if [[ "$MODE" == "harness" ]]; then
  # The files this project added or changed (harness/tools/portal-changed-files.txt). The
  # changed legacy classes matter as much as the new ones: LoginAction gained a property, so
  # deploying only the new classes would break the Spring context.
  if [[ ! -f "$ROOT/harness/tools/portal-changed-files.txt" ]]; then
    echo "build-portal: harness/tools/portal-changed-files.txt is missing" >&2; exit 1
  fi
  echo "build-portal: compiling the changed files and their dependencies"
  python3 "$ROOT/harness/tools/compile-portal.py" "$JDK6" "$ROOT" "$OUT" "$CP"
  echo "build-portal: $(find "$OUT" -name '*.class' | wc -l) classes in $OUT"
  if [[ "$DO_DEPLOY" == "1" ]]; then
    python3 "$ROOT/harness/tools/deploy-portal.py" "$OUT" "$ROOT" "$DEPLOY_DIR"
  fi
  exit 0
fi

# ---- the whole project ------------------------------------------------------------------
echo "build-portal: compiling the whole project"
python3 "$ROOT/harness/tools/compile-portal.py" "$JDK6" "$ROOT" "$OUT" "$CP"

CLASSES=$(find "$OUT" -name '*.class' | wc -l)
echo "build-portal: $CLASSES classes in $OUT"
echo "build-portal: class file version: $("$JDK6/bin/javap" -v -cp "$OUT" \
  $(cd "$OUT" && find . -name '*.class' | head -1 | sed 's|^\./||; s|\.class$||; s|/|.|g') 2>/dev/null | grep 'major version' || echo unknown)"
echo "build-portal: 50 = Java 6, which is what the portal's .classpath asks for."
echo

if [[ "$DO_DEPLOY" == "1" ]]; then
  echo "build-portal: deploying into $DEPLOY_DIR"
  python3 "$ROOT/harness/tools/deploy-portal.py" "$OUT" "$ROOT" "$DEPLOY_DIR"
fi
echo "build-portal: known gap on Zulu 6 - these legacy files use JDK internals that Zulu"
echo "  dropped (Oracle's JDK 6 has them) and therefore do not compile here:"
echo "    src/com/fuao/fajxc/serser/service/CabinetContent.java"
echo "    src/com/fuao/fajxc/dao/cms_rec_part/Rec_PartDaoImpl.java"
echo "    src/com/fuao/fajxc/action/sale/SaleOrderAction.java"
echo "    src/com/fuao/fajxc/action/cms_template/TemplateAction.java"
echo "    src/com/fuao/fajxc/action/basic/EmployeeAction.java"
echo "    src/com/fuao/fajxc/action/customService/ClientReturnOrderAction.java"
echo "    src/com/fuao/fajxc/util/HDThumb.java"
echo "  Use Oracle's JDK 6 (or a Tomcat with those jars) for the full build; the harness"
echo "  files compile on Zulu 6 either way: ./harness/tools/build-portal.sh --harness"
