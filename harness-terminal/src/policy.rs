//! The agent's own authority (red-team R-01).
//!
//! The platform decides what the agent *may* do; this decides what it *will* do. The two are
//! not the same thing, because the platform can be wrong, the edge can be compromised, and a
//! tool argument can be hostile. So every tool call is checked here, on the machine, before it
//! touches anything:
//!
//! * the capability must have been granted to this terminal;
//! * the command's minimum autonomy level must not exceed the terminal's level;
//! * every path must be inside an allowed root, resolved and normalised first;
//! * a destructive call needs a fresh, signed approval token, and the token is spent by the
//!   first use.
//!
//! The approval is **bound**: it names the command, the capability and the path it was given
//! for. A signature that verifies is not enough.

use anyhow::{anyhow, Result};
use ed25519_dalek::{Signature, VerifyingKey, Verifier};
use sha2::{Digest, Sha256};
use std::collections::{BTreeMap, BTreeSet};
use std::path::{Path, PathBuf};

/// The autonomy levels (01 §5.3).
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum AutonomyLevel {
    /// Observe only: read and report.
    L0,
    /// Suggest: produce drafts, a human executes them.
    L1,
    /// Low-risk writes: own drafts, own tickets, test environments.
    L2,
    /// Medium-risk writes: production but reversible, reported afterwards.
    L3,
    /// High-risk: irreversible. Off by default, opened per task with two approvals.
    L4,
}

impl AutonomyLevel {
    pub fn as_u8(self) -> u8 {
        match self {
            AutonomyLevel::L0 => 0,
            AutonomyLevel::L1 => 1,
            AutonomyLevel::L2 => 2,
            AutonomyLevel::L3 => 3,
            AutonomyLevel::L4 => 4,
        }
    }

    pub fn from_u8(value: u8) -> Self {
        match value {
            0 => AutonomyLevel::L0,
            1 => AutonomyLevel::L1,
            2 => AutonomyLevel::L2,
            3 => AutonomyLevel::L3,
            _ => AutonomyLevel::L4,
        }
    }

    /// Whether this level is allowed to run a command whose minimum is `required`.
    pub fn allows(self, required: AutonomyLevel) -> bool {
        self >= required
    }
}

/// The decision for one tool call.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct PolicyDecision {
    pub allowed: bool,
    pub reason_code: &'static str,
    pub reason: String,
}

impl PolicyDecision {
    pub fn allow() -> Self {
        Self {
            allowed: true,
            reason_code: "OK",
            reason: "allowed".to_string(),
        }
    }

    pub fn deny(code: &'static str, reason: impl Into<String>) -> Self {
        Self {
            allowed: false,
            reason_code: code,
            reason: reason.into(),
        }
    }
}

/// A one-time approval for a destructive call.
///
/// Signed by the platform with Ed25519; the agent holds the platform's public key and verifies
/// the signature itself. Without this, "a human approved it" would be whatever the edge claims.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ApprovalToken {
    pub approval_id: String,
    /// Unix seconds.
    pub expires_at: u64,
    /// The command the approval was given for.
    pub command: Option<String>,
    /// The capability the approval was given for.
    pub cap_key: Option<String>,
    /// The path the approval was given for.
    pub target_path: Option<String>,
    /// The Ed25519 signature over the canonical payload, hex encoded.
    pub signature: String,
}

impl ApprovalToken {
    /// The canonical payload the signature is computed over.
    ///
    /// Field order is fixed and the fields are separated by a newline, so both sides produce
    /// the same bytes without agreeing on a JSON serialiser.
    pub fn canonical_payload(&self) -> Vec<u8> {
        format!(
            "{}\n{}\n{}\n{}\n{}\n{}",
            self.approval_id,
            self.command.as_deref().unwrap_or(""),
            self.cap_key.as_deref().unwrap_or(""),
            self.target_path.as_deref().unwrap_or(""),
            self.expires_at,
            self.signature
        )
        .into_bytes()
    }

    /// The digest of the payload, which is what the signature is computed over.
    pub fn payload_digest(&self) -> [u8; 32] {
        let mut hasher = Sha256::new();
        hasher.update(self.canonical_payload());
        hasher.finalize().into()
    }
}

