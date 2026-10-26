package com.fuao.harness.protocol;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.HexFormat;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/** SHA-256 / HMAC-SHA256 helpers used by every hash-bearing contract in the protocol. */
public final class Digests {

    private Digests() {
    }

    public static byte[] sha256(byte[]... parts) {
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
        for (byte[] p : parts) {
            md.update(p);
        }
        return md.digest();
    }

    public static String sha256Hex(byte[]... parts) {
        return HexFormat.of().formatHex(sha256(parts));
    }

    public static String hex(byte[] bytes) {
        return HexFormat.of().formatHex(bytes);
    }

    public static String sha256Hex(String s) {
        return sha256Hex(s.getBytes(java.nio.charset.StandardCharsets.UTF_8));
    }

    public static byte[] hmacSha256(byte[] key, byte[]... parts) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(key, "HmacSHA256"));
            for (byte[] p : parts) {
                mac.update(p);
            }
            return mac.doFinal();
        } catch (NoSuchAlgorithmException | java.security.InvalidKeyException e) {
            throw new IllegalStateException("HmacSHA256 unavailable", e);
        }
    }

    /** Constant-time comparison for MACs and signatures. */
    public static boolean constantTimeEquals(byte[] a, byte[] b) {
        return MessageDigest.isEqual(a, b);
    }

    /** 128 bits of CSPRNG output, hex encoded. Used for binding codes and secrets. */
    public static String randomHex128(SecureRandom rnd) {
        byte[] b = new byte[16];
        rnd.nextBytes(b);
        return HexFormat.of().formatHex(b);
    }
}