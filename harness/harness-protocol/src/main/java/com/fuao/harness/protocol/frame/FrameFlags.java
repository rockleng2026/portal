package com.fuao.harness.protocol.frame;

import java.util.EnumSet;
import java.util.Set;

/** Frame flags (03 §3.2): bit0 ACK required, bit1 gzip, bit2 idempotent retry, bit3 urgent. */
public final class FrameFlags {

    public static final int ACK_REQUIRED = 1;
    public static final int GZIP = 1 << 1;
    public static final int IDEMPOTENT_RETRY = 1 << 2;
    public static final int URGENT = 1 << 3;

    private FrameFlags() {
    }

    public static Set<FrameFlags.Bit> decode(int raw) {
        Set<FrameFlags.Bit> set = EnumSet.noneOf(Bit.class);
        if ((raw & ACK_REQUIRED) != 0) {
            set.add(Bit.ACK_REQUIRED);
        }
        if ((raw & GZIP) != 0) {
            set.add(Bit.GZIP);
        }
        if ((raw & IDEMPOTENT_RETRY) != 0) {
            set.add(Bit.IDEMPOTENT_RETRY);
        }
        if ((raw & URGENT) != 0) {
            set.add(Bit.URGENT);
        }
        return set;
    }

    public static int encode(Set<Bit> flags) {
        int raw = 0;
        for (Bit b : flags) {
            raw |= b.mask;
        }
        return raw;
    }

    public enum Bit {
        // Qualified: inside the enum body the simple names would resolve to the constants
        // themselves and the initialiser would self-reference.
        ACK_REQUIRED(FrameFlags.ACK_REQUIRED),
        GZIP(FrameFlags.GZIP),
        IDEMPOTENT_RETRY(FrameFlags.IDEMPOTENT_RETRY),
        URGENT(FrameFlags.URGENT);

        final int mask;

        Bit(int mask) {
            this.mask = mask;
        }

        public int mask() {
            return mask;
        }
    }
}