package com.fuao.harness.protocol.token;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.security.KeyPair;
import java.time.Instant;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CapabilityTokenTest {

    private KeyPair keys;
    private KeyPair attackerKeys;
    private FakeAuthority authority;

    @BeforeEach
    void setUp() {
        keys = CapabilityToken.generateKeyPair();
        attackerKeys = CapabilityToken.generateKeyPair();
        authority = new FakeAuthority();
    }

    private CapabilityToken.Claims claims(String subject, List<String> cap, long ttlSeconds) {
        long now = Instant.now().getEpochSecond();
        return new CapabilityToken.Claims(
                "harness:brain-core",
                subject,
                "terminal:" + subject.replace("agent:", ""),
                cap,
                Map.of("deptIds", List.of(91)),
                "jti-" + subject + "-" + ttlSeconds,
                now,
                now + ttlSeconds,
                null,
                null);
    }

    private CapabilityToken.VerificationResult verify(CapabilityToken token) {
        return token.verify(keys.getPublic(), Set.of("harness:brain-core"),
                "terminal:" + token.claims().sub().replace("agent:", ""), authority, Instant.now());
    }

    @Test
    void acceptsAWellFormedToken() {
        authority.granted = new HashSet<>(List.of("cap:portal.mission.complete"));
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(),
                claims("agent:a1", List.of("cap:portal.mission.complete"), 3600));

        CapabilityToken.VerificationResult result = verify(token);
        assertTrue(result.allowed(), String.valueOf(result.error()) + " " + result.detail());
        assertEquals(3600L, result.claims().ttlSeconds());
    }

    @Test
    void refusesATokenThatOutlivesTheTwentyFourHourCeiling() {
        // 03 §5: "exp ... TTL ≤ 24h（联邦 ≤1h）". The ceiling is enforced at minting time; a
        // token that outlives it is refused, not quietly shortened.
        CapabilityToken.TokenException e = assertThrows(CapabilityToken.TokenException.class,
                () -> CapabilityToken.mint(keys.getPrivate(),
                        claims("agent:a1", List.of("cap:portal.mission.complete"), 25 * 3600)));
        assertEquals(CapabilityToken.TokenError.TTL_TOO_LONG, e.error());
    }

    @Test
    void acceptsATokenAtExactlyTwentyFourHours() {
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(),
                claims("agent:a1", List.of("cap:portal.mission.complete"), 24 * 3600));
        assertEquals(24 * 3600L, token.claims().ttlSeconds());
    }

    @Test
    void refusesAFederationTokenThatOutlivesOneHour() {
        long now = Instant.now().getEpochSecond();
        CapabilityToken.Claims fed = new CapabilityToken.Claims(
                "harness:brain-core", "fed:peer-1", "fed:peer-2",
                List.of("cap:x"), Map.of("deptIds", List.of(91)), "jti-fed", now, now + 2 * 3600, null, null);
        CapabilityToken.TokenException e = assertThrows(CapabilityToken.TokenException.class,
                () -> CapabilityToken.mint(keys.getPrivate(), fed));
        assertEquals(CapabilityToken.TokenError.TTL_TOO_LONG, e.error());
    }

    @Test
    void refusesATokenThatExpiresBeforeItWasIssued() {
        CapabilityToken.TokenException e = assertThrows(CapabilityToken.TokenException.class,
                () -> CapabilityToken.mint(keys.getPrivate(),
                        claims("agent:a1", List.of("cap:portal.mission.complete"), 0)));
        assertEquals(CapabilityToken.TokenError.BAD_FORMAT, e.error());
    }

    @Test
    void rejectsATamperedSignature() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        String serialized = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60)).serialized();
        // Tamper in the middle of the signature part, not at its end: base64url without padding
        // gives the final character only two significant bits, so changing it can decode to the
        // very same bytes - the token would stay valid and the test would pass for the wrong
        // reason.
        int dot = serialized.indexOf('.');
        int target = dot + 1 + (serialized.length() - dot - 1) / 2;
        char original = serialized.charAt(target);
        char replacement = original == 'A' ? 'B' : 'A';
        String tampered = serialized.substring(0, target) + replacement + serialized.substring(target + 1);

        CapabilityToken.VerificationResult result = CapabilityToken.parse(tampered)
                .verify(keys.getPublic(), Set.of("harness:brain-core"), "terminal:a1", authority, Instant.now());
        assertFalse(result.allowed());
        assertEquals(CapabilityToken.TokenError.BAD_SIGNATURE, result.error());
    }

    @Test
    void rejectsASignatureFromAnotherKey() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        CapabilityToken foreign = CapabilityToken.mint(attackerKeys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60));
        assertEquals(CapabilityToken.TokenError.BAD_SIGNATURE, verify(foreign).error());
    }

    @Test
    void rejectsUntrustedIssuer() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60));
        CapabilityToken.VerificationResult result = token.verify(keys.getPublic(),
                Set.of("harness:other"), "terminal:a1", authority, Instant.now());
        assertEquals(CapabilityToken.TokenError.UNTRUSTED_ISS, result.error());
    }

    @Test
    void rejectsWrongAudience() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60));
        assertEquals(CapabilityToken.TokenError.AUD_MISMATCH,
                token.verify(keys.getPublic(), Set.of("harness:brain-core"), "terminal:other", authority, Instant.now()).error());
    }

    @Test
    void rejectsExpiredToken() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60));
        CapabilityToken.VerificationResult result = token.verify(keys.getPublic(),
                Set.of("harness:brain-core"), "terminal:a1", authority, Instant.now().plusSeconds(61));
        assertEquals(CapabilityToken.TokenError.EXPIRED, result.error());
    }

    @Test
    void rejectsRevokedJti() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        authority.revokedJtis = Set.of("jti-agent:a1-60");
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60));
        assertEquals(CapabilityToken.TokenError.REVOKED_JTI, verify(token).error());
    }

    @Test
    void signatureAloneIsNotEnoughTheGrantMustStillBeLive() {
        // This is the core of 03 §5 step 6: a perfectly signed token whose grant has since been
        // revoked must die immediately. Otherwise "revoke" would only stop *new* tokens.
        authority.granted = new HashSet<>(List.of("cap:x"));
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 3600));
        authority.granted = new HashSet<>(List.of("cap:unrelated"));

        CapabilityToken.VerificationResult result = verify(token);
        assertEquals(CapabilityToken.TokenError.CAP_NOT_GRANTED, result.error());
        assertTrue(result.detail().contains("cap:x"));
    }

    @Test
    void rejectsScopeThatDoesNotReachTheRequestedObject() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        authority.requestScope = Map.of("deptIds", List.of(7));
        authority.intersects = false;
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), claims("agent:a1", List.of("cap:x"), 60));
        assertEquals(CapabilityToken.TokenError.SCOPE_NOT_INTERSECTED, verify(token).error());
    }

    @Test
    void requiresTheOriginatingApprovalToStillBeValid() {
        authority.granted = new HashSet<>(List.of("cap:x"));
        long now = Instant.now().getEpochSecond();
        CapabilityToken.Claims c = new CapabilityToken.Claims("harness:brain-core", "agent:a1", "terminal:a1",
                List.of("cap:x"), Map.of("deptIds", List.of(91)), "jti-1", now, now + 60, "appr:7", null);
        CapabilityToken token = CapabilityToken.mint(keys.getPrivate(), c);

        authority.approvals.put("appr:7", new CapabilityToken.ApprovalStatus(false, "pending", null));
        assertEquals(CapabilityToken.TokenError.APPROVAL_NOT_APPROVED, verify(token).error());

        authority.approvals.put("appr:7", new CapabilityToken.ApprovalStatus(
                true, "approved", Instant.now().minusSeconds(1)));
        assertEquals(CapabilityToken.TokenError.APPROVAL_EXPIRED, verify(token).error());

        authority.approvals.put("appr:7", new CapabilityToken.ApprovalStatus(true, "approved",
                Instant.now().plusSeconds(3600)));
        assertTrue(verify(token).allowed());
    }

    @Test
    void rejectsGarbage() {
        assertThrows(CapabilityToken.TokenException.class, () -> CapabilityToken.parse("no-dot"));
        assertThrows(CapabilityToken.TokenException.class, () -> CapabilityToken.parse("!!!.###"));
    }

    /** In-memory stand-in for the platform's grant / revocation / approval lookups. */
    private static final class FakeAuthority implements CapabilityToken.GrantAuthority {
        Set<String> granted = Set.of();
        Set<String> revokedJtis = Set.of();
        Map<String, Object> requestScope = Map.of("deptIds", List.of(91));
        boolean intersects = true;
        Map<String, CapabilityToken.ApprovalStatus> approvals = new HashMap<>();

        @Override
        public Set<String> activeGrantCapKeys(String subject) {
            return granted;
        }

        @Override
        public boolean isJtiRevoked(String jti) {
            return revokedJtis.contains(jti);
        }

        @Override
        public Map<String, Object> currentRequestScope() {
            return requestScope;
        }

        @Override
        public boolean scopeIntersects(Map<String, Object> tokenScope, Map<String, Object> scope) {
            return intersects;
        }

        @Override
        public CapabilityToken.ApprovalStatus approvalStatus(String approvalId) {
            return approvals.get(approvalId);
        }
    }
}