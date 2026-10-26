package com.fuao.harness.platform;

import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fuao.harness.platform.security.HmacSigner;
import com.fuao.harness.terminal.PlatformClient;
import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;

/**
 * The terminal and the platform must sign the same way.
 *
 * <p>This is not a theoretical concern: the two implementations drifted once already, and the
 * symptom was "every real request is rejected with 401" while both sides' own tests were
 * green. The contract is {@code METHOD\nPATH\nTIMESTAMP\nNONCE\nhex(sha256(body))}, signed with
 * the ASCII bytes of {@code hex(sha256(secret))} as the HMAC key (03 §9).
 */
class TerminalHmacInteropTest {

    private static final String SECRET = "terminal-and-platform-share-this-secret";

    @Test
    void theTerminalSignsWhatThePlatformVerifies() {
        byte[] body = "{\"deviceId\":\"abc\"}".getBytes(StandardCharsets.UTF_8);
        String path = "/api/harness/terminal/hello";
        String timestamp = "1792985880";
        String nonce = "11111111-2222-3333-4444-555555555555";

        String signature = PlatformClient.sign(PlatformClient.deriveKey(SECRET), "POST", path,
                timestamp, nonce, body);

        assertTrue(HmacSigner.verify(HmacSigner.deriveKey(SECRET), signature, "POST", path,
                        timestamp, nonce, body),
                "the terminal's signature must verify on the platform");
    }

    @Test
    void aChangedBodyInvalidatesTheSignature() {
        byte[] body = "{\"deviceId\":\"abc\"}".getBytes(StandardCharsets.UTF_8);
        String path = "/api/harness/terminal/hello";
        String timestamp = "1792985880";
        String nonce = "11111111-2222-3333-4444-555555555555";

        String signature = PlatformClient.sign(PlatformClient.deriveKey(SECRET), "POST", path,
                timestamp, nonce, body);

        assertTrue(!HmacSigner.verify(HmacSigner.deriveKey(SECRET), signature, "POST", path, timestamp,
                        nonce, "{\"deviceId\":\"xyz\"}".getBytes(StandardCharsets.UTF_8)),
                "a changed body must invalidate the signature");
    }

    @Test
    void bothSidesDeriveTheSameKey() {
        assertTrue(HmacSigner.deriveKey(SECRET).equals(
                        new String(PlatformClient.deriveKey(SECRET), StandardCharsets.US_ASCII)),
                "the terminal and the platform must derive the same HMAC key from the same secret");
    }
}
