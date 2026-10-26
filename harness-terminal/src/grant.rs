//! The grant: what this machine is allowed to do.
//!
//! The platform holds the grants, so the platform is the only place that can answer the
//! question. The device shell (the Java runtime, `harness/harness-terminal`) asks it over the
//! signed API and writes the answer to `~/.harness/terminal/grant.json`; this agent reads the
//! same file.
//!
//! There is therefore **one** authority and **two** enforcers: the platform decides, the shell
//! and the agent each refuse on their own. A compromised edge cannot widen the grant, because
//! the file is written by the shell from the platform's answer and the agent enforces the file
//! itself.
//!
//! The file carries capabilities and the autonomy level. It carries **no** approval tokens: an
//! approval is signed for one command and travels with that command, so it is never handed out
//! in advance.

use crate::policy::{AutonomyLevel, LocalPolicy};
use serde::{Deserialize, Serialize};
use std::path::{Path, PathBuf};

/// The file name inside the identity directory.
pub const FILE_NAME: &str = "grant.json";

/// The grant as the platform's answer and the device's own root whitelist.
///
/// The field names are camelCase because this file is written by the device shell (Java) and
/// read by this agent - one file, one format, two languages.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
#[serde(rename_all = "camelCase")]
pub struct Grant {
    #[serde(default)]
    pub terminal_id: String,
    #[serde(default)]
    pub agent_id: String,
    #[serde(default)]
    pub autonomy_level: u8,
    #[serde(default)]
    pub capabilities: Vec<String>,
    #[serde(default)]
    pub dept_ids: Vec<i64>,
    #[serde(default)]
    pub allowed_roots: Vec<String>,
    #[serde(default)]
    pub granted_at: String,
    #[serde(default)]
    pub source: String,
}

/// Where the grant lives on this machine.
pub fn grant_file(identity_directory: &Path) -> PathBuf {
    identity_directory.join(FILE_NAME)
}

/// Reads the grant, or `None` when there is none.
///
/// A missing grant is not an error: it means the agent runs with nothing, which is the safe
/// answer.
pub fn read(path: &Path) -> Option<Grant> {
    let text = std::fs::read_to_string(path).ok()?;
    serde_json::from_str::<Grant>(&text).ok()
}

/// The policy the agent runs under, built from the grant.
///
/// The capabilities and the level come from the platform; the roots come from the device. The
/// effective set is the intersection of the two, and the agent enforces both.
///
/// `narrowed_to` may narrow the roots further - the command line can only ever take authority
/// away, never add it.
pub fn policy_from(grant: &Grant, narrowed_to: &[PathBuf]) -> LocalPolicy {
    let granted: Vec<PathBuf> = grant.allowed_roots.iter().map(PathBuf::from).collect();
    let roots: Vec<PathBuf> = if narrowed_to.is_empty() {
        granted
    } else {
        granted
            .into_iter()
            .filter(|root| {
                narrowed_to
                    .iter()
                    .any(|narrow| narrow.starts_with(root) || root.starts_with(narrow))
            })
            .collect()
    };
    LocalPolicy::new(
        AutonomyLevel::from_u8(grant.autonomy_level),
        grant.capabilities.iter().cloned(),
        roots,
    )
}

/// The policy for a machine, read from the grant file.
///
/// Without a grant the agent gets a policy that allows nothing: an agent that has not been
/// granted authority may still read nothing and write nothing, and the operator sees why.
pub fn policy_for_machine(identity_directory: &Path) -> (LocalPolicy, Option<Grant>) {
    policy_for_machine_narrowed(identity_directory, &[])
}

/// The policy for a machine, with the roots optionally narrowed further.
pub fn policy_for_machine_narrowed(
    identity_directory: &Path,
    narrowed_to: &[PathBuf],
) -> (LocalPolicy, Option<Grant>) {
    match read(&grant_file(identity_directory)) {
        Some(grant) => {
            let policy = policy_from(&grant, narrowed_to);
            (policy, Some(grant))
        }
        None => (LocalPolicy::empty(), None),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn reads_a_grant_the_shell_wrote() {
        let dir = tempfile::tempdir().unwrap();
        let file = grant_file(dir.path());
        std::fs::write(
            &file,
            r#"{"terminalId":"t1","agentId":"a1","autonomyLevel":2,
                "capabilities":["cap:fs.read","cap:fs.write"],"deptIds":[91],
                "allowedRoots":["/srv/data"],"grantedAt":"2026-10-26T12:00:00Z"}"#,
        )
        .unwrap();

        let grant = read(&file).expect("the grant must be readable");
        assert_eq!(grant.terminal_id, "t1");
        assert_eq!(grant.autonomy_level, 2);
        assert_eq!(grant.capabilities.len(), 2);

        let policy = policy_from(&grant, &[]);
        assert_eq!(policy.autonomy_level(), AutonomyLevel::L2);
        assert!(policy.capabilities().contains("cap:fs.read"));
        assert!(policy.is_within_allowed_roots(Path::new("/srv/data/x.txt")));
        assert!(!policy.is_within_allowed_roots(Path::new("/etc/passwd")));
    }

    #[test]
    fn without_a_grant_the_agent_may_do_nothing() {
        let dir = tempfile::tempdir().unwrap();
        let (policy, grant) = policy_for_machine(dir.path());
        assert!(grant.is_none());
        assert!(policy.capabilities().is_empty());
        assert_eq!(policy.autonomy_level(), AutonomyLevel::L0);
    }

    #[test]
    fn a_broken_grant_is_not_authority() {
        let dir = tempfile::tempdir().unwrap();
        let file = grant_file(dir.path());
        std::fs::write(&file, "{not json").unwrap();
        assert!(read(&file).is_none(), "a grant that cannot be read grants nothing");
    }
}
