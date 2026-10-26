package com.fuao.harness.protocol.frame;

import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.SecureRandom;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Encodes and decodes {@link Frame}s on the terminal control channel (03 §3.2 - §3.4).
 *
 * <p>The decoder is defensive on purpose: a hostile or buggy peer can send a bogus
 * {@code LENGTH}, so the length is bounded before a single byte of payload is allocated.
 * Callers must additionally call {@link Frame#verifyMac(byte[])}; this class only checks the
 * structural invariants (magic, version, declared length).
 */
public final class FrameCodec {

    /** Refuse anything larger; a terminal command is metadata plus an object-storage ref. */
    public static final int MAX_PAYLOAD_BYTES = 1 << 20; // 1 MiB

    private static final SecureRandom RANDOM = new SecureRandom();
    private static final AtomicLong SEQ = new AtomicLong(System.nanoTime());

    private FrameCodec() {
    }

    /** Monotonic per-process sequence number (03 §3.4: monotonic on the sender side). */
    public static long nextSeq() {
        return SEQ.incrementAndGet();
    }

    public static long randomNonce() {
        return RANDOM.nextLong();
    }

    /** Serialises a frame, computing the MAC with the given device key. */
    public static byte[] encode(Frame frame, byte[] deviceKey) {
        byte[] signedBytes = frame.signedBytes();
        byte[] mac = frame.computeMac(deviceKey);
        byte[] out = new byte[signedBytes.length + mac.length];
        System.arraycopy(signedBytes, 0, out, 0, signedBytes.length);
        System.arraycopy(mac, 0, out, signedBytes.length, mac.length);
        return out;
    }

    public static void write(OutputStream out, Frame frame, byte[] deviceKey) throws IOException {
        out.write(encode(frame, deviceKey));
        out.flush();
    }

    /** Reads exactly one frame. Returns {@code null} on clean EOF. */
    public static Frame read(InputStream in) throws IOException {
        byte[] header = readFully(in, Frame.HEADER_LENGTH, true);
        if (header == null) {
            return null;
        }
        if (header[0] != Frame.MAGIC_HI || header[1] != Frame.MAGIC_LO) {
            throw new IOException("bad magic; not a harness frame");
        }
        byte version = header[2];
        if (version != Frame.VERSION) {
            throw new IOException("unsupported frame version " + version);
        }
        FrameType type = FrameType.fromCode(header[3] & 0xFF);
        int flags = header[4] & 0xFF;
        int length = Frame.readIntBE(header, 5);
        if (length < 0 || length > MAX_PAYLOAD_BYTES) {
            throw new IOException("payload length out of bounds: " + length);
        }
        long seq = Frame.readLongBE(header, 9);
        long nonce = Frame.readLongBE(header, 17);

        byte[] rest = readFully(in, length + Frame.HMAC_LENGTH, false);
        if (rest == null) {
            throw new EOFException("truncated frame: expected " + (length + Frame.HMAC_LENGTH) + " more bytes");
        }
        byte[] payload = new byte[length];
        System.arraycopy(rest, 0, payload, 0, length);
        byte[] mac = new byte[Frame.HMAC_LENGTH];
        System.arraycopy(rest, length, mac, 0, Frame.HMAC_LENGTH);

        return new Frame(version, type, flags, seq, nonce, payload, mac);
    }

    private static byte[] readFully(InputStream in, int n, boolean allowCleanEof) throws IOException {
        byte[] buf = new byte[n];
        int off = 0;
        while (off < n) {
            int r = in.read(buf, off, n - off);
            if (r < 0) {
                if (off == 0 && allowCleanEof) {
                    return null;
                }
                throw new EOFException("stream ended after " + off + " of " + n + " bytes");
            }
            off += r;
        }
        return buf;
    }
}