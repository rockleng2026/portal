package com.fuao.harness.platform.service;

import java.security.SecureRandom;
import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

/** In-memory binding codes for tests and single-node development runs. */
@Component
@Profile("test")
public class InMemoryBindingCodeStore implements BindingCodeStore {

    private static final SecureRandom RANDOM = new SecureRandom();

    private final Map<String, Entry> codes = new ConcurrentHashMap<>();
    private final Map<String, Instant> terminalRevocations = new ConcurrentHashMap<>();

    private record Entry(String terminalId, Instant expiresAt, boolean consumed) {
    }

    @Override
    public String issue(String terminalId, Duration ttl) {
        purge();
        String code = Integer.toString(100000 + RANDOM.nextInt(900000));
        codes.put(code, new Entry(terminalId, Instant.now().plus(ttl), false));
        return code;
    }

    @Override
    public String redeem(String code) {
        purge();
        Entry entry = codes.get(code);
        if (entry == null || entry.consumed() || !Instant.now().isBefore(entry.expiresAt())) {
            return null;
        }
        if (!codes.replace(code, entry, new Entry(entry.terminalId(), entry.expiresAt(), true))) {
            return null;
        }
        return entry.terminalId();
    }

    @Override
    public void revokeAllFor(String terminalId) {
        codes.values().removeIf(e -> e.terminalId().equals(terminalId));
    }

    private void purge() {
        codes.values().removeIf(e -> !Instant.now().isBefore(e.expiresAt()));
    }
}