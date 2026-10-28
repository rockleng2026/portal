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
#   ./harness/tools/build-portal.sh --clean
#
# Environment
#   PORTAL_JDK6   the JDK 6 to use. Default: the one under ~/tools.
#   PORTAL_LIBS   extra jars for the compile.
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

for arg in "$@"; do
  case "$arg" in
    --harness) MODE="harness" ;;
    --clean) rm -rf "$ROOT/target" ;;
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
# The JDK's own js.jar (sun.org.mozilla.javascript.internal) - javac does not look there.
for jsjar in "$JDK6"/jre/lib/js.jar "$JDK6"/lib/js.jar; do
  [[ -f "$jsjar" ]] && CP="$CP:$jsjar"
done

mkdir -p "$OUT"

# ---- the sources, split by their real encoding ----------------------------------------
SOURCES_ALL="$OUT/sources-all.txt"
SOURCES_GBK="$OUT/sources-gbk.txt"
SOURCES_UTF8="$OUT/sources-utf8.txt"
python3 - "$ROOT" "$SOURCES_ALL" "$SOURCES_GBK" "$SOURCES_UTF8" <<'PYEOF'
import pathlib, sys
root, allf, gbkf, utf8f = sys.argv[1:5]
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
print(f"build-portal: {len(srcs)} java files ({len(gbk)} GBK, {len(utf8)} UTF-8)")
PYEOF

if [[ "$MODE" == "harness" ]]; then
  # Only the files this project added or changed, with the dependencies javac pulls in.
  FILES=$(grep -E "Harness|harness" "$SOURCES_ALL" || true)
  if [[ -z "$FILES" ]]; then
    echo "build-portal: no harness files found" >&2; exit 1
  fi
  echo "build-portal: compiling the harness files and their dependencies"
  "$JDK6/bin/javac" -nowarn -encoding GBK -source 1.6 -target 1.6 \
    -cp "$CP" -sourcepath "$ROOT/src" -d "$OUT" $FILES
  echo "build-portal: $(find "$OUT" -name '*.class' | wc -l) classes in $OUT"
  exit 0
fi

# ---- the whole project, in two passes by encoding ---------------------------------------
# The order matters: the UTF-8 sources come first, because the GBK sources refer to them.
# The second pass deletes the classes of the GBK sources first, so that the ones compiled on
# demand (with the wrong encoding) are replaced by correctly compiled ones.
echo "build-portal: pass 1/2 - the UTF-8 sources"
"$JDK6/bin/javac" -nowarn -encoding UTF-8 -source 1.6 -target 1.6 \
  -cp "$CP" -sourcepath "$ROOT/src" -d "$OUT" "@$SOURCES_UTF8" || true

# A UTF-8 BOM is an illegal character to javac, so that one file is compiled from a copy
# without it.
BOM_FILE="$ROOT/src/com/yeepay/PaymentForOnlineService.java"
if [[ -f "$BOM_FILE" ]] && head -c 3 "$BOM_FILE" | od -An -tx1 | grep -q "ef bb bf"; then
  echo "build-portal: the BOM file"
  mkdir -p "$OUT/bom/com/yeepay"
  tail -c +4 "$BOM_FILE" > "$OUT/bom/com/yeepay/PaymentForOnlineService.java"
  "$JDK6/bin/javac" -nowarn -encoding UTF-8 -source 1.6 -target 1.6 \
    -cp "$OUT:$CP" -sourcepath "$OUT/bom" -d "$OUT" \
    "$OUT/bom/com/yeepay/PaymentForOnlineService.java" || true
fi

echo "build-portal: pass 2/2 - the GBK sources (the ones with Chinese text in them)"
# Drop what pass 1 compiled on demand with the wrong encoding.
python3 - "$OUT" "$SOURCES_GBK" <<'PYEOF'
import pathlib, sys
out, listfile = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
for line in listfile.read_text().split("\n"):
    line = line.strip()
    if not line:
        continue
    parts = pathlib.Path(line).parts
    if "src" in parts:
        parts = parts[parts.index("src") + 1:]
    target = out / pathlib.Path(*parts).with_suffix(".class")
    if target.exists():
        target.unlink()
PYEOF
"$JDK6/bin/javac" -nowarn -encoding GBK -source 1.6 -target 1.6 \
  -cp "$OUT:$CP" -sourcepath "$ROOT/src" -d "$OUT" "@$SOURCES_GBK" || true

# ---- the stubborn files: one that is mostly GBK with a UTF-8 patch (or the other way round)
# gets a second chance with the other encoding, on its own.
echo "build-portal: pass 3/3 - the files that need the other encoding"
python3 - "$ROOT" "$OUT" "$CP" "$JDK6" <<'PYEOF2'
import pathlib, subprocess, sys
root, out, cp, jdk = sys.argv[1:5]
out = pathlib.Path(out)
problems = []
for group in ("gbk", "utf8"):
    listing = out / f"sources-{group}.txt"
    if not listing.exists():
        continue
    for line in listing.read_text().split("\n"):
        line = line.strip()
        if not line:
            continue
        problems.append(line)
# Try every file that failed, one at a time, with both encodings.
for path in problems:
    other = "utf-8" if path.endswith(".java") else "gbk"
    result = subprocess.run(
        [f"{jdk}/bin/javac", "-nowarn", "-encoding", other, "-source", "1.6", "-target", "1.6",
         "-cp", cp, "-sourcepath", f"{root}/src", "-d", str(out), path],
        capture_output=True, text=True)
    if result.returncode == 0:
        print(f"  fixed by encoding {other}: {path}")
PYEOF2

CLASSES=$(find "$OUT" -name '*.class' | wc -l)
echo "build-portal: $CLASSES classes in $OUT"
echo "build-portal: class file version: $("$JDK6/bin/javap" -v -cp "$OUT" \
  $(cd "$OUT" && find . -name '*.class' | head -1 | sed 's|^\./||; s|\.class$||; s|/|.|g') 2>/dev/null | grep 'major version' || echo unknown)"
echo "build-portal: 50 = Java 6, which is what the portal's .classpath asks for."
echo
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
