package com.fuao.harness.policy;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Instant;
import java.util.List;
import org.junit.jupiter.api.Test;

class EscalationRouterTest {

    private EscalationRouter.Context ctx(int hop, String reportsTo, Integer director, Integer projectOwner) {
        return new EscalationRouter.Context("agent-a", "agent:leon:sales:sh001", hop, reportsTo,
                director, projectOwner, true, List.of());
    }

    @Test
    void firstHopGoesToTheDirectReport() {
        EscalationRouter.Route r = EscalationRouter.route(ctx(0, "agent-b", 100, null));

        assertEquals(EscalationRouter.Type.AGENT, r.recipient().type());
        assertEquals("agent-b", r.recipient().id());
        assertEquals(1, r.hop());
    }

    @Test
    void theThirdHopIsForcedOntoAHuman() {
        // R-06: agents must not be able to pass blame upwards forever.
        EscalationRouter.Route r = EscalationRouter.route(ctx(2, "agent-c", 100, null));

        assertEquals(EscalationRouter.Type.HUMAN, r.recipient().type());
        assertEquals(100, r.recipient().portalEmployeeId());
        assertTrue(r.humanInvolved());
        assertTrue(r.recipient().reason().contains("hop cap"));
    }

    @Test
    void aBrokenReportingLineAlsoEndsAtAHuman() {
        EscalationRouter.Route r = EscalationRouter.route(ctx(0, null, 100, null));
        assertEquals(EscalationRouter.Type.HUMAN, r.recipient().type());
    }

    @Test
    void theProjectOwnerIsCopiedInParallelWhenPresent() {
        EscalationRouter.Route r = EscalationRouter.route(ctx(0, "agent-b", 100, 500));
        assertEquals(List.of(500), r.copiedTo());
    }

    @Test
    void anAlreadyNotifiedHumanIsNotHandedTheSameThingTwice() {
        EscalationRouter.Context alreadyTold = new EscalationRouter.Context("agent-a", "agent:leon",
                2, "agent-c", 100, null, true, List.of(100));

        EscalationRouter.Route r = EscalationRouter.route(alreadyTold);
        assertEquals(EscalationRouter.Type.HUMAN, r.recipient().type());
        assertEquals(null, r.recipient().portalEmployeeId(),
                "director already informed: page the platform owner instead of looping");
        assertTrue(r.recipient().reason().contains("manually"));
    }

    @Test
    void theProjectOwnerIsTheLastResort() {
        EscalationRouter.Context ctx = new EscalationRouter.Context("agent-a", "agent:leon", 5, null,
                100, 500, true, List.of(100));

        EscalationRouter.Route r = EscalationRouter.route(ctx);
        assertEquals(EscalationRouter.Type.PROJECT_OWNER, r.recipient().type());
        assertEquals(500, r.recipient().portalEmployeeId());
    }
}