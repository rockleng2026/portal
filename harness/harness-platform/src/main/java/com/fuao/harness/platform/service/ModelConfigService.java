package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.ModelConfigRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * The model configuration of a terminal (V10).
 *
 * <p>The platform holds it so the operator can set it from the console; the terminal fetches it
 * so it does not have to be typed on the machine. Two rules hold everywhere:
 *
 * <ul>
 *   <li>the API key is <b>write-only</b> over the API. Reading the configuration back tells
 *       you <em>that</em> a key is configured, never the key itself;</li>
 *   <li>the key is encrypted at rest. The platform has to be able to hand it to the terminal
 *       (the terminal calls the model provider with it), so it cannot be hashed - but it does
 *       not have to sit in the table in the clear either.</li>
 * </ul>
 */
@Service
public class ModelConfigService {

    private static final String TRANSFORMATION = "AES/GCM/NoPadding";
    private static final int IV_LENGTH = 12;
    private static final int TAG_BITS = 128;
    private static final SecureRandom RANDOM = new SecureRandom();

    private final ModelConfigRepository configs;
    private final AuditService audit;
    private final AuthContext authContext;
    private final byte[] encryptionKey;

    public ModelConfigService(ModelConfigRepository configs, AuditService audit, AuthContext authContext,
                              com.fuao.harness.platform.config.HarnessProperties properties) {
        this.configs = configs;
        this.audit = audit;
        this.authContext = authContext;
        this.encryptionKey = deriveKey(properties);
    }

    /**
     * The key the model keys are encrypted with.
     *
     * <p>From {@code harness.model.encryption-key} when it is set, otherwise derived from the
     * bootstrap secret. A dedicated key is better (it can be rotated without touching the
     * service account), but refusing to work without one would make the feature unusable on a
     * fresh machine.
     */
    private static byte[] deriveKey(com.fuao.harness.platform.config.HarnessProperties properties) {
        String configured = null;
        if (properties.model() != null) {
            configured = properties.model().encryptionKey();
        }
        if (configured == null || configured.isBlank()) {
            String bootstrap = properties.bootstrap() == null ? null : properties.bootstrap().secret();
            if (bootstrap != null && !bootstrap.isBlank()) {
                configured = "derived:" + bootstrap;
            }
        }
        if (configured == null || configured.isBlank()) {
            throw new IllegalStateException(
                    "no key to encrypt the model credentials with: set harness.model.encryption-key "
                            + "(or a bootstrap secret)");
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return digest.digest(configured.getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    /** What the console sees: the key is not in it. */
    public record ModelConfigView(String configId, String scope, String scopeId, String provider,
                                  String modelName, String baseUrl, boolean keyConfigured,
                                  String createdBy, Instant updatedAt) {
    }

    /** What the terminal gets: the key is in it. */
    public record TerminalModelConfig(String provider, String modelName, String baseUrl, String apiKey) {
    }

    @Transactional
    public ModelConfigView set(String scope, String scopeId, String provider, String modelName,
                               String baseUrl, String apiKey) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "configuring the model requires a natural human, caller was " + actor.actorType());
        }
        if (apiKey == null || apiKey.isBlank()) {
            throw new IllegalArgumentException("the api key must not be empty");
        }
        String scopeName = scope == null || scope.isBlank() ? "terminal" : scope;
        if ("global".equals(scopeName)) {
            scopeName = "brain";
        }
        if (!List.of("terminal", "agent", "brain").contains(scopeName)) {
            throw new IllegalArgumentException(
                    "scope must be terminal, agent or brain - got '" + scope + "'");
        }
        String id = scopeName.equals("global") ? "*" : (scopeId == null || scopeId.isBlank() ? "*" : scopeId);
        String cipher = encrypt(apiKey);
        Instant now = Instant.now();
        boolean existed = configs.find(scopeName, id).isPresent();
        String configId = existed
                ? configs.find(scopeName, id).map(ModelConfigRepository.ConfigRow::configId).orElseGet(Ids::newId)
                : Ids.newId();
        configs.upsert(configId, scopeName, id, provider == null ? "anthropic" : provider,
                modelName == null || modelName.isBlank() ? "claude-sonnet-4-5" : modelName, baseUrl, cipher,
                actor.actorId(), now);
        audit.record(actor, configId, "model.config.set", "modelConfig", configId, "allow", null,
                "model " + provider + "/" + modelName + " for " + scopeName + " " + id,
                Map.of("scope", scopeName, "scopeId", id, "provider", provider == null ? "" : provider));
        return view(configs.find(scopeName, id).orElseThrow());
    }

    /** The configuration of a terminal, with the key - only for the terminal itself. */
    public Optional<TerminalModelConfig> forTerminal(String terminalId, String agentId) {
        for (ModelConfigRepository.ConfigRow row : configs.resolveFor(terminalId, agentId)) {
            return Optional.of(new TerminalModelConfig(row.provider(), row.modelName(), row.baseUrl(),
                    decrypt(row.apiKeyCipher())));
        }
        return Optional.empty();
    }

    /** The configurations, without the keys. */
    public List<ModelConfigView> list() {
        return configs.list().stream().map(this::view).toList();
    }

    public Optional<ModelConfigView> get(String scope, String scopeId) {
        return configs.find(scope, scopeId).map(this::view);
    }

    @Transactional
    public boolean delete(String scope, String scopeId) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "removing the model configuration requires a natural human, caller was "
                            + actor.actorType());
        }
        boolean removed = configs.delete(scope, scopeId);
        // The trace id is a uuid (CHAR(36)); the scope belongs in the object id.
        audit.record(actor, Ids.newId(), "model.config.delete", "modelConfig",
                scope + ":" + scopeId, removed ? "allow" : "deny", removed ? null : "NOT_FOUND",
                "the model configuration was removed", Map.of("scope", scope, "scopeId", scopeId));
        return removed;
    }

    private ModelConfigView view(ModelConfigRepository.ConfigRow row) {
        return new ModelConfigView(row.configId(), row.scope(), row.scopeId(), row.provider(),
                row.modelName(), row.baseUrl() == null ? "" : row.baseUrl(), true, row.createdBy(),
                row.updatedAt());
    }

    private String encrypt(String plain) {
        try {
            byte[] iv = new byte[IV_LENGTH];
            RANDOM.nextBytes(iv);
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(encryptionKey, "AES"),
                    new GCMParameterSpec(TAG_BITS, iv));
            byte[] encrypted = cipher.doFinal(plain.getBytes(StandardCharsets.UTF_8));
            byte[] out = new byte[iv.length + encrypted.length];
            System.arraycopy(iv, 0, out, 0, iv.length);
            System.arraycopy(encrypted, 0, out, iv.length, encrypted.length);
            return Base64.getEncoder().encodeToString(out);
        } catch (Exception e) {
            throw new IllegalStateException("cannot encrypt the model key", e);
        }
    }

    private String decrypt(String cipherText) {
        try {
            byte[] raw = Base64.getDecoder().decode(cipherText);
            byte[] iv = new byte[IV_LENGTH];
            System.arraycopy(raw, 0, iv, 0, IV_LENGTH);
            byte[] encrypted = new byte[raw.length - IV_LENGTH];
            System.arraycopy(raw, IV_LENGTH, encrypted, 0, encrypted.length);
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(encryptionKey, "AES"),
                    new GCMParameterSpec(TAG_BITS, iv));
            return new String(cipher.doFinal(encrypted), StandardCharsets.UTF_8);
        } catch (Exception e) {
            throw new IllegalStateException("cannot decrypt the model key", e);
        }
    }
}
