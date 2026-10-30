package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.platform.security.AuthContext;
import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Hiring a digital employee into the portal.
 *
 * <p>The portal has its own employee table. A digital employee that is not in it does not
 * exist for the people who work there: no org tree, no directory, no task pickers, no
 * reports that count people (ADR-002). So the platform writes the row - it is the only party
 * that knows what the employee is called, which department it belongs to and which agent key
 * it carries.
 *
 * <p>Two things are decided here rather than by the operator typing them into a form:
 * <ul>
 *   <li>the <b>department</b>: the agent's own department. A digital employee that lands in
 *       department 1 is not "in a department", it is in the root, and it shows up in every
 *       org report as if it were nobody's colleague;</li>
 *   <li>the <b>employee number</b>: the portal writes a digital-employee number with a
 *       prefix, so it can never be mistaken for a normal employee's number (a string of
 *       digits: region + department + sequence).</li>
 * </ul>
 *
 * <p>The preview exists because the write is not undoable by clicking somewhere else: the
 * operator sees exactly what will be written before anything is written.
 */
@Service
public class OnboardingService {

    private final AgentRepository agents;
    private final PortalClient portal;
    private final AuthContext authContext;

    public OnboardingService(AgentRepository agents, PortalClient portal, AuthContext authContext) {
        this.agents = agents;
        this.portal = portal;
        this.authContext = authContext;
    }

    /** What would be written into the portal. Nothing is written by asking. */
    public Map<String, Object> preview(String agentId) {
        AgentRecord agent = agents.findById(agentId)
                .orElseThrow(() -> new AgentService.AgentNotFound("no such agent: " + agentId));
        Map<String, Object> view = new LinkedHashMap<>();
        view.put("agentId", agent.agentId());
        view.put("agentKey", agent.agentKey());
        view.put("name", agent.name());
        view.put("deptId", agent.deptId());
        view.put("workpositionId", agent.portalWorkpositionId());
        view.put("ownerId", agent.ownerId());
        view.put("loginName", agent.agentKey());
        view.put("portalEmployeeId", agent.portalEmployeeId());
        view.put("portalUserId", agent.portalUserId());
        view.put("alreadyOnboarded", agent.portalEmployeeId() != null);
        view.put("portalConfigured", portal.configured());
        if (!portal.configured()) {
            view.put("portalMissing", portal.missingConfiguration());
            return view;
        }
        // The employee number is the portal's to decide: it knows the department codes and
        // the sequence. Asking is the only way the preview can be true.
        try {
            Map<String, Object> answer = portal.preview(command(agent));
            Object number = answer.get("employeeNumber");
            view.put("employeeNumber", number == null ? "" : String.valueOf(number));
            Object rule = answer.get("employeeNumberRule");
            view.put("employeeNumberRule", rule == null ? "" : String.valueOf(rule));
            Object deptName = answer.get("deptName");
            view.put("deptName", deptName == null ? "" : String.valueOf(deptName));
        } catch (RuntimeException e) {
            view.put("employeeNumber", "");
            view.put("employeeNumberRule", "");
            view.put("portalPreviewError", String.valueOf(e.getMessage()));
        }
        return view;
    }

    /** The fields the portal writes. */
    private PortalClient.OnboardCommand command(AgentRecord agent) {
        return new PortalClient.OnboardCommand(
                agent.agentKey(),
                agent.name(),
                agent.deptId() == null ? 0 : agent.deptId(),
                agent.portalWorkpositionId(),
                null,
                null,
                agent.agentKey());
    }

    /**
     * Writes the digital employee into the portal and records what the portal said.
     *
     * @return the portal's answer, plus the employee and user ids the platform now knows
     */
    @Transactional
    public Map<String, Object> onboard(String agentId) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "hiring a digital employee into the portal requires a natural human, caller was "
                            + actor.actorType());
        }
        AgentRecord agent = agents.findById(agentId)
                .orElseThrow(() -> new AgentService.AgentNotFound("no such agent: " + agentId));
        if (agent.deptId() == null || agent.deptId() <= 0) {
            throw new IllegalArgumentException(
                    "数字员工 " + agent.agentKey() + " 没有部门。入职 portal 前先给它一个部门——"
                            + "否则它只能落在根部门，看起来不属于任何人。");
        }
        if (!portal.configured()) {
            throw new PortalClient.PortalRefusedException("NOT_CONFIGURED", portal.missingConfiguration());
        }

        Map<String, Object> answer = portal.onboard(command(agent));

        Integer employeeId = PortalClient.employeeId(answer).orElse(null);
        Integer userId = PortalClient.userId(answer).orElse(null);
        if (employeeId == null) {
            throw new PortalClient.PortalRefusedException("NO_EMPLOYEE_ID",
                    "portal 没有返回 employee id：" + answer);
        }
        agents.attachPortalIdentity(agentId, employeeId, userId);

        Map<String, Object> result = new LinkedHashMap<>(answer);
        result.put("employeeId", employeeId);
        result.put("userId", userId);
        result.put("deptId", agent.deptId());
        result.put("employeeNumber", employeeNumber(agent, answer));
        return result;
    }

    /**
     * The employee number the portal wrote.
     *
     * <p>A normal employee's number is a string of digits - region, department, sequence. A
     * digital employee gets the same shape with a prefix, so the two can never be confused:
     * no report, no export and no import may mistake a digital employee for a colleague.
     */
    private String employeeNumber(AgentRecord agent, Map<String, Object> answer) {
        Object number = answer.get("employeeNumber");
        if (number != null && !String.valueOf(number).isBlank()) {
            return String.valueOf(number);
        }
        return "AI-" + (agent.deptId() == null ? 0 : agent.deptId());
    }
}
