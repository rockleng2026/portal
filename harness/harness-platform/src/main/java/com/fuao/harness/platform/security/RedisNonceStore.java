package com.fuao.harness.platform.security;

import java.time.Duration;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

/**
 * Redis-backed nonce claims: {@code SET key value NX EX ttl} is the atomic primitive, so the
 * "first writer wins" property comes from Redis rather than from our code.
 */
@Component
@Profile("!test")
public class RedisNonceStore implements NonceStore {

    private static final String PREFIX = "harness:nonce:";

    private final StringRedisTemplate redis;

    public RedisNonceStore(StringRedisTemplate redis) {
        this.redis = redis;
    }

    @Override
    public boolean claim(String nonce, Duration ttl) {
        Boolean fresh = redis.opsForValue().setIfAbsent(PREFIX + nonce, "1", ttl);
        return Boolean.TRUE.equals(fresh);
    }
}