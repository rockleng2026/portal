package com.fuao.harness.terminal;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * The terminal's configuration file: where the platform is, who this device is, and what it is
 * allowed to touch.
 *
 * <p>The file holds the device's HMAC secret, so it is written with owner-only permissions and
 * never leaves the machine. There is no portal password in here - the terminal has no way to log
 * into portal even if somebody asks it to (01 §2.3, red-team R-04).
 */
public final class TerminalConfig {

    private URI platformUri;
    private String clientId = "harness-terminal";
    private String secret = "";
    private Path identityDirectory = defaultIdentityDirectory();
    private int autonomyLevel = 0;
    private List<String> allowedRoots = new ArrayList<>();
    private String agentKey = "";
    private Integer portalEmployeeId;

    public URI platformUri() {
        return platformUri;
    }

    public TerminalConfig platformUri(URI value) {
        this.platformUri = value;
        return this;
    }

    public String clientId() {
        return clientId;
    }

    public TerminalConfig clientId(String value) {
        this.clientId = value;
        return this;
    }

    public String secret() {
        return secret;
    }

    public TerminalConfig secret(String value) {
        this.secret = value;
        return this;
    }

    public Path identityDirectory() {
        return identityDirectory;
    }

    public TerminalConfig identityDirectory(Path value) {
        this.identityDirectory = value;
        return this;
    }

    public int autonomyLevel() {
        return autonomyLevel;
    }

    public TerminalConfig autonomyLevel(int value) {
        this.autonomyLevel = value;
        return this;
    }

    public List<String> allowedRoots() {
        return List.copyOf(allowedRoots);
    }

    public TerminalConfig allowedRoots(List<String> value) {
        this.allowedRoots = value == null ? new ArrayList<>() : new ArrayList<>(value);
        return this;
    }

    public String agentKey() {
        return agentKey;
    }

    public TerminalConfig agentKey(String value) {
        this.agentKey = value;
        return this;
    }

    public Integer portalEmployeeId() {
        return portalEmployeeId;
    }

    public TerminalConfig portalEmployeeId(Integer value) {
        this.portalEmployeeId = value;
        return this;
    }

    public static Path defaultIdentityDirectory() {
        String home = System.getProperty("user.home", ".");
        return Paths.get(home, ".harness", "terminal");
    }

    public static Path defaultConfigFile() {
        return defaultIdentityDirectory().resolve("terminal.properties");
    }

    /** Reads the configuration; missing file means "not installed yet". */
    public static TerminalConfig load(Path file) throws IOException {
        TerminalConfig config = new TerminalConfig();
        if (!Files.exists(file)) {
            return config;
        }
        Properties properties = new Properties();
        try (InputStream in = Files.newInputStream(file)) {
            properties.load(in);
        }
        String uri = properties.getProperty("platform.url", "");
        if (!uri.isBlank()) {
            config.platformUri = URI.create(uri);
        }
        config.clientId = properties.getProperty("client.id", config.clientId);
        config.secret = properties.getProperty("secret", "");
        config.identityDirectory = Paths.get(properties.getProperty("identity.directory",
                config.identityDirectory.toString()));
        config.autonomyLevel = Integer.parseInt(properties.getProperty("autonomy.level", "0"));
        config.agentKey = properties.getProperty("agent.key", "");
        String employee = properties.getProperty("portal.employee.id", "");
        if (!employee.isBlank()) {
            config.portalEmployeeId = Integer.parseInt(employee);
        }
        List<String> roots = new ArrayList<>();
        String rootList = properties.getProperty("allowed.roots", "");
        for (String root : rootList.split(",")) {
            if (!root.isBlank()) {
                roots.add(root.trim());
            }
        }
        config.allowedRoots = roots;
        return config;
    }

    /** Writes the configuration with owner-only permissions. */
    public void save(Path file) throws IOException {
        Path parent = file.getParent();
        if (parent != null) {
            Files.createDirectories(parent);
        }
        Properties properties = new Properties();
        properties.setProperty("platform.url", platformUri == null ? "" : platformUri.toString());
        properties.setProperty("client.id", clientId);
        properties.setProperty("secret", secret);
        properties.setProperty("identity.directory", identityDirectory.toString());
        properties.setProperty("autonomy.level", String.valueOf(autonomyLevel));
        properties.setProperty("agent.key", agentKey);
        if (portalEmployeeId != null) {
            properties.setProperty("portal.employee.id", String.valueOf(portalEmployeeId));
        }
        properties.setProperty("allowed.roots", String.join(",", allowedRoots));
        try (var out = Files.newOutputStream(file)) {
            properties.store(out, "harness terminal configuration");
        }
        try {
            if (file.getFileSystem().supportedFileAttributeViews().contains("posix")) {
                Files.setPosixFilePermissions(file,
                        java.nio.file.attribute.PosixFilePermissions.fromString("rw-------"));
            }
        } catch (IOException | UnsupportedOperationException e) {
            // Nothing to do; the platform treats the device as revocable regardless.
        }
    }

    /** The configuration as the platform and the operator see it - without the secret. */
    public Map<String, Object> describe() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("platformUrl", platformUri == null ? "" : platformUri.toString());
        out.put("clientId", clientId);
        out.put("autonomyLevel", autonomyLevel);
        out.put("agentKey", agentKey);
        out.put("allowedRoots", List.copyOf(allowedRoots));
        out.put("secretConfigured", !secret.isBlank());
        return out;
    }

    static String utf8(byte[] bytes) {
        return new String(bytes, StandardCharsets.UTF_8);
    }
}
