package com.fuao.harness.platform.web;

import com.fuao.harness.platform.service.AgentService;
import com.fuao.harness.platform.service.SkillDocument;
import com.fuao.harness.platform.service.SkillInstallService;
import com.fuao.harness.platform.service.SkillMarketService;
import com.fuao.harness.platform.service.TerminalService;
import com.fuao.harness.platform.security.ClientAuthenticator.AuthenticationException;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Turns domain exceptions into stable error codes.
 *
 * <p>The mapping is deliberate rather than generic: "you are not a human, this action needs one"
 * (403 {@code HUMAN_REQUIRED}) is a different operational situation from "this agent is not
 * permitted" (403 {@code FORBIDDEN}), and an operator watching dashboards at 3am needs to be able
 * to tell them apart.
 */
@RestControllerAdvice
public class ApiExceptionHandler {

    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ApiExceptionHandler.class);

    /**
     * The portal refused to hire the digital employee, or could not be reached.
     *
     * <p>That is not a bug on the platform's side, so it is not a 500: the operator has to
     * see what the portal said and fix it there.
     */
    @ExceptionHandler(com.fuao.harness.platform.service.PortalClient.PortalRefusedException.class)
    public ResponseEntity<Map<String, Object>> portalRefused(
            com.fuao.harness.platform.service.PortalClient.PortalRefusedException e) {
        log.warn("the portal refused: code={} reason={}", e.code(), e.getMessage());
        HttpStatus status = "NOT_CONFIGURED".equals(e.code())
                ? HttpStatus.SERVICE_UNAVAILABLE
                : HttpStatus.BAD_GATEWAY;
        return ResponseEntity.status(status)
                .body(ApiError.of(e.code(), e.getMessage()).enveloped());
    }

    @ExceptionHandler(AgentService.NotAHumanException.class)
    public ResponseEntity<Map<String, Object>> notAHuman(AgentService.NotAHumanException e) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(ApiError.of("HUMAN_REQUIRED", e.getMessage()).enveloped());
    }

    @ExceptionHandler(AgentService.AgentNotFound.class)
    public ResponseEntity<Map<String, Object>> agentNotFound(AgentService.AgentNotFound e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ApiError.of("AGENT_NOT_FOUND", e.getMessage()).enveloped());
    }

    @ExceptionHandler(AgentService.DuplicateAgentKeyException.class)
    public ResponseEntity<Map<String, Object>> duplicateKey(AgentService.DuplicateAgentKeyException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ApiError.of("DUPLICATE_AGENT_KEY", e.getMessage()).enveloped());
    }

    @ExceptionHandler(com.fuao.harness.policy.ApprovalStateMachine.IllegalTransitionException.class)
    public ResponseEntity<Map<String, Object>> illegalApproval(
            com.fuao.harness.policy.ApprovalStateMachine.IllegalTransitionException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ApiError.of("ILLEGAL_APPROVAL_TRANSITION", e.getMessage()).enveloped());
    }

    @ExceptionHandler(TerminalService.RevokedTerminalException.class)
    public ResponseEntity<Map<String, Object>> revoked(TerminalService.RevokedTerminalException e) {
        return ResponseEntity.status(HttpStatus.GONE)
                .body(ApiError.of("TERMINAL_REVOKED", e.getMessage()).enveloped());
    }

    // ------------------------------------------------------------------ the skill market

    @ExceptionHandler(SkillMarketService.NotAHumanException.class)
    public ResponseEntity<Map<String, Object>> skillNotAHuman(SkillMarketService.NotAHumanException e) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(ApiError.of("HUMAN_REQUIRED", e.getMessage()).enveloped());
    }

    @ExceptionHandler(SkillMarketService.ReviewerIsTheAuthorException.class)
    public ResponseEntity<Map<String, Object>> reviewerIsTheAuthor(
            SkillMarketService.ReviewerIsTheAuthorException e) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(ApiError.of("REVIEWER_IS_THE_AUTHOR", e.getMessage()).enveloped());
    }

    @ExceptionHandler({SkillMarketService.NotTheAuthorException.class,
            SkillMarketService.NotAllowedException.class,
            SkillInstallService.NotAllowedException.class})
    public ResponseEntity<Map<String, Object>> skillForbidden(RuntimeException e) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(ApiError.of("SKILL_NOT_ALLOWED", e.getMessage()).enveloped());
    }

    @ExceptionHandler(SkillMarketService.SkillNotFound.class)
    public ResponseEntity<Map<String, Object>> skillNotFound(SkillMarketService.SkillNotFound e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ApiError.of("SKILL_NOT_FOUND", e.getMessage()).enveloped());
    }

    @ExceptionHandler(SkillMarketService.DuplicateSkillKeyException.class)
    public ResponseEntity<Map<String, Object>> duplicateSkillKey(
            SkillMarketService.DuplicateSkillKeyException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ApiError.of("DUPLICATE_SKILL_KEY", e.getMessage()).enveloped());
    }

    @ExceptionHandler(SkillMarketService.IllegalLifecycleException.class)
    public ResponseEntity<Map<String, Object>> illegalSkillTransition(
            SkillMarketService.IllegalLifecycleException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ApiError.of("ILLEGAL_SKILL_TRANSITION", e.getMessage()).enveloped());
    }

    @ExceptionHandler(SkillMarketService.ConcurrentModificationException.class)
    public ResponseEntity<Map<String, Object>> skillConcurrent(
            SkillMarketService.ConcurrentModificationException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ApiError.of("CONCURRENT_MODIFICATION", e.getMessage()).enveloped());
    }

    @ExceptionHandler(SkillDocument.MalformedSkillException.class)
    public ResponseEntity<Map<String, Object>> malformedSkill(SkillDocument.MalformedSkillException e) {
        return ResponseEntity.badRequest()
                .body(ApiError.of("MALFORMED_SKILL", e.getMessage()).enveloped());
    }

    @ExceptionHandler({IllegalArgumentException.class, IllegalStateException.class})
    public ResponseEntity<Map<String, Object>> badRequest(RuntimeException e) {
        return ResponseEntity.badRequest().body(ApiError.of("REJECTED", e.getMessage()).enveloped());
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Map<String, Object>> unreadable(HttpMessageNotReadableException e) {
        log.warn("malformed request body: {}", e.getMostSpecificCause().getMessage());
        return ResponseEntity.badRequest()
                .body(ApiError.of("MALFORMED_REQUEST", "request body could not be parsed").enveloped());
    }

    /**
     * An unknown path is a 404, not a 500.
     *
     * <p>Without this, a typo in a URL - a missing terminal id, a wrong prefix - comes back as
     * "unhandled failure", which sends the operator looking for a bug in the platform instead
     * of at the URL.
     */
    @ExceptionHandler(org.springframework.web.servlet.resource.NoResourceFoundException.class)
    public ResponseEntity<Map<String, Object>> noSuchPath(Exception e) {
        log.warn("no such path: {}", e.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ApiError.of("NOT_FOUND", "no such endpoint").enveloped());
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> unexpected(Exception e) {
        log.error("unhandled failure: {}", e.getMessage(), e);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiError("INTERNAL", "unhandled failure",
                        Map.of("exception", e.getClass().getSimpleName())).enveloped());
    }

    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<Map<String, Object>> auth(AuthenticationException e) {
        return ResponseEntity.status(e.status()).body(ApiError.of(e.code(), e.getMessage()).enveloped());
    }
}