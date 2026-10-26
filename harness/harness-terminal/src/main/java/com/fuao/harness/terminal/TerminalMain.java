package com.fuao.harness.terminal;

import java.io.IOException;
import java.net.URI;
import java.nio.file.Path;
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
        String command = args[0];
        List<String> rest = new ArrayList<>(List.of(args).subList(1, args.length));
        Path configFile = TerminalConfig.defaultConfigFile();

        switch (command) {
            case "install" -> {
                return install(configFile, rest);
            }
            case "status" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
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
                TerminalRuntime runtime = runtime(config);
                PlatformClient.BindResponse bound = runtime.bind(rest.get(0));
                System.out.println("terminalId: " + bound.terminalId());
                System.out.println("bindType: " + bound.bindType());
                System.out.println("status: " + bound.status());
                return 0;
            }
            case "heartbeat" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
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
                TerminalRuntime runtime = runtime(config);
                System.out.println("terminal " + runtime.terminalId() + " is heartbeating every "
                        + TerminalRuntime.HEARTBEAT_INTERVAL.toSeconds() + "s");
                runtime.run();
                return runtime.isRevoked() ? 3 : 0;
            }
            case "grant" -> {
                TerminalConfig config = TerminalConfig.load(configFile);
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
    private static int install(Path configFile, List<String> rest) throws IOException {
        TerminalConfig config = new TerminalConfig();
        String platformUrl = rest.isEmpty() ? "" : rest.get(0);
        if (platformUrl.isBlank()) {
            System.err.println("usage: harness-terminal install <platform-url> [agent-key]");
            return 1;
        }
        config.platformUri(URI.create(platformUrl));
        if (rest.size() > 1) {
            config.agentKey(rest.get(1));
        }
        byte[] secret = new byte[32];
        new SecureRandom().nextBytes(secret);
        config.secret(com.fuao.harness.protocol.Digests.hex(secret));
        config.identityDirectory(TerminalConfig.defaultIdentityDirectory());
        config.allowedRoots(List.of(System.getProperty("user.home", ".")));

        TerminalRuntime.identityOf(config);
        config.save(configFile);

        System.out.println("installed.");
        System.out.println("  configuration: " + configFile);
        System.out.println("  device identity: " + config.identityDirectory().resolve("device.key"));
        System.out.println("  next: harness-terminal hello, then type the binding code into the console");
        return 0;
    }

    private static void usage() {
        System.out.println("harness terminal " + VERSION);
        System.out.println("usage: harness-terminal <command>");
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
