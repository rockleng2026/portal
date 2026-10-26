package com.fuao.harness.platform.security;

import java.time.Duration;

/**
 * Single-use claim for an API nonce (03 §9: "nonce stored in Redis for 5 minutes to prevent replay").
 *
 * <p>{@code claim} must be atomic: two requests carrying the same nonce, the first one wins and
 * the second is refused. A read-then-write implementation would let a replayed signature through
 * exactly when an attacker is racing it.
 */
public interface NonceStore {

    /**
     * @return true if this nonce is being seen for the first time
     */
    boolean claim(String nonce, Duration ttl);
}