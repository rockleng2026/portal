package com.fuao.harness.platform.service;

import java.time.Duration;
import java.util.Set;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

/**
 * Redis-backed binding codes.
 *
 * <p>{@code GETDEL} makes redemption atomic: two terminals pasting the same code at the same
 * instant cannot both win, which is exactly the case a human will produce by accident.
 */
@Component
@Profile("!test")
public class RedisBindingCodeStore implements BindingCodeStore {

    private static final String PREFIX = "harness:bind:";

    private final StringRedisTemplate redis;

    public RedisBindingCodeStore(StringRedisTemplate redis) {
        this.redis = redis;
    }

    @Override
    public String issue(String terminalId, Duration ttl) {
        String code = Integer.toString(100000 + (int) (Math.random() * 900000));
        redis.opsForValue().set(PREFIX + code, terminalId, ttl);
        return code;
    }

    @Override
    public String redeem(String code) {
        return redis.opsForValue().getAndDelete(PREFIX + code);
    }

    @Override
    public void revokeAllFor(String terminalId) {
        Set<String> keys = redis.keys(PREFIX + "*");
        if (keys == null) {
            return;
        }
        for (String key : keys) {
            String owner = redis.opsForValue().get(key);
            if (terminalId.equals(owner)) {
                redis.delete(key);
            }
        }
    }
}
