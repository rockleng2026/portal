#!/usr/bin/env bash
# =====================================================================================
# Cross-system contract check: the portal's HMAC implementation and the platform's must
# produce the same signature for the same request.
#
# This check exists because the two systems were written six months and one language apart and
# had already drifted once: the platform hashed the MAC one extra time, so every portal call
# would have failed with BAD_SIGNATURE in production while both test suites were green.
#
# It needs a compiled portal tree (the harness classes under src/com/fuao/fajxc/util and the
# interceptor) plus the platform modules. See the usage notes at the bottom.
# =====================================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PORTAL_ROOT="$ROOT/.."
WORK="${TMPDIR:-/tmp}/harness-interop"

JAVA_HOME="${JAVA_HOME:-/home/leng/tools/jdk21}"
JAVAC="$JAVA_HOME/bin/javac"
JAVA="$JAVA_HOME/bin/java"

PORTAL_CLASSES="${PORTAL_CLASSES:-$WORK/portal-classes}"
PLATFORM_CLASSES="$ROOT/harness-platform/target/classes"
PROTOCOL_CLASSES="$ROOT/harness-protocol/target/classes"

if [[ ! -d "$PLATFORM_CLASSES" || ! -d "$PROTOCOL_CLASSES" ]]; then
  echo "build the platform first: (cd $ROOT && mvn -o -pl harness-platform -am package)"
  exit 1
fi
if [[ ! -f "$PORTAL_CLASSES/com/fuao/fajxc/util/HarnessHmac.class" ]]; then
  echo "compile the portal helpers into $PORTAL_CLASSES first"
  echo "  javac -encoding UTF-8 -cp '$PORTAL_ROOT/WebRoot/WEB-INF/lib/*' -d $PORTAL_CLASSES \\"
  echo "      $PORTAL_ROOT/src/com/fuao/fajxc/util/HarnessHmac.java \\"
  echo "      $PORTAL_ROOT/src/com/fuao/fajxc/util/HarnessJson.java"
  exit 1
fi

mkdir -p "$WORK"
cat > "$WORK/InteropCheck.java" <<'EOF'
import com.fuao.fajxc.util.HarnessHmac;
import com.fuao.harness.platform.security.HmacSigner;
import java.nio.charset.StandardCharsets;

public class InteropCheck {
    public static void main(String[] args) {
        String secret = "shared-secret-0123456789-abcdef";
        String method = "POST";
        String path = "/api/harness/agent/onboard";
        String timestamp = "1792721405";
        String nonce = "0f9c2a11-1111-2222-3333-444455556666";
        byte[] body = "agentKey=agent%3Aleon%3Asales%3Ash001&deptId=91".getBytes(StandardCharsets.UTF_8);

        String portalSig = HarnessHmac.sign(HarnessHmac.deriveKey(secret), method, path, timestamp, nonce, body);
        String platformSig = HmacSigner.sign(HmacSigner.deriveKey(secret), method, path, timestamp, nonce, body);

        boolean ok = portalSig.equals(platformSig)
                && HarnessHmac.verify(HarnessHmac.deriveKey(secret), platformSig, method, path, timestamp, nonce, body)
                && HmacSigner.verify(HmacSigner.deriveKey(secret), portalSig, method, path, timestamp, nonce, body)
                && !HarnessHmac.verify(HarnessHmac.deriveKey(secret), portalSig, method, path, timestamp, nonce,
                        "tampered".getBytes(StandardCharsets.UTF_8));

        System.out.println("portal   : " + portalSig);
        System.out.println("platform : " + platformSig);
        System.out.println(ok ? "OK   the two implementations agree" : "FAIL the two implementations disagree");
        if (!ok) {
            System.exit(1);
        }
    }
}
EOF

CP="$PORTAL_CLASSES:$PLATFORM_CLASSES:$PROTOCOL_CLASSES"
"$JAVAC" -nowarn -cp "$CP" -d "$WORK" "$WORK/InteropCheck.java"
"$JAVA" -cp "$CP:$WORK" InteropCheck