/// What this agent is allowed to do.
#[derive(Debug, Clone)]
pub struct LocalPolicy {
    autonomy_level: AutonomyLevel,
    capabilities: BTreeSet<String>,
    allowed_roots: Vec<PathBuf>,
    spent_approvals: BTreeSet<String>,
    /// The platform's public key, hex encoded. An approval is only accepted when it verifies
    /// against it.
    platform_public_key: Option<String>,
}

impl LocalPolicy {
    /// A policy with nothing granted. Nothing is allowed until somebody grants it.
    pub fn empty() -> Self {
        Self {
            autonomy_level: AutonomyLevel::L0,
            capabilities: BTreeSet::new(),
            allowed_roots: Vec::new(),
            spent_approvals: BTreeSet::new(),
            platform_public_key: None,
        }
    }

    pub fn new(
        autonomy_level: AutonomyLevel,
        capabilities: impl IntoIterator<Item = String>,
        allowed_roots: impl IntoIterator<Item = PathBuf>,
    ) -> Self {
        Self {
            autonomy_level,
            capabilities: capabilities.into_iter().collect(),
            allowed_roots: allowed_roots
                .into_iter()
                .map(|p| crate::workspace::normalize(&p))
                .collect(),
            spent_approvals: BTreeSet::new(),
            platform_public_key: None,
        }
    }

    pub fn with_platform_key(mut self, key: impl Into<String>) -> Self {
        self.platform_public_key = Some(key.into());
        self
    }

    pub fn autonomy_level(&self) -> AutonomyLevel {
        self.autonomy_level
    }

    pub fn set_autonomy_level(&mut self, level: AutonomyLevel) {
        self.autonomy_level = level;
    }

    pub fn capabilities(&self) -> &BTreeSet<String> {
        &self.capabilities
    }

    pub fn grant(&mut self, cap_key: impl Into<String>) {
        self.capabilities.insert(cap_key.into());
    }

    pub fn revoke_capability(&mut self, cap_key: &str) {
        self.capabilities.remove(cap_key);
    }

    pub fn allowed_roots(&self) -> &[PathBuf] {
        &self.allowed_roots
    }

    /// Revokes everything. From this moment every call is refused (A0-5).
    pub fn revoke(&mut self) {
        self.capabilities.clear();
        self.spent_approvals.clear();
    }

    /// Whether a path is inside one of the allowed roots.
    ///
    /// The comparison is by path segment, so `/srv/data/../etc` cannot step out of `/srv/data`.
    pub fn is_within_allowed_roots(&self, path: &Path) -> bool {
        if self.allowed_roots.is_empty() {
            return false;
        }
        let normalised = crate::workspace::normalize(path);
        self.allowed_roots.iter().any(|root| normalised.starts_with(root))
    }

    /// Checks one tool call.
    ///
    /// `command` is the tool name, `cap_key` the capability it needs (if any), `target_path`
    /// the path it touches (if any), and `approval` the approval that came with it (if any).
    pub fn check(
        &self,
        command: &str,
        cap_key: Option<&str>,
        target_path: Option<&Path>,
        approval: Option<&ApprovalToken>,
        min_level: AutonomyLevel,
        requires_approval: bool,
        now_epoch: u64,
    ) -> PolicyDecision {
        if let Some(cap) = cap_key {
            if !self.capabilities.contains(cap) {
                return PolicyDecision::deny(
                    "CAPABILITY_NOT_GRANTED",
                    format!("capability {cap} was never granted to this agent"),
                );
            }
        }
        if !self.autonomy_level.allows(min_level) {
            return PolicyDecision::deny(
                "AUTONOMY_TOO_LOW",
                format!(
                    "{command} needs level L{}, this agent runs at L{}",
                    min_level.as_u8(),
                    self.autonomy_level.as_u8()
                ),
            );
        }
        if let Some(path) = target_path {
            if !self.is_within_allowed_roots(path) {
                return PolicyDecision::deny(
                    "PATH_OUTSIDE_ALLOWED_ROOTS",
                    format!("path {} is outside the roots this agent may touch", path.display()),
                );
            }
        }
        if requires_approval {
            let Some(token) = approval else {
                return PolicyDecision::deny(
                    "APPROVAL_REQUIRED",
                    format!("{command} needs a fresh human approval token"),
                );
            };
            if token.expires_at <= now_epoch {
                return PolicyDecision::deny(
                    "APPROVAL_EXPIRED",
                    format!("the approval token {} has expired", token.approval_id),
                );
            }
            if self.spent_approvals.contains(&token.approval_id) {
                return PolicyDecision::deny(
                    "APPROVAL_ALREADY_USED",
                    format!("the approval token {} was already spent", token.approval_id),
                );
            }
            if let Some(mismatch) = approval_mismatch(token, command, cap_key, target_path) {
                return mismatch;
            }
        }
        PolicyDecision::allow()
    }

