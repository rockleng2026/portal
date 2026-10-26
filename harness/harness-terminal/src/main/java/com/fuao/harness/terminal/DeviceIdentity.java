package com.fuao.harness.terminal;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Locale;
import java.util.Map;

/**
 * Who this machine is, and the key it signs commands with.
 *
 * <p>The device id is derived from hardware that does not change between reboots (host name plus
 * the first network interface's MAC), so the platform recognises the same machine after a
 * restart or a reinstall. The secret key is generated once and kept on disk; it is what the
 * frame MAC is computed with, and it never leaves the device.
 *
 * <p>Design note: 01 §11.1 says "one employee, one computer, one terminal" and that binding
 * gives the device the account's authority. That authority is bounded twice - by the account and
 * by this device - and both bounds are revocable from the platform within seconds.
 */
public final class DeviceIdentity {

    private static final SecureRandom RANDOM = new SecureRandom();

    private final String deviceId;
    private final byte[] deviceKey;
    private final Path identityFile;

    private DeviceIdentity(String deviceId, byte[] deviceKey, Path identityFile) {
        this.deviceId = deviceId;
        this.deviceKey = deviceKey;
        this.identityFile = identityFile;
    }

    /**
     * Loads the identity of this device, creating it on first run.
     *
     * @param identityDirectory where the key is kept; the directory is created if missing
     */
    public static DeviceIdentity loadOrCreate(Path identityDirectory) throws IOException {
        Files.createDirectories(identityDirectory);
        restrictToOwner(identityDirectory);
        Path file = identityDirectory.resolve("device.key");

        if (Files.exists(file)) {
            String stored = Files.readString(file, StandardCharsets.UTF_8).trim();
            String[] parts = stored.split(":");
            if (parts.length == 3 && "harness-device".equals(parts[0])) {
                restrictToOwner(file);
                return new DeviceIdentity(parts[1], decodeKey(parts[2]), file);
            }
            throw new IOException("identity file " + file + " is corrupt; move it aside to re-register");
        }

        String deviceId = deriveDeviceId();
        byte[] key = new byte[32];
        RANDOM.nextBytes(key);
        Path tmp = identityDirectory.resolve("device.key.tmp");
        Files.writeString(tmp, "harness-device:" + deviceId + ":" + encodeKey(key), StandardCharsets.UTF_8);
        restrictToOwner(tmp);
        Files.move(tmp, file);
        restrictToOwner(file);
        return new DeviceIdentity(deviceId, key, file);
    }

    /**
     * Restricts a file to its owner.
     *
     * <p>The device key is the device's identity; a world-readable copy of it is a copy of the
     * terminal's authority (red-team R-01). On a POSIX filesystem the mode is set explicitly;
     * on Windows the file inherits the per-user profile directory, which is already per-user.
     */
    private static void restrictToOwner(Path path) {
        if (!path.getFileSystem().supportedFileAttributeViews().contains("posix")) {
            return;
        }
        // A directory needs the execute bit to be searchable; a file does not.
        String mode = Files.isDirectory(path) ? "rwx------" : "rw-------";
        try {
            Files.setPosixFilePermissions(path,
                    java.nio.file.attribute.PosixFilePermissions.fromString(mode));
        } catch (IOException | UnsupportedOperationException e) {
            // A filesystem that does not implement POSIX permissions (some network mounts) is not
            // something this program can fix; the directory is still owner-only.
        }
    }

    /** A fixed identity, for tests and for a dry run on a machine that is not the target one. */
    public static DeviceIdentity of(String deviceId, byte[] key) {
        return new DeviceIdentity(deviceId, key, null);
    }

    public String deviceId() {
        return deviceId;
    }

    public byte[] deviceKey() {
        return deviceKey.clone();
    }

    /**
     * A stable fingerprint of the machine.
     *
     * <p>Deliberately boring: host name plus MAC. Anything cleverer (disk serial, BIOS UUID)
     * needs privileges this process should not have and breaks the moment the network interface
     * is replaced.
     */
    public static String deriveDeviceId() {
        String host = "unknown-host";
        try {
            host = java.net.InetAddress.getLocalHost().getHostName();
        } catch (Exception ignored) {
            // fall through to the environment
        }
        String mac = firstMacAddress();
        return hash(host + "|" + mac).substring(0, 32);
    }

    private static String firstMacAddress() {
        try {
            java.util.Enumeration<java.net.NetworkInterface> interfaces =
                    java.net.NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                java.net.NetworkInterface candidate = interfaces.nextElement();
                if (candidate.isLoopback() || !candidate.isUp()) {
                    continue;
                }
                byte[] address = candidate.getHardwareAddress();
                if (address != null && address.length > 0) {
                    StringBuilder sb = new StringBuilder();
                    for (byte b : address) {
                        sb.append(String.format(Locale.ROOT, "%02x", b));
                    }
                    return sb.toString();
                }
            }
        } catch (Exception ignored) {
            // fall through
        }
        return "no-mac";
    }

    private static String hash(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return com.fuao.harness.protocol.Digests.hex(digest.digest(input.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    private static String encodeKey(byte[] key) {
        return Base64.getEncoder().encodeToString(key);
    }

    private static byte[] decodeKey(String encoded) {
        return Base64.getDecoder().decode(encoded);
    }

    /** The public part of the identity, safe to send to the platform. */
    public Map<String, String> publicDescriptor() {
        return java.util.Map.of("deviceId", deviceId, "keyFingerprint", keyFingerprint());
    }

    public String keyFingerprint() {
        return com.fuao.harness.protocol.Digests.sha256Hex(deviceKey).substring(0, 32);
    }

    static void copy(InputStream in, OutputStream out) throws IOException {
        in.transferTo(out);
    }

    static Path defaultIdentityDirectory() {
        String home = System.getProperty("user.home", ".");
        return Paths.get(home, ".harness", "terminal");
    }
}
