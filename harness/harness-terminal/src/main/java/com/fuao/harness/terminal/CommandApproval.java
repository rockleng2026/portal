package com.fuao.harness.terminal;

import com.fuao.harness.protocol.Digests;
import com.fuao.harness.protocol.json.Json;
import java.security.PublicKey;
import java.security.Signature;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * The approval a destructive command has to carry (01 §11.1, ADR-007).
 *
 * <p>The platform signs the approval with its Ed25519 key; the terminal verifies the signature
 * against the platform's public key, which it was given when it was bound. An approval that the
 * terminal cannot verify is an approval that does not exist - the edge cannot talk a terminal
 * into running {@code fs.delete} by claiming a human said yes.
 *
 * <p>An approval is also <em>bound</em>: it names the command, the capability and the path it
 * was given for. A signature that verifies is not enough - the edge must not be able to spend
 * an approval for one file on another one.
 */
public final class CommandApproval {

    private CommandApproval() {
    }

    /** The signed payload: what was approved, by whom, until when. */
    public static Map<String, Object> payload(String approvalId, String command, String capKey,
                                              String targetPath, long issuedAtEpoch, long expiresAtEpoch,
                                              int operatorEmployeeId) {
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("approvalId", approvalId);
        payload.put("command", command);
        payload.put("capKey", capKey);
        payload.put("targetPath", targetPath);
        payload.put("issuedAt", issuedAtEpoch);
        payload.put("expiresAt", expiresAtEpoch);
        payload.put("operatorEmployeeId", operatorEmployeeId);
        return payload;
    }

    public static byte[] canonicalPayload(Map<String, Object> payload) {
        return Json.canonicalBytes(payload);
    }

    /** Signs an approval with the platform's Ed25519 key. */
    public static byte[] sign(java.security.PrivateKey platformKey, Map<String, Object> payload) {
        try {
            Signature signature = Signature.getInstance("Ed25519");
            signature.initSign(platformKey);
            signature.update(canonicalPayload(payload));
            return signature.sign();
        } catch (Exception e) {
            throw new IllegalStateException("cannot sign the command approval", e);
        }
    }

    /**
     * Verifies an approval and turns it into something {@link LocalPolicy} understands.
     *
     * @return the approval, or {@code null} when it does not verify
     */
    public static LocalPolicy.ApprovalToken verify(PublicKey platformKey, Map<String, Object> payload,
                                                     byte[] signature) {
        try {
            Signature verifier = Signature.getInstance("Ed25519");
            verifier.initVerify(platformKey);
            verifier.update(canonicalPayload(payload));
            if (!verifier.verify(signature)) {
                return null;
            }
        } catch (Exception e) {
            return null;
        }
        Object approvalId = payload.get("approvalId");
        Object expiresAt = payload.get("expiresAt");
        if (approvalId == null || expiresAt == null) {
            return null;
        }
        long expiresAtEpoch = expiresAt instanceof Number n ? n.longValue() : 0L;
        return new LocalPolicy.ApprovalToken(
                String.valueOf(approvalId),
                expiresAtEpoch,
                signature,
                canonicalPayload(payload),
                asString(payload.get("command")),
                asString(payload.get("capKey")),
                asString(payload.get("targetPath")));
    }

    private static String asString(Object value) {
        return value == null ? null : String.valueOf(value);
    }

    /** Convenience for the platform side: build the frame payload of an approval. */
    public static Map<String, Object> toFramePayload(Map<String, Object> approvalPayload, byte[] signature) {
        Map<String, Object> out = new LinkedHashMap<>(approvalPayload);
        out.put("signature", Digests.hex(signature));
        return out;
    }

    /** How long an approval stays usable when the platform does not say. */
    public static final Duration DEFAULT_TTL = Duration.ofMinutes(15);
}
