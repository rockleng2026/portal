package com.fuao.harness.protocol.token;

import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import com.fuao.harness.protocol.json.Json;

/**
 * Capability token: {@code base64url(payload) . base64url(sig)}, {@code sig = Ed25519(payload)} (03 §5).
 *
 * <p>The interesting property is step 6 of verification: a token is not merely "signed and
 * unexpired", it is also <b>re-converged against the grant set the subject holds right now</b>.
 * Revoking a grant therefore kills every token that was derived from it, which is what makes
 * "revoke within 30s" (A0-5) and "temporary privilege escalation expires by itself" (P2)
 * achievable without hunting down issued tokens.
 *
 * <p>Scope of this class: mechanical checks. The semantic governance questions - may this
 * subject decide its own escalation, is the decider independent of the requester - belong to
 * {@code harness-policy}, not here.
 */
public final class CapabilityToken {

    private static final Base64.Encoder B64 = Base64.getUrlEncoder().withoutPadding();
    private static final Base64.Decoder B64D = Base64.getUrlDecoder();
    private static final String SIG_ALGORITHM = "Ed25519";

    /** 03 §5: a capability token lives at most 24 hours. */
    public static final long MAX_TTL_SECONDS = 24 * 60 * 60L;

    /** 03 §5: a federation token lives at most 1 hour. */
    public static final long FEDERATION_MAX_TTL_SECONDS = 60 * 60L;

    private final Claims claims;
    private final String signedPayload;

    private CapabilityToken(Claims claims, String signedPayload) {
        this.claims = claims;
        this.signedPayload = signedPayload;
    }

    // ------------------------------------------------------------------ claims

    /** Payload exactly as specified in 03 §5. */
    public record Claims(
            String iss,
            String sub,
            String aud,
            List<String> cap,
            Map<String, Object> scope,
            String jti,
            long iat,
            long exp,
            String grant,
            String chained) {

        public Claims {
            cap = cap == null ? List.of() : List.copyOf(cap);
            scope = scope == null ? Map.of() : Map.copyOf(scope);
        }

        Map<String, Object> toMap() {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("iss", iss);
            m.put("sub", sub);
            m.put("aud", aud);
            m.put("cap", new ArrayList<>(cap));
            m.put("scope", new LinkedHashMap<>(scope));
            m.put("jti", jti);
            m.put("iat", iat);
            m.put("exp", exp);
            if (grant != null) {
                m.put("grant", grant);
            }
            if (chained != null) {
                m.put("chained", chained);
            }
            return m;
        }

        static Claims fromMap(Map<String, Object> m) {
            List<String> cap = new ArrayList<>();
            for (Object o : Json.requireArray(m, "cap")) {
                cap.add(String.valueOf(o));
            }
            Map<String, Object> scope = Json.optObject(m, "scope");
            return new Claims(
                    Json.requireString(m, "iss"),
                    Json.requireString(m, "sub"),
                    Json.requireString(m, "aud"),
                    cap,
                    scope == null ? Map.of() : scope,
                    Json.requireString(m, "jti"),
                    Json.requireLong(m, "iat"),
                    Json.requireLong(m, "exp"),
                    Json.optString(m, "grant"),
                    Json.optString(m, "chained"));
        }

        public long ttlSeconds() {
            return exp - iat;
        }
    }

    public Claims claims() {
        return claims;
    }

    // ------------------------------------------------------------------ minting