    /// Marks an approval as spent: one approval buys exactly one execution.
    pub fn spend(&mut self, approval: &ApprovalToken) {
        self.spent_approvals.insert(approval.approval_id.clone());
    }

    /// Whether an approval's signature is acceptable.
    ///
    /// The platform's key is Ed25519 and the signature is over the canonical payload. When no
    /// platform key is configured, an approval is refused: an unverifiable approval is not an
    /// approval.
    pub fn verifies(&self, approval: &ApprovalToken) -> bool {
        let Some(key) = &self.platform_public_key else {
            return false;
        };
        let Ok(key_bytes) = hex::decode(key) else {
            return false;
        };
        let Ok(key_array) = <[u8; 32]>::try_from(key_bytes.as_slice()) else {
            return false;
        };
        let Ok(signature) = hex::decode(&approval.signature) else {
            return false;
        };
        let Ok(sig) = Signature::from_slice(&signature) else {
            return false;
        };
        let Ok(verifying_key) = VerifyingKey::from_bytes(&key_array) else {
            return false;
        };
        verifying_key.verify(&approval.payload_digest(), &sig).is_ok()
    }

    /// The policy as the platform would like to see it.
    pub fn describe(&self) -> BTreeMap<String, String> {
        let mut out = BTreeMap::new();
        out.insert("autonomyLevel".into(), self.autonomy_level.as_u8().to_string());
        out.insert(
            "capabilities".into(),
            self.capabilities.iter().cloned().collect::<Vec<_>>().join(","),
        );
        out.insert(
            "allowedRoots".into(),
            self.allowed_roots
                .iter()
                .map(|p| p.display().to_string())
                .collect::<Vec<_>>()
                .join(","),
        );
        out.insert("spentApprovals".into(), self.spent_approvals.len().to_string());
        out
    }
}

/// Whether the approval covers exactly what is about to happen.
fn approval_mismatch(
    token: &ApprovalToken,
    command: &str,
    cap_key: Option<&str>,
    target_path: Option<&Path>,
) -> Option<PolicyDecision> {
    if let Some(approved) = &token.command {
        if approved != command {
            return Some(PolicyDecision::deny(
                "APPROVAL_SCOPE_MISMATCH",
                format!("the approval was given for {approved}, not {command}"),
            ));
        }
    }
    if let (Some(approved), Some(requested)) = (&token.cap_key, cap_key) {
        if approved != requested {
            return Some(PolicyDecision::deny(
                "APPROVAL_SCOPE_MISMATCH",
                format!("the approval was given for {approved}, not {requested}"),
            ));
        }
    }
    if let Some(approved) = &token.target_path {
        let requested = target_path.map(|p| p.to_string_lossy().to_string());
        if Some(approved.clone()) != requested {
            return Some(PolicyDecision::deny(
                "APPROVAL_SCOPE_MISMATCH",
                format!("the approval was given for {approved}, not the requested path"),
            ));
        }
    }
    None
}

