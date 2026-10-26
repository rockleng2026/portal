package com.fuao.harness.platform.web;

import com.fuao.harness.platform.service.AgentService;
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