    /**
     * Mints and signs a token.
     *
     * <p>The TTL ceiling is enforced here, not left to the caller: 03 §5 says a capability token
     * lives at most 24 hours, and a federation token at most 1 hour. A token that outlives its
     * ceiling is refused rather than quietly shortened - the caller has to decide that.
     *
     * @throws TokenException when the claims are malformed or exceed the TTL ceiling
     */
    public static CapabilityToken mint(PrivateKey signingKey, Claims claims) {
        Objects.requireNonNull(signingKey, "signingKey");
        Objects.requireNonNull(claims, "claims");
        if (claims.exp() <= claims.iat()) {
            throw new TokenException(TokenError.BAD_FORMAT,
                    "exp must be after iat: exp=" + claims.exp() + " iat=" + claims.iat());
        }
        long ttl = claims.exp() - claims.iat();
        long ceiling = federationAudience(claims.aud) ? FEDERATION_MAX_TTL_SECONDS : MAX_TTL_SECONDS;
        if (ttl > ceiling) {
            throw new TokenException(TokenError.TTL_TOO_LONG,
                    "token ttl " + ttl + "s exceeds the " + ceiling + "s ceiling for audience " + claims.aud());
        }
        String payload = B64.encodeToString(Json.canonicalBytes(claims.toMap()));
        byte[] raw = B64D.decode(payload);
        try {
            Signature sig = Signature.getInstance(SIG_ALGORITHM);
            sig.initSign(signingKey);
            sig.update(raw);
            String encoded = payload + "." + B64.encodeToString(sig.sign());
            return new CapabilityToken(claims, encoded);
        } catch (Exception e) {
            throw new IllegalStateException("cannot sign capability token", e);
        }
    }

    /** A federation audience is {@code fed:<peer_fed_id>}; its tokens live at most an hour. */
    private static boolean federationAudience(String aud) {
        return aud != null && aud.startsWith("fed:");
    }

    public String serialized() {
        return signedPayload;
    }

    /** Parses without verifying. Never use the result of this to authorise anything. */
    public static CapabilityToken parse(String token) {
        Objects.requireNonNull(token, "token");
        int dot = token.indexOf('.');
        if (dot <= 0 || dot == token.length() - 1) {
            throw new TokenException(TokenError.BAD_FORMAT, "expected <payload>.<signature>");
        }
        String payload = token.substring(0, dot);
        String signature = token.substring(dot + 1);
        try {
            Map<String, Object> m = Json.parseObject(new String(B64D.decode(payload)));
            return new CapabilityToken(Claims.fromMap(m), payload + "." + signature);
        } catch (IllegalArgumentException | Json.JsonException e) {
            throw new TokenException(TokenError.BAD_FORMAT, String.valueOf(e.getMessage()));
        }
    }

    // ------------------------------------------------------------------ verification

