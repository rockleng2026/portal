#!/usr/bin/env bash
# =====================================================================================
# Cross-system contract check: every HMAC implementation that talks to the portal or to the
# platform must produce the same signature for the same request.
#
# This check exists because the implementations were written months and one language apart and
# had already drifted once: the platform hashed the MAC one extra time, so every portal call
# would have failed with BAD_SIGNATURE in production while both test suites were green.
#
# Three implementations take part:
#   - com.fuao.fajxc.util.HarnessHmac           (portal side, Java 5 source level)
#   - com.fuao.harness.platform.security.HmacSigner (platform side)
#   - com.fuao.harness.terminal.PlatformClient   (terminal side)
#
# The script compiles the portal helpers itself, so it can be run on a clean checkout.
# =====================================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PORTAL_ROOT="$ROOT/.."
WORK="${TMPDIR:-/tmp}/harness-interop"

JAVA_HOME="${JAVA_HOME:-/home/leng/tools/jdk21}"
JAVAC="$JAVA_HOME/bin/javac"
JAVA="$JAVA_HOME/bin/java"

PORTAL_CLASSES="$WORK/portal-classes"
PLATFORM_CLASSES="$ROOT/harness-platform/target/classes"
PROTOCOL_CLASSES="$ROOT/harness-protocol/target/classes"
TERMINAL_CLASSES="$ROOT/harness-terminal/target/classes"

if [[ ! -d "$PLATFORM_CLASSES" || ! -d "$PROTOCOL_CLASSES" ]]; then
  echo "build the platform first: (cd $ROOT && mvn -o -pl harness-platform -am package)"
  exit 1
fi
if [[ ! -d "$TERMINAL_CLASSES" ]]; then
  echo "build the terminal first: (cd $ROOT && mvn -o -pl harness-terminal -am package)"
  exit 1
fi

mkdir -p "$WORK" "$PORTAL_CLASSES"

echo "==> compiling the portal helpers"
"$JAVAC" -nowarn -encoding UTF-8 \
  -cp "$PORTAL_ROOT/WebRoot/WEB-INF/lib/*" \
  -d "$PORTAL_CLASSES" \
  "$PORTAL_ROOT/src/com/fuao/fajxc/util/HarnessHmac.java" \
  "$PORTAL_ROOT/src/com/fuao/fajxc/util/HarnessJson.java"

cat > "$WORK/InteropCheck.java" <<'EOF'
import com.fuao.fajxc.util.HarnessHmac;
import com.fuao.harness.platform.security.HmacSigner;
import com.fuao.harness.terminal.PlatformClient;
import java.nio.charset.StandardCharsets;

public class InteropCheck {
    public static void main(String[] args) {
        String secret = "shared-secret-0123456789-abcdef";
        String method = "POST";
        // The portal's URLs carry the portal's action extension, exactly like every other
        // action in that application. The signature covers the path that is actually requested,
        // so both sides have to use the same one.
        String path = "/api/harness/agent/onboard.do";
        String timestamp = "1792721405";
        String nonce = "0f9c2a11-1111-2222-3333-444455556666";
        byte[] body = "{\"agentKey\":\"agent:leon:sales:sh001\",\"deptId\":91}"
                .getBytes(StandardCharsets.UTF_8);

        String portalSig = HarnessHmac.sign(HarnessHmac.deriveKey(secret), method, path, timestamp, nonce, body);
        String platformSig = HmacSigner.sign(HmacSigner.deriveKey(secret), method, path, timestamp, nonce, body);
        String terminalSig = PlatformClient.sign(PlatformClient.deriveKey(secret), method, path,
                timestamp, nonce, body);

        boolean same = portalSig.equals(platformSig) && platformSig.equals(terminalSig);
        boolean crossVerifies = HarnessHmac.verify(HarnessHmac.deriveKey(secret), platformSig, method, path,
                        timestamp, nonce, body)
                && HmacSigner.verify(HmacSigner.deriveKey(secret), terminalSig, method, path, timestamp, nonce, body)
                && PlatformClient.deriveKey(secret).length == platformSig.length();
        boolean detectsTampering = !HarnessHmac.verify(HarnessHmac.deriveKey(secret), portalSig, method, path,
                timestamp, nonce, "tampered".getBytes(StandardCharsets.UTF_8));

        System.out.println("portal   : " + portalSig);
        System.out.println("platform : " + platformSig);
        System.out.println("terminal : " + terminalSig);
        boolean ok = same && crossVerifies && detectsTampering;
        System.out.println(ok ? "OK   the three implementations agree"
                : "FAIL the implementations disagree (same=" + same + " cross=" + crossVerifies
                        + " tamper=" + detectsTampering + ")");
        if (!ok) {
            System.exit(1);
        }
    }
}
EOF

CP="$PORTAL_CLASSES:$PLATFORM_CLASSES:$PROTOCOL_CLASSES:$TERMINAL_CLASSES"
"$JAVAC" -nowarn -cp "$CP" -d "$WORK" "$WORK/InteropCheck.java"
"$JAVA" -cp "$CP:$WORK" InteropCheck
