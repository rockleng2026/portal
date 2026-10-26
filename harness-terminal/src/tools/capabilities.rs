//! The capability vocabulary the agent uses.
//!
//! These are the **platform's** capability keys - the same strings that live in
//! `harness_capability.cap_key` and that the platform hands out in the grant. The agent does
//! not invent capability names: a key that the platform does not know cannot be granted, so the
//! agent would simply never be allowed to act.
//!
//! The autonomy levels are the platform's too (`harness_capability.min_level`), so the agent
//! and the platform agree on what a capability costs.

/// Reading files, listing directories, searching code.
pub const CAP_FILE_READ: &str = "cap:file.read";

/// Writing and editing files.
pub const CAP_FILE_WRITE: &str = "cap:file.write";

/// Deleting a file. Destructive: L4, and it needs a human approval.
pub const CAP_FILE_DELETE: &str = "cap:file.delete";

/// Running a shell command. L3, and the platform routes the grant through a human.
pub const CAP_SSH_EXEC: &str = "cap:ssh.exec";

/// Reading the repository state.
pub const CAP_GIT_READ: &str = "cap:git.read";

/// Creating a commit.
pub const CAP_GIT_COMMIT: &str = "cap:git.commit";

/// Every capability the agent's tools can use.
pub const ALL: &[&str] = &[
    CAP_FILE_READ,
    CAP_FILE_WRITE,
    CAP_FILE_DELETE,
    CAP_SSH_EXEC,
    CAP_GIT_READ,
    CAP_GIT_COMMIT,
];
