package com.fuao.harness.platform.security;

import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

/** In-memory nonce claims for tests and single-node development runs. */
@Component
@Profile("test")
public class InMemoryNonceStore implements NonceStore {

    private final Map<String, Instant> seen = new ConcurrentHashMap<>();

    @Override
    public boolean claim(String nonce, Duration ttl) {
        Instant now = Instant.now();
        seen.entrySet().removeIf(e -> e.getValue().isBefore(now));
        return seen.putIfAbsent(nonce, now.plus(ttl)) == null;
    }
}