    /**
     * Performs the eight ordered checks of 03 §5. The order is part of the contract: the
     * caller learns the <em>first</em> thing that is wrong, and no external lookup is
     * performed before the cheap local checks have passed.
     *
     * @param expectedAudience required {@code aud}; must match exactly
     * @param trustedIssuers   allowed {@code iss} values
     */
    public VerificationResult verify(PublicKey publicKey,
                                    Set<String> trustedIssuers,
                                    String expectedAudience,
                                    GrantAuthority authority,
                                    Instant now) {
        String payloadPart = signedPayload.substring(0, signedPayload.indexOf('.'));

        // 1. signature
        String sigPart = signedPayload.substring(signedPayload.indexOf('.') + 1);
        try {
            Signature sig = Signature.getInstance(SIG_ALGORITHM);
            sig.initVerify(publicKey);
            sig.update(B64D.decode(payloadPart));
            if (!sig.verify(B64D.decode(sigPart))) {
                return VerificationResult.deny(TokenError.BAD_SIGNATURE, "signature mismatch");
            }
        } catch (Exception e) {
            return VerificationResult.deny(TokenError.BAD_SIGNATURE, "signature unverifiable: " + e.getMessage());
        }

        // 2. issuer
        if (!trustedIssuers.contains(claims.iss)) {
            return VerificationResult.deny(TokenError.UNTRUSTED_ISS, "iss=" + claims.iss);
        }

        // 3. audience
        if (!Objects.equals(claims.aud, expectedAudience)) {
            return VerificationResult.deny(TokenError.AUD_MISMATCH,
                    "aud=" + claims.aud + " expected=" + expectedAudience);
        }

        // 4. expiry
        if (now.getEpochSecond() >= claims.exp) {
            return VerificationResult.deny(TokenError.EXPIRED, "exp=" + claims.exp + " now=" + now.getEpochSecond());
        }

        // 5. revocation list
        if (authority.isJtiRevoked(claims.jti)) {
            return VerificationResult.deny(TokenError.REVOKED_JTI, "jti=" + claims.jti);
        }

        // 6. re-converge against the live grant set
        Set<String> granted = authority.activeGrantCapKeys(claims.sub);
        Set<String> missing = new LinkedHashSet<>(claims.cap);
        missing.removeAll(granted);
        if (!missing.isEmpty()) {
            return VerificationResult.deny(TokenError.CAP_NOT_GRANTED, "no live grant for " + missing);
        }

        // 7. scope intersection with the actual object being touched
        Map<String, Object> requestScope = authority.currentRequestScope();
        if (requestScope != null && !authority.scopeIntersects(claims.scope, requestScope)) {
            return VerificationResult.deny(TokenError.SCOPE_NOT_INTERSECTED,
                    "token scope " + claims.scope() + " does not reach " + requestScope);
        }

        // 8. the approval this token derives from must still be valid
        if (claims.grant != null) {
            ApprovalStatus st = authority.approvalStatus(claims.grant);
            if (st == null) {
                return VerificationResult.deny(TokenError.APPROVAL_NOT_APPROVED, "no such approval " + claims.grant);
            }
            if (st.expiresAt() != null && !now.isBefore(st.expiresAt())) {
                return VerificationResult.deny(TokenError.APPROVAL_EXPIRED, "approval expired at " + st.expiresAt());
            }
            if (!st.approved()) {
                return VerificationResult.deny(TokenError.APPROVAL_NOT_APPROVED,
                        "approval status=" + st.status());
            }
        }
        return VerificationResult.allow(claims);
    }

    // ------------------------------------------------------------------ collaborators

    /** Status of the approval a token was derived from. */
    public record ApprovalStatus(boolean approved, String status, Instant expiresAt) {
    }

    /**
     * External lookups needed by step 6-8. Implemented by the platform against
     * {@code harness_grant}, the revocation cache (Redis) and {@code harness_approval}.
     */
    public interface GrantAuthority {
        Set<String> activeGrantCapKeys(String subject);

        boolean isJtiRevoked(String jti);

        /** Scope of the object currently being requested, or {@code null} when not applicable. */
        Map<String, Object> currentRequestScope();

        boolean scopeIntersects(Map<String, Object> tokenScope, Map<String, Object> requestScope);

        ApprovalStatus approvalStatus(String approvalId);
    }

    // ------------------------------------------------------------------ result

    public enum TokenError {
        BAD_FORMAT,
        BAD_SIGNATURE,
        UNTRUSTED_ISS,
        AUD_MISMATCH,
        EXPIRED,
        REVOKED_JTI,
        CAP_NOT_GRANTED,
        SCOPE_NOT_INTERSECTED,
        APPROVAL_NOT_APPROVED,
        APPROVAL_EXPIRED,
        TTL_TOO_LONG
    }

    public record VerificationResult(boolean allowed, TokenError error, String detail, Claims claims) {

        static VerificationResult allow(Claims c) {
            return new VerificationResult(true, null, null, c);
        }

        static VerificationResult deny(TokenError e, String detail) {
            return new VerificationResult(false, e, detail, null);
        }
    }

    public static final class TokenException extends RuntimeException {
        private final TokenError error;

        public TokenException(TokenError error, String message) {
            super(message);
            this.error = error;
        }

        public TokenError error() {
            return error;
        }
    }

    /** Convenience for build scripts and tests that need a matching key pair. */
    public static java.security.KeyPair generateKeyPair() {
        try {
            java.security.KeyPairGenerator g = java.security.KeyPairGenerator.getInstance(SIG_ALGORITHM);
            return g.generateKeyPair();
        } catch (Exception e) {
            throw new IllegalStateException("Ed25519 unavailable", e);
        }
    }
}
