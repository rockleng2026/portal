package com.fuao.harness.policy;

import java.util.List;

/**
 * Escalation routing: "everything outside my remit goes to my boss or to the project office"
 * (01 §5.4).
 *
 * <p>The rule that people argue about is the hop cap. Agents that may escalate forever produce
 * exactly the organisational pathology red-team R-06 describes: AI passes blame upwards, nobody
 * is left holding it. So: at most {@value #MAX_HOPS} hops while the receiver is another agent,
 * and then a human - always.
 */
public final class EscalationRouter {

    /** After this many agent-to-agent hops the router must pick a human. */
    public static final int MAX_HOPS = 2;

    public record Recipient(Type type, String id, Integer portalEmployeeId, String reason) {
    }

    public enum Type {
        AGENT,
        HUMAN,
        PROJECT_OWNER
    }

    /**
     * Input needed to route one escalation: who is escalating, how far it has travelled, and
     * who is above whom.
     *
     * @param reportsToAgentId   next agent up the reporting line, or {@code null}
     * @param departmentDirector portal.employee.id of {@code department.directorId} (01 §5.4)
     * @param projectOwnerId     portal.employee.id of the project manager, notified in parallel
     * @param alreadyNotified    employee ids already copied on this escalation, to avoid loops
     */
    public record Context(
            String agentId,
            String agentKey,
            int hop,
            String reportsToAgentId,
            Integer departmentDirectorId,
            Integer projectOwnerId,
            boolean outOfScope,
            List<Integer> alreadyNotified) {

        public Context {
            alreadyNotified = alreadyNotified == null ? List.of() : List.copyOf(alreadyNotified);
        }
    }

    private EscalationRouter() {
    }

    /**
     * Picks the receiver.
     *
     * @return the recipient plus the hop number to record in {@code harness_escalation.hop}
     */
    public static Route route(Context ctx) {
        if (ctx.hop() >= MAX_HOPS || ctx.reportsToAgentId() == null || ctx.reportsToAgentId().isBlank()) {
            return forceHuman(ctx);
        }
        Integer director = ctx.departmentDirectorId();
        // The escalation is pointless if it goes to someone who already saw it.
        if (director != null && ctx.alreadyNotified().contains(director) && ctx.projectOwnerId() == null) {
            return forceHuman(ctx);
        }
        return new Route(
                new Recipient(Type.AGENT, ctx.reportsToAgentId(), null,
                        "hop " + (ctx.hop() + 1) + ": outside the remit of " + ctx.agentKey()
                                + (ctx.outOfScope() ? " (outside position permissions)" : "")),
                ctx.hop() + 1,
                false,
                projectOwnerCopy(ctx));
    }

    /** No further agent hops: hand it to the department director, or the project owner if needed. */
    public static Route forceHuman(Context ctx) {
        Integer director = ctx.departmentDirectorId();
        if (director != null && !ctx.alreadyNotified().contains(director)) {
            return new Route(
                    new Recipient(Type.HUMAN, "human:" + director, director,
                            "hop " + (ctx.hop() + 1) + ": escalation chain for " + ctx.agentKey()
                                    + " hit the " + MAX_HOPS + "-hop cap (R-06), a human must own this"),
                    ctx.hop() + 1,
                    true,
                    projectOwnerCopy(ctx));
        }
        if (ctx.projectOwnerId() != null) {
            return new Route(
                    new Recipient(Type.PROJECT_OWNER, "human:" + ctx.projectOwnerId(), ctx.projectOwnerId(),
                            "hop " + (ctx.hop() + 1) + ": no untouched human left in the reporting line, "
                                    + "handed to the project management side"),
                    ctx.hop() + 1,
                    true,
                    List.of());
        }
        return new Route(
                new Recipient(Type.HUMAN, "human:0", null,
                        "hop " + (ctx.hop() + 1) + ": no reachable human recipient; "
                                + "the platform owner must be paged manually"),
                ctx.hop() + 1,
                true,
                List.of());
    }

    private static List<Integer> projectOwnerCopy(Context ctx) {
        Integer owner = ctx.projectOwnerId();
        if (owner == null || ctx.alreadyNotified().contains(owner)) {
            return List.of();
        }
        return List.of(owner);
    }

    public record Route(Recipient recipient, int hop, boolean humanInvolved, List<Integer> copiedTo) {
    }
}