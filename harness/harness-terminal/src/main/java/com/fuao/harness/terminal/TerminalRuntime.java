package com.fuao.harness.terminal;

import java.io.IOException;
import java.nio.file.Path;
import java.time.Duration;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * The terminal runtime: register, bind, stay alive, and refuse to act the moment the platform
 * says the device is revoked.
 *
 * <p>Three things happen here and nowhere else:
 * <ol>
 *   <li>the device proves who it is (a device id derived from hardware plus a secret that never
 *       leaves the machine);</li>
 *   <li>the platform hands out a one-time binding code, and a human in the console decides what
 *       this machine becomes (03 §3.5);</li>
 *   <li>from then on the terminal heartbeats, and every refusal that matters comes from
 *       {@link LocalPolicy} - the terminal, not the platform, is the last authority on what this
 *       machine may do (red-team R-01).</li>
 * </ol>
 */
public final class TerminalRuntime {

    /** The heartbeat interval the platform expects (03 §3.1: 10s). */
    public static final Duration HEARTBEAT_INTERVAL = Duration.ofSeconds(10);

    private final TerminalConfig config;
    private final DeviceIdentity identity;
    private final PlatformClient platform;
    private final LocalPolicy policy;
    private final AtomicBoolean revoked = new AtomicBoolean(false);

    private String terminalId = "";
    private volatile String status = "unbound";

    public TerminalRuntime(TerminalConfig config, DeviceIdentity identity, PlatformClient platform,
                           LocalPolicy policy) {
        this.config = config;
        this.identity = identity;
        this.platform = platform;
        this.policy = policy;
    }

    public String terminalId() {
        return terminalId;
    }

    public String status() {
        return status;
    }

    public boolean isRevoked() {
        return revoked.get();
    }

    public LocalPolicy policy() {
        return policy;
    }

    /** Registers the device and returns the binding code the operator has to type in. */
    public PlatformClient.HelloResponse register() throws IOException, InterruptedException {
        Map<String, Object> device = new LinkedHashMap<>();
        device.put("deviceId", identity.deviceId());
        device.put("os", osName());
        device.put("osVersion", System.getProperty("os.version", ""));
        device.put("hostname", hostname());
        device.put("agentVersion", TerminalMain.VERSION);
        device.put("capabilities", policy.describe());

        PlatformClient.HelloResponse response = platform.hello(device);
        this.terminalId = response.terminalId();
        this.status = response.status();
        return response;
    }

    /** Redeems a binding code that a human entered in the console. */
    public PlatformClient.BindResponse bind(String bindingCode) throws IOException, InterruptedException {
        PlatformClient.BindResponse response = platform.bind(bindingCode,
                config.agentKey().isBlank() ? null : config.agentKey(), config.portalEmployeeId());
        this.terminalId = response.terminalId();
        this.status = response.status();
        return response;
    }

    /**
     * One heartbeat.
     *
     * @return {@code true} when the terminal is still allowed to act
     */
    public boolean heartbeat() throws IOException, InterruptedException {
        PlatformClient.HeartbeatResponse response = platform.heartbeat(terminalId);
        this.status = response.status();
        if ("revoked".equalsIgnoreCase(response.status())) {
            // The platform refused this device. The terminal gives up its authority at once and
            // does not wait to be told twice (A0-5).
            revoke();
            return false;
        }
        return true;
    }

    /** Gives up every capability. Called on revocation and on a failed binding. */
    public void revoke() {
        revoked.set(true);
        status = "revoked";
        policy.revoke();
    }

    /** Asks the platform to revoke this terminal. */
    public void platformRevoke(String terminalId, String reason) throws IOException, InterruptedException {
        platform.revoke(terminalId, reason);
        revoke();
    }

    /**
     * Fetches the grant from the platform and writes it where the agent can read it.
     *
     * <p>This is the handover between the two runtimes on this machine: the shell asks the
     * platform (the only authority) and the agent reads the answer. Both enforce it locally, so
     * a compromised edge still cannot widen it.
     */
    public TerminalGrant refreshGrant() throws IOException, InterruptedException {
        if (terminalId.isBlank()) {
            throw new IllegalStateException("this terminal has no id yet; run 'hello' first");
        }
        Map<String, Object> platformGrant = platform.grant(terminalId);
        TerminalGrant grant = TerminalGrant.from(platformGrant, config.allowedRoots());
        grant.save(TerminalGrant.fileOf(config.identityDirectory()));
        return grant;
    }

    /** The grant that was fetched last, if any. */
    public TerminalGrant grant() {
        try {
            return TerminalGrant.read(TerminalGrant.fileOf(config.identityDirectory()));
        } catch (IOException e) {
            return null;
        }
    }

    /** The device as the platform sees it. */
    public Map<String, Object> describe() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("terminalId", terminalId);
        out.put("deviceId", identity.deviceId());
        out.put("keyFingerprint", identity.keyFingerprint());
        out.put("status", status);
        out.put("revoked", isRevoked());
        out.put("policy", policy.describe());
        out.put("heartbeatIntervalSeconds", HEARTBEAT_INTERVAL.toSeconds());
        return out;
    }

    /** The heartbeat loop. Returns when the terminal is revoked or the platform refuses. */
    public void run() throws IOException, InterruptedException {
        while (!isRevoked()) {
            if (!heartbeat()) {
                return;
            }
            Thread.sleep(HEARTBEAT_INTERVAL.toMillis());
        }
    }

    public static DeviceIdentity identityOf(TerminalConfig config) throws IOException {
        return DeviceIdentity.loadOrCreate(config.identityDirectory());
    }

    public static PlatformClient platformOf(TerminalConfig config, DeviceIdentity identity) {
        byte[] key = PlatformClient.deriveKey(config.secret());
        return new PlatformClient(config.platformUri(), config.clientId(), key, Duration.ofSeconds(30));
    }

    public static LocalPolicy policyOf(TerminalConfig config) {
        return new LocalPolicy(config.autonomyLevel(), java.util.Set.of(), config.allowedRoots());
    }

    private static String osName() {
        String os = System.getProperty("os.name", "unknown").toLowerCase(java.util.Locale.ROOT);
        if (os.contains("win")) {
            return "windows";
        }
        if (os.contains("mac")) {
            return "macos";
        }
        if (os.contains("nix") || os.contains("nux")) {
            return "linux";
        }
        return os;
    }

    private static String hostname() {
        try {
            return java.net.InetAddress.getLocalHost().getHostName();
        } catch (Exception e) {
            return "unknown-host";
        }
    }

    static Instant now() {
        return Instant.now();
    }

    static Path identityPath(TerminalConfig config) {
        return config.identityDirectory().resolve("device.key");
    }
}
