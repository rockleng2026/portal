package com.fuao.harness.terminal;

import java.io.IOException;
import java.net.URI;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * The terminal's command line.
 *
 * <p>The commands are the ones the deployment manual (deliverable/01) tells an operator to use:
 * {@code install}, {@code status}, {@code hello}, {@code bind}, {@code heartbeat}, {@code run},
 * {@code revoke}. They are deliberately small: the interesting behaviour is not in the CLI but
 * in what the terminal refuses to do.
 */
public final class TerminalMain {

    public static final String VERSION = "0.1.0";

    private TerminalMain() {
    }

    public static void main(String[] args) {
        try {
            System.exit(run(args));
        } catch (Exception e) {
            System.err.println("harness-terminal: " + e.getMessage());
            System.exit(2);
        }
    }

    static int run(String[] args) throws Exception {
        if (args.length == 0) {
            usage();
            return 1;
        }
        // Global options may come before the command: --config and --identity. A terminal that
        // runs as a service account needs to be pointed at its own directories, and the JVM's
        // "user.home" is the login account's home, not the service account's.
        Path configFile = TerminalConfig.defaultConfigFile();
        Path identityDirectory = null;
        List<String> allowedRoots = new ArrayList<>();
        List<String> positional = new ArrayList<>();
        for (int i = 0; i < args.length; i++) {
            String arg = args[i];
            if (("--config".equals(arg) || "--identity".equals(arg) || "--allowed-root".equals(arg))
                    && i + 1 < args.length) {
                Path value = Paths.get(args[++i]);
                if ("--config".equals(arg)) {
                    configFile = value;
                } else if ("--identity".equals(arg)) {
                    identityDirectory = value;
                } else {
                    allowedRoots.add(value.toString());
                }
            } else {
                positional.add(arg);
            }
        }
        if (positional.isEmpty()) {
            usage();
            return 1;
        }
        String command = positional.get(0);
        List<String> rest = new ArrayList<>(positional.subList(1, positional.size()));

        switch (command) {
            case "install" -> {
                return install(configFile, rest, identityDirectory);
            }
            case "status" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                System.out.println("harness terminal " + VERSION);
                System.out.println("config file: " + configFile);
                for (Map.Entry<String, Object> e : config.describe().entrySet()) {
                    System.out.println("  " + e.getKey() + ": " + e.getValue());
                }
                DeviceIdentity identity = TerminalRuntime.identityOf(config);
                System.out.println("  deviceId: " + identity.deviceId());
                System.out.println("  keyFingerprint: " + identity.keyFingerprint());
                return 0;
            }
            case "hello" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                TerminalRuntime runtime = runtime(config);
                PlatformClient.HelloResponse hello = runtime.register();
                System.out.println("terminalId: " + hello.terminalId());
                System.out.println("status: " + hello.status());
                if (hello.bindingCode() != null && !hello.bindingCode().isBlank()) {
                    System.out.println("binding code (valid " + hello.bindingCodeTtlSeconds()
                            + "s): " + hello.bindingCode());
                    System.out.println("Type it into the console to bind this device.");
                }
                return 0;
            }
            case "bind" -> {
                if (rest.isEmpty()) {
                    System.err.println("usage: harness-terminal bind <binding-code>");
                    return 1;
                }
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                TerminalRuntime runtime = runtime(config);
                PlatformClient.BindResponse bound = runtime.bind(rest.get(0));
                System.out.println("terminalId: " + bound.terminalId());
                System.out.println("bindType: " + bound.bindType());
                System.out.println("status: " + bound.status());
                return 0;
            }
            case "heartbeat" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                TerminalRuntime runtime = runtime(config);
                boolean alive = runtime.heartbeat();
                System.out.println("status: " + runtime.status());
                if (!alive) {
                    System.out.println("this terminal was revoked and has given up its capabilities");
                    return 3;
                }
                return 0;
            }
            case "run" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                TerminalRuntime runtime = runtime(config);
                System.out.println("terminal " + runtime.terminalId() + " is heartbeating every "
                        + TerminalRuntime.HEARTBEAT_INTERVAL.toSeconds() + "s");
                runtime.run();
                return runtime.isRevoked() ? 3 : 0;
            }
            case "grant" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                TerminalRuntime runtime = runtime(config);
                TerminalGrant grant = runtime.refreshGrant();
                System.out.println("grant written to "
                        + TerminalGrant.fileOf(config.identityDirectory()));
                System.out.println("  terminalId: " + grant.terminalId());
                System.out.println("  agentId: " + grant.agentId());
                System.out.println("  autonomyLevel: " + grant.autonomyLevel());
                System.out.println("  capabilities: " + String.join(", ", grant.capabilities()));
                System.out.println("  allowedRoots: " + String.join(", ", grant.allowedRoots()));
                return 0;
            }
            case "revoke" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
                if (identityDirectory != null) {
                    config.identityDirectory(identityDirectory);
                }
                if (!allowedRoots.isEmpty()) {
                    config.allowedRoots(allowedRoots);
                }
                DeviceIdentity identity = TerminalRuntime.identityOf(config);
                TerminalRuntime runtime = runtime(config, identity);
                String terminalId = rest.isEmpty() ? runtime.terminalId() : rest.get(0);
                runtime.platformRevoke(terminalId, "revoked from the command line");
                System.out.println("terminal " + terminalId + " revoked");
                return 0;
            }
            case "version", "--version" -> {
                System.out.println(VERSION);
                return 0;
            }
            case "help", "--help", "-h" -> {
                usage();
                return 0;
            }
            default -> {
                System.err.println("unknown command: " + command);
                usage();
                return 1;
            }
        }
    }

    private static TerminalRuntime runtime(TerminalConfig config) throws IOException {
        return runtime(config, TerminalRuntime.identityOf(config));
    }

    private static TerminalRuntime runtime(TerminalConfig config, DeviceIdentity identity) {
        PlatformClient platform = TerminalRuntime.platformOf(config, identity);
        return new TerminalRuntime(config, identity, platform, TerminalRuntime.policyOf(config));
    }

    /**
     * The installation wizard.
     *
     * <p>It writes a configuration file with a freshly generated device secret; nothing is
     * downloaded and nothing is installed as a service - that part is the operating system's
     * job, and the deployment manual says how.
     */
    private static int install(Path configFile, List<String> rest, Path identityDirectory)
            throws IOException {
        TerminalConfig config = new TerminalConfig();
        String platformUrl = rest.isEmpty() ? "" : rest.get(0);
        if (platformUrl.isBlank()) {
            System.err.println("usage: harness-terminal install <platform-url> [agent-key] [client-id] "
                    + "[client-secret]");
            return 1;
        }
        config.platformUri(URI.create(platformUrl));
        if (rest.size() > 1) {
            config.agentKey(rest.get(1));
        }
        // The terminal signs with an existing platform principal. It cannot invent one: the
        // platform only accepts clients it knows, so the secret has to be the one that principal
        // was created with.
        String clientId = rest.size() > 2 ? rest.get(2) : "harness-bootstrap";
        String secret = rest.size() > 3 ? rest.get(3) : firstNonBlank(
                System.getenv("HARNESS_CLIENT_SECRET"), System.getenv("HARNESS_BOOTSTRAP_SECRET"));
        if (secret == null || secret.isBlank()) {
            System.err.println("harness-terminal: no client secret. Pass it as the 4th argument, or set "
                    + "HARNESS_CLIENT_SECRET (the secret of the platform principal "
                    + "'" + clientId + "').");
            return 1;
        }
        config.clientId(clientId);
        config.secret(secret);
        config.identityDirectory(identityDirectory != null
                ? identityDirectory : TerminalConfig.defaultIdentityDirectory());
        config.allowedRoots(List.of(System.getProperty("user.home", ".")));

        TerminalRuntime.identityOf(config);
        config.save(configFile);

        System.out.println("installed.");
        System.out.println("  configuration: " + configFile);
        System.out.println("  device identity: " + config.identityDirectory().resolve("device.key"));
        System.out.println("  client id: " + clientId);
        System.out.println("  next: harness-terminal hello, then type the binding code into the console");
        return 0;
    }

    private static String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value;
            }
        }
        return null;
    }

    private static void usage() {
        System.out.println("harness terminal " + VERSION);
        System.out.println("usage: harness-terminal [--config <file>] [--identity <dir>] "
                + "[--allowed-root <dir>]... <command>");
        System.out.println("  install <platform-url> [agent-key]  write the configuration and the device identity");
        System.out.println("  status                            show the configuration and the device identity");
        System.out.println("  hello                             register the device and ask for a binding code");
        System.out.println("  bind <binding-code>               redeem a binding code a human entered in the console");
        System.out.println("  heartbeat                         send one heartbeat");
        System.out.println("  grant                             fetch the platform's grant and write it for the agent");
        System.out.println("  run                               heartbeat until the terminal is revoked");
        System.out.println("  revoke [terminal-id]              ask the platform to revoke this terminal");
    }

    static Instant now() {
        return Instant.now();
    }
}
