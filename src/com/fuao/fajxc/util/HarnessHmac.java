package com.fuao.fajxc.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 * HMAC signing for the harness API, byte-compatible with the platform side.
 *
 * <p>The canonical string is the contract (03 §9):
 *
 * <pre>
 *   METHOD \n PATH \n TIMESTAMP \n NONCE \n hex(sha256(body))
 * </pre>
 *
 * <p>and the signing key is {@code hex(sha256(secret))} - the same value the platform stores in
 * {@code harness_principal.secret_hash}. The platform never stores the secret itself and neither
 * side does, so a database dump does not yield working credentials.
 *
 * <p>Java 5 source level: no StandardCharsets, no java.util.Base64.
 */
public final class HarnessHmac {

    private static final String UTF8 = "UTF-8";
    private static final char[] HEX = "0123456789abcdef".toCharArray();

    private HarnessHmac() {
    }

    /** The key both sides derive from the shared secret. */
    public static String deriveKey(String secret) {
        return sha256Hex(toBytes(secret));
    }

    public static String canonical(String method, String path, String timestamp, String nonce, byte[] body) {
        String bodyHash = (body == null || body.length == 0) ? sha256Hex(new byte[0]) : sha256Hex(body);
        return method.toUpperCase() + "\n" + path + "\n" + timestamp + "\n" + nonce + "\n" + bodyHash;
    }

    public static String sign(String key, String method, String path, String timestamp, String nonce, byte[] body) {
        return hex(hmac(toBytes(key), toBytes(canonical(method, path, timestamp, nonce, body))));
    }

    /** Constant-time comparison: a timing oracle on a signature is a signature oracle. */
    public static boolean verify(String key, String signature, String method, String path,
                                 String timestamp, String nonce, byte[] body) {
        if (signature == null) {
            return false;
        }
        String expected = sign(key, method, path, timestamp, nonce, body);
        return MessageDigest.isEqual(toBytes(expected), toBytes(signature.trim().toLowerCase()));
    }

    public static byte[] sha256(byte[] input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return digest.digest(input);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    public static String sha256Hex(byte[] input) {
        return hex(sha256(input));
    }

    public static byte[] hmac(byte[] key, byte[] data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(key, "HmacSHA256"));
            return mac.doFinal(data);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("HmacSHA256 unavailable", e);
        } catch (java.security.InvalidKeyException e) {
            throw new IllegalStateException("invalid HMAC key", e);
        }
    }

    public static String hex(byte[] bytes) {
        char[] out = new char[bytes.length * 2];
        for (int i = 0; i < bytes.length; i++) {
            int v = bytes[i] & 0xFF;
            out[i * 2] = HEX[v >>> 4];
            out[i * 2 + 1] = HEX[v & 0x0F];
        }
        return new String(out);
    }

    public static byte[] toBytes(String value) {
        try {
            return value.getBytes(UTF8);
        } catch (UnsupportedEncodingException e) {
            throw new IllegalStateException("UTF-8 unavailable", e);
        }
    }
}