/// The result of a policy check that failed hard.
pub fn policy_error(decision: &PolicyDecision) -> Result<()> {
    if decision.allowed {
        Ok(())
    } else {
        Err(anyhow!("{}: {}", decision.reason_code, decision.reason))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn policy() -> LocalPolicy {
        LocalPolicy::new(
            AutonomyLevel::L3,
            vec![
                "cap:fs.read".to_string(),
                "cap:fs.write".to_string(),
                "cap:fs.delete".to_string(),
                "cap:shell.exec".to_string(),
            ],
            vec![PathBuf::from("/srv/data")],
        )
    }

    fn token(command: &str, cap: &str, path: Option<&str>) -> ApprovalToken {
        ApprovalToken {
            approval_id: "appr-1".to_string(),
            expires_at: 2_000_000_000,
            command: Some(command.to_string()),
            cap_key: Some(cap.to_string()),
            target_path: path.map(str::to_string),
            signature: String::new(),
        }
    }

    #[test]
    fn an_ungranted_capability_is_refused() {
        let decision = policy().check(
            "shell_exec",
            Some("cap:ssh.exec"),
            None,
            None,
            AutonomyLevel::L3,
            false,
            100,
        );
        assert!(!decision.allowed);
        assert_eq!(decision.reason_code, "CAPABILITY_NOT_GRANTED");
    }

    #[test]
    fn a_command_above_the_level_is_refused() {
        let decision = policy().check(
            "shell_exec",
            Some("cap:shell.exec"),
            None,
            None,
            AutonomyLevel::L4,
            false,
            100,
        );
        assert!(!decision.allowed);
        assert_eq!(decision.reason_code, "AUTONOMY_TOO_LOW");
    }

    #[test]
    fn a_path_outside_the_roots_is_refused() {
        let decision = policy().check(
            "read_file",
            Some("cap:fs.read"),
            Some(Path::new("/etc/passwd")),
            None,
            AutonomyLevel::L1,
            false,
            100,
        );
        assert!(!decision.allowed);
        assert_eq!(decision.reason_code, "PATH_OUTSIDE_ALLOWED_ROOTS");
    }

    #[test]
    fn a_dot_dot_path_cannot_escape_the_roots() {
        let decision = policy().check(
            "read_file",
            Some("cap:fs.read"),
            Some(Path::new("/srv/data/../../etc/passwd")),
            None,
            AutonomyLevel::L1,
            false,
            100,
        );
        assert!(!decision.allowed);
        assert_eq!(decision.reason_code, "PATH_OUTSIDE_ALLOWED_ROOTS");
    }

    #[test]
    fn a_destructive_call_needs_an_approval() {
        let decision = policy().check(
            "delete_file",
            Some("cap:fs.delete"),
            Some(Path::new("/srv/data/a.txt")),
            None,
            AutonomyLevel::L3,
            true,
            100,
        );
        assert!(!decision.allowed);
        assert_eq!(decision.reason_code, "APPROVAL_REQUIRED");
    }

    #[test]
    fn an_expired_approval_is_refused() {
        let mut expired = token("delete_file", "cap:fs.delete", Some("/srv/data/a.txt"));
        expired.expires_at = 50;
        let decision = policy().check(
            "delete_file",
            Some("cap:fs.delete"),
            Some(Path::new("/srv/data/a.txt")),
            Some(&expired),
            AutonomyLevel::L3,
            true,
            100,
        );
        assert!(!decision.allowed);
        assert_eq!(decision.reason_code, "APPROVAL_EXPIRED");
    }

    #[test]
    fn one_approval_buys_one_execution() {
        let mut policy = policy();
        let approval = token("delete_file", "cap:fs.delete", Some("/srv/data/a.txt"));
        let first = policy.check(
            "delete_file",
            Some("cap:fs.delete"),
            Some(Path::new("/srv/data/a.txt")),
            Some(&approval),
            AutonomyLevel::L3,
            true,
            100,
        );
        assert!(first.allowed, "{}", first.reason);
        policy.spend(&approval);
        let second = policy.check(
            "delete_file",
            Some("cap:fs.delete"),
            Some(Path::new("/srv/data/a.txt")),
            Some(&approval),
            AutonomyLevel::L3,
            true,
            100,
        );
        assert!(!second.allowed);
        assert_eq!(second.reason_code, "APPROVAL_ALREADY_USED");
    }

    #[test]
    fn an_approval_is_bound_to_its_command_and_path() {
        let approval = token("delete_file", "cap:fs.delete", Some("/srv/data/a.txt"));
        let other_path = policy().check(
            "delete_file",
            Some("cap:fs.delete"),
            Some(Path::new("/srv/data/b.txt")),
            Some(&approval),
            AutonomyLevel::L3,
            true,
            100,
        );
        assert_eq!(other_path.reason_code, "APPROVAL_SCOPE_MISMATCH");

        let other_command = policy().check(
            "shell_exec",
            Some("cap:shell.exec"),
            None,
            Some(&approval),
            AutonomyLevel::L3,
            true,
            100,
        );
        assert_eq!(other_command.reason_code, "APPROVAL_SCOPE_MISMATCH");
    }

    #[test]
    fn an_approval_without_a_platform_key_is_not_accepted() {
        let policy = policy();
        let approval = token("delete_file", "cap:fs.delete", Some("/srv/data/a.txt"));
        assert!(!policy.verifies(&approval));
    }
}
