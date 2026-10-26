package com.fuao.harness.platform.security;

import com.fuao.harness.protocol.Digests;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Locale;

/**
 * HMAC signing for machine-to-machine calls (03 §9).
 *
 * <p>Canonical string, one line per field:
 *
 * <pre>
 *   METHOD \n PATH \n TIMESTAMP \n NONCE \n hex(sha256(body))
 * </pre>
 *
 * <p>Body hashing means the signature covers the payload without the secret ever touching the
 * request body twice, and the timestamp plus nonce turn a captured signature into something
 * useless within minutes.
 *
 * <p><b>Key derivation.</b> Callers pass the raw secret; the signing key is
 * {@link #deriveKey(String)} = {@code sha256(secret)}. That is what {@code harness_principal}
 * stores, so the platform never keeps a secret it could replay, and a database dump does not hand
 * over working credentials. Both sides derive the key the same way, which is why a mismatch here
 * is a bug rather than a configuration difference.
 */
public final class HmacSigner {

    private static final String EMPTY_BODY_SHA256 =
            Digests.sha256Hex(new byte[0]);

    private HmacSigner() {
    }

    /** The value stored in {@code harness_principal.secret_hash} and used as the HMAC key. */
    public static String deriveKey(String secret) {
        return Digests.sha256Hex(secret);
    }

    public static String canonical(String method, String path, String timestamp, String nonce, byte[] body) {
        String bodyHash = body == null || body.length == 0 ? EMPTY_BODY_SHA256 : Digests.sha256Hex(body);
        return method.toUpperCase(Locale.ROOT) + "\n" + path + "\n" + timestamp + "\n" + nonce + "\n" + bodyHash;
    }

    /**
     * The signature is {@code hex(HMAC-SHA256(key, canonical))} and nothing else.
     *
     * <p>There used to be an extra SHA-256 over the MAC. It was harmless here - both sides hashed
     * it - but the portal implements the contract from 03 §9 literally, and a cross-system
     * interop check showed the two sides disagreeing. The spec says "sig = HMAC-SHA256(...)",
     * so the extra hash is gone and the portal implementation is now the reference.
     */
    public static String sign(String secret, String method, String path, String timestamp, String nonce, byte[] body) {
        return Digests.hex(Digests.hmacSha256(secret.getBytes(StandardCharsets.UTF_8),
                canonical(method, path, timestamp, nonce, body).getBytes(StandardCharsets.UTF_8)));
    }

    public static boolean verify(String secret, String signature, String method, String path,
                                 String timestamp, String nonce, byte[] body) {
        String expected = sign(secret, method, path, timestamp, nonce, body);
        return MessageDigest.isEqual(expected.getBytes(StandardCharsets.UTF_8),
                signature.trim().toLowerCase(Locale.ROOT).getBytes(StandardCharsets.UTF_8));
    }
}