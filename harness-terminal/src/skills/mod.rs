//! Skills: instructions and scripts the agent can load, the way pi-agent does.
//!
//! A skill is a directory with a `SKILL.md` file:
//!
//! ```markdown
//! ---
//! name: release-check
//! description: what this skill is for, and when the agent should use it
//! ---
//!
//! # Release check
//!
//! 1. run the tests
//! 2. check the changelog
//! ```
//!
//! The frontmatter is parsed strictly - a skill whose frontmatter is broken is reported, not
//! ignored. The instructions go into the system prompt; the scripts directory, if present, is
//! made available to the agent as commands it may run.
//!
//! Skills are content, and content can be hostile. The design's answer (02 §R-05, ADR-011) is
//! that a skill's instructions are **not** a tool argument and never bypass the policy: the
//! skill can only tell the agent what to do, and every action still goes through the policy
//! check.

use anyhow::{anyhow, Context, Result};
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

/// A loaded skill.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Skill {
    /// The skill's name, from the frontmatter.
    pub name: String,
    /// When the agent should use it.
    pub description: String,
    /// The body of the SKILL.md, as instructions.
    pub instructions: String,
    /// The directory the skill lives in.
    pub directory: PathBuf,
    /// The scripts the skill ships, relative to the directory.
    pub scripts: Vec<String>,
    /// The digest of the skill's content, so a change is visible.
    pub digest: String,
}

impl Skill {
    /// The skill rendered for the system prompt.
    pub fn render(&self) -> String {
        format!(
            "## Skill: {}\n\n{}\n\n{}",
            self.name, self.description, self.instructions
        )
    }
}

/// The frontmatter of a SKILL.md.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SkillFrontmatter {
    pub name: String,
    #[serde(default)]
    pub description: String,
}

/// The skills the agent knows about.
#[derive(Debug, Clone, Default)]
pub struct SkillLibrary {
    skills: BTreeMap<String, Skill>,
}

impl SkillLibrary {
    pub fn new() -> Self {
        Self::default()
    }

    /// Loads every skill in a directory (one subdirectory per skill).
    pub fn load_from(root: &Path) -> Result<Self> {
        let mut library = SkillLibrary::new();
        if !root.exists() {
            return Ok(library);
        }
        for entry in std::fs::read_dir(root)
            .with_context(|| format!("cannot read {}", root.display()))?
        {
            let entry = entry?;
            let path = entry.path();
            if !path.is_dir() {
                continue;
            }
            let skill_file = path.join("SKILL.md");
            if !skill_file.exists() {
                continue;
            }
            let skill = Skill::load(&skill_file)?;
            library.skills.insert(skill.name.clone(), skill);
        }
        Ok(library)
    }

    /// Adds a skill.
    pub fn add(&mut self, skill: Skill) {
        self.skills.insert(skill.name.clone(), skill);
    }

    pub fn get(&self, name: &str) -> Option<&Skill> {
        self.skills.get(name)
    }

    pub fn names(&self) -> Vec<String> {
        self.skills.keys().cloned().collect()
    }

    pub fn len(&self) -> usize {
        self.skills.len()
    }

    pub fn is_empty(&self) -> bool {
        self.skills.is_empty()
    }

    /// The skills whose description matches a task, best first.
    ///
    /// The matching is deliberately simple: the task and the description are compared word by
    /// word. It does not need to be clever, it needs to be predictable.
    pub fn relevant(&self, task: &str, limit: usize) -> Vec<&Skill> {
        let task_words: Vec<String> = task
            .split_whitespace()
            .map(|w| {
                w.chars()
                    .filter(|c| c.is_alphanumeric() || *c == '_' || *c == '-')
                    .collect::<String>()
                    .to_lowercase()
            })
            .filter(|w| w.len() >= 3)
            .collect();
        let mut scored: Vec<(usize, &Skill)> = self
            .skills
            .values()
            .map(|skill| {
                let description = skill.description.to_lowercase();
                let name = skill.name.to_lowercase();
                let mut score = 0usize;
                for word in &task_words {
                    if description.contains(word) || name.contains(word) {
                        score += 1;
                    }
                }
                (score, skill)
            })
            .filter(|(score, _)| *score > 0)
            .collect();
        scored.sort_by(|a, b| b.0.cmp(&a.0).then(a.1.name.cmp(&b.1.name)));
        scored.into_iter().take(limit).map(|(_, s)| s).collect()
    }

    /// The skills rendered for the system prompt.
    pub fn render(&self, task: &str, limit: usize) -> String {
        let relevant = self.relevant(task, limit);
        if relevant.is_empty() {
            return String::new();
        }
        let mut out = String::from("# Skills\n\n");
        for skill in relevant {
            out.push_str(&skill.render());
            out.push('\n');
        }
        out
    }
}

impl Skill {
    /// Loads a skill from its SKILL.md.
    pub fn load(skill_file: &Path) -> Result<Self> {
        let content = std::fs::read_to_string(skill_file)
            .with_context(|| format!("cannot read {}", skill_file.display()))?;
        let (frontmatter, instructions) = split_frontmatter(&content)
            .ok_or_else(|| anyhow!("{} has no frontmatter", skill_file.display()))?;
        let name = frontmatter_value(&frontmatter, "name");
        if name.is_empty() {
            return Err(anyhow!("{} has no name in its frontmatter", skill_file.display()));
        }
        let description = frontmatter_value(&frontmatter, "description");
        let directory = skill_file
            .parent()
            .map(Path::to_path_buf)
            .unwrap_or_else(|| PathBuf::from("."));
        let scripts = collect_scripts(&directory);
        let digest = digest_of(&content, &scripts);
        Ok(Self {
            name,
            description,
            instructions: instructions.trim().to_string(),
            directory,
            scripts,
            digest,
        })
    }
}

/// Reads one value out of a frontmatter block.
pub fn frontmatter_value(frontmatter: &str, key: &str) -> String {
    for line in frontmatter.lines() {
        let line = line.trim();
        if let Some(rest) = line.strip_prefix(key) {
            let rest = rest.trim_start();
            if let Some(rest) = rest.strip_prefix(':') {
                return rest.trim().trim_matches('"').trim_matches('\'').to_string();
            }
        }
    }
    String::new()
}

/// Splits a SKILL.md into its frontmatter and its body.
pub fn split_frontmatter(content: &str) -> Option<(String, String)> {
    let trimmed = content.trim_start();
    if !trimmed.starts_with("---") {
        return None;
    }
    let rest = trimmed.trim_start_matches('-');
    let end = rest.find("\n---")?;
    let frontmatter = rest[..end].to_string();
    let body = rest[end + 4..].to_string();
    Some((frontmatter, body))
}

/// The scripts a skill ships.
fn collect_scripts(directory: &Path) -> Vec<String> {
    let scripts_dir = directory.join("scripts");
    let mut scripts = Vec::new();
    if let Ok(entries) = std::fs::read_dir(&scripts_dir) {
        for entry in entries.flatten() {
            let path = entry.path();
            if path.is_file() {
                if let Some(name) = path.file_name() {
                    scripts.push(format!("scripts/{}", name.to_string_lossy()));
                }
            }
        }
    }
    scripts.sort();
    scripts
}

/// The digest of a skill, so a changed skill is visible.
pub fn digest_of(content: &str, scripts: &[String]) -> String {
    let mut hasher = Sha256::new();
    hasher.update(content.as_bytes());
    for script in scripts {
        hasher.update(script.as_bytes());
    }
    hex::encode(hasher.finalize())
}

/// The digest of a skill's text alone.
///
/// This is the digest the platform publishes: sha256 over the SKILL.md it handed out, so the
/// terminal can check that what arrived is what the platform meant to send. It is a plain
/// digest, not a signature - the terminal has no copy of the platform's signing key, and
/// giving it one would let a compromised machine mint skills of its own.
pub fn content_digest(content: &str) -> String {
    hex::encode(Sha256::digest(content.as_bytes()))
}

/// The directory the skills live in by default.
pub fn default_skills_dir() -> PathBuf {
    let home = std::env::var("HOME").unwrap_or_else(|_| ".".to_string());
    PathBuf::from(home).join(".harness").join("skills")
}

/// A skill the platform handed out.
#[derive(Debug, Clone)]
pub struct SkillPackage {
    /// The skill's name - the frontmatter's name, which is what the agent sees.
    pub name: String,
    /// The version the platform published.
    pub version: i64,
    /// The SKILL.md, frontmatter and all.
    pub content: String,
    /// The digest the platform published for this content.
    pub digest: String,
    /// The scripts that travel with the skill: (name, content).
    pub scripts: Vec<(String, String)>,
}

impl SkillPackage {
    /// Reads a package out of the platform's answer.
    ///
    /// A package without a name or without content is refused: it would be written to disk as
    /// a directory nobody can use.
    pub fn from_json(value: &serde_json::Value) -> Result<Self> {
        let name = value
            .get("name")
            .and_then(|v| v.as_str())
            .filter(|n| !n.is_empty())
            .ok_or_else(|| anyhow!("the platform sent a skill without a name"))?
            .to_string();
        let content = value
            .get("content")
            .and_then(|v| v.as_str())
            .ok_or_else(|| anyhow!("the platform sent the skill '{name}' without its content"))?
            .to_string();
        let digest = value
            .get("digest")
            .and_then(|v| v.as_str())
            .unwrap_or_default()
            .to_string();
        let version = value.get("version").and_then(|v| v.as_i64()).unwrap_or(0);
        let mut scripts = Vec::new();
        if let Some(list) = value.get("scripts").and_then(|v| v.as_array()) {
            for script in list {
                let Some(script_name) = script.get("name").and_then(|v| v.as_str()) else {
                    continue;
                };
                let script_content = script
                    .get("content")
                    .and_then(|v| v.as_str())
                    .unwrap_or_default();
                scripts.push((script_name.to_string(), script_content.to_string()));
            }
        }
        Ok(Self {
            name,
            version,
            content,
            digest,
            scripts,
        })
    }
}

/// What an install run did.
#[derive(Debug, Default)]
pub struct InstallReport {
    /// The skills that were written.
    pub installed: Vec<String>,
    /// The skills that were taken off the disk because the platform withdrew them.
    pub removed: Vec<String>,
    /// The skills that were refused, with the reason.
    pub rejected: Vec<(String, String)>,
}

/// Installs the skills the platform handed out.
///
/// The rules:
/// - the digest is checked before anything is written, so a corrupted download never lands;
/// - a skill the platform no longer lists is removed from the disk, because a withdrawn skill
///   must not keep running on a machine (the platform withdraws the installations too, and the
///   two must agree);
/// - a skill that does not load is removed rather than kept: a directory whose SKILL.md cannot
///   be read is a skill that does nothing, and a skill that does nothing silently is worse
///   than a missing one.
pub fn install_all(root: &Path, packages: &[SkillPackage]) -> Result<InstallReport> {
    let mut report = InstallReport::default();
    std::fs::create_dir_all(root)
        .with_context(|| format!("cannot create the skills directory {}", root.display()))?;

    let mut wanted: Vec<String> = Vec::new();
    for package in packages {
        if !package.digest.is_empty() {
            let actual = content_digest(&package.content);
            if actual != package.digest {
                report.rejected.push((
                    package.name.clone(),
                    format!(
                        "the content does not match the digest the platform published (expected {}, got {})",
                        package.digest, actual
                    ),
                ));
                continue;
            }
        }
        let directory = root.join(&package.name);
        std::fs::create_dir_all(&directory)
            .with_context(|| format!("cannot create {}", directory.display()))?;
        let skill_file = directory.join("SKILL.md");
        std::fs::write(&skill_file, &package.content)
            .with_context(|| format!("cannot write {}", skill_file.display()))?;
        if !package.scripts.is_empty() {
            let scripts_dir = directory.join("scripts");
            std::fs::create_dir_all(&scripts_dir)
                .with_context(|| format!("cannot create {}", scripts_dir.display()))?;
            for (name, content) in &package.scripts {
                let path = scripts_dir.join(name);
                std::fs::write(&path, content)
                    .with_context(|| format!("cannot write {}", path.display()))?;
            }
        }
        // The skill has to load. A skill the agent cannot read would be in the directory and
        // not in the prompt - the exact "looks like it works" failure.
        if let Err(error) = Skill::load(&skill_file) {
            report.rejected.push((package.name.clone(), error.to_string()));
            let _ = std::fs::remove_dir_all(&directory);
            continue;
        }
        wanted.push(package.name.clone());
        report.installed.push(package.name.clone());
    }

    // Whatever the platform no longer lists goes away.
    if let Ok(entries) = std::fs::read_dir(root) {
        for entry in entries.flatten() {
            let path = entry.path();
            if !path.is_dir() {
                continue;
            }
            let Some(name) = path.file_name().and_then(|n| n.to_str()) else {
                continue;
            };
            if wanted.iter().any(|w| w == name) {
                continue;
            }
            // Only a directory that holds a SKILL.md is a skill of ours; anything else in the
            // directory belongs to somebody else and stays.
            if path.join("SKILL.md").exists() {
                let _ = std::fs::remove_dir_all(&path);
                report.removed.push(name.to_string());
            }
        }
    }

    Ok(report)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn write_skill(dir: &Path, name: &str, description: &str, body: &str) {
        let skill_dir = dir.join(name);
        std::fs::create_dir_all(&skill_dir).unwrap();
        std::fs::write(
            skill_dir.join("SKILL.md"),
            format!("---\nname: {name}\ndescription: {description}\n---\n\n{body}\n"),
        )
        .unwrap();
    }

    #[test]
    fn loads_a_skill_with_its_scripts() {
        let dir = tempfile::tempdir().unwrap();
        write_skill(dir.path(), "release", "how to do a release", "1. run the tests");
        std::fs::create_dir_all(dir.path().join("release/scripts")).unwrap();
        std::fs::write(dir.path().join("release/scripts/check.sh"), "#!/bin/sh\n").unwrap();

        let library = SkillLibrary::load_from(dir.path()).unwrap();
        assert_eq!(library.len(), 1);
        let skill = library.get("release").unwrap();
        assert_eq!(skill.description, "how to do a release");
        assert!(skill.instructions.contains("run the tests"));
        assert_eq!(skill.scripts, vec!["scripts/check.sh".to_string()]);
        assert_eq!(skill.digest.len(), 64);
    }

    #[test]
    fn a_skill_without_frontmatter_is_an_error() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::create_dir_all(dir.path().join("broken")).unwrap();
        std::fs::write(dir.path().join("broken/SKILL.md"), "no frontmatter here").unwrap();
        let result = SkillLibrary::load_from(dir.path());
        assert!(result.is_err(), "a broken skill must be reported, not ignored");
    }

    #[test]
    fn picks_the_skills_that_match_the_task() {
        let dir = tempfile::tempdir().unwrap();
        write_skill(dir.path(), "release", "how to cut a release", "steps");
        write_skill(dir.path(), "database", "how to migrate the database", "steps");

        let library = SkillLibrary::load_from(dir.path()).unwrap();
        let relevant = library.relevant("cut a release please", 5);
        assert_eq!(relevant.len(), 1);
        assert_eq!(relevant[0].name, "release");
        let rendered = library.render("cut a release please", 5);
        assert!(rendered.contains("release"));
        assert!(!rendered.contains("database"));
    }

    fn package(name: &str, body: &str) -> SkillPackage {
        let content = format!("---\nname: {name}\ndescription: what it is for\n---\n\n{body}\n");
        SkillPackage {
            name: name.to_string(),
            version: 1,
            digest: content_digest(&content),
            content,
            scripts: Vec::new(),
        }
    }

    #[test]
    fn installs_the_skill_the_platform_handed_out() {
        let dir = tempfile::tempdir().unwrap();
        let report = install_all(dir.path(), &[package("release", "1. run the tests")]).unwrap();
        assert_eq!(report.installed, vec!["release".to_string()]);
        assert!(report.rejected.is_empty());

        let library = SkillLibrary::load_from(dir.path()).unwrap();
        assert_eq!(library.len(), 1);
        assert!(library.get("release").unwrap().instructions.contains("run the tests"));
    }

    #[test]
    fn refuses_a_skill_whose_content_does_not_match_the_digest() {
        let dir = tempfile::tempdir().unwrap();
        let mut skill = package("release", "1. run the tests");
        skill.digest = "0".repeat(64);

        let report = install_all(dir.path(), &[skill]).unwrap();
        assert!(report.installed.is_empty());
        assert_eq!(report.rejected.len(), 1);
        assert!(report.rejected[0].1.contains("digest"));
        // Nothing landed on the disk.
        assert!(!dir.path().join("release").exists());
    }

    #[test]
    fn takes_back_a_skill_the_platform_withdrew() {
        let dir = tempfile::tempdir().unwrap();
        install_all(dir.path(), &[package("release", "steps")]).unwrap();
        assert!(dir.path().join("release").exists());

        // The platform no longer lists it: it left the shelf, so it leaves the disk.
        let report = install_all(dir.path(), &[]).unwrap();
        assert_eq!(report.removed, vec!["release".to_string()]);
        assert!(!dir.path().join("release").exists());
    }

    #[test]
    fn refuses_a_skill_the_agent_could_not_load() {
        let dir = tempfile::tempdir().unwrap();
        // No frontmatter: the terminal would not load it, so the platform must not install it.
        let content = "just text, no frontmatter";
        let skill = SkillPackage {
            name: "broken".to_string(),
            version: 1,
            digest: content_digest(content),
            content: content.to_string(),
            scripts: Vec::new(),
        };

        let report = install_all(dir.path(), &[skill]).unwrap();
        assert!(report.installed.is_empty());
        assert_eq!(report.rejected.len(), 1);
        assert!(!dir.path().join("broken").exists());
    }

    #[test]
    fn keeps_a_directory_that_is_not_a_skill() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::create_dir_all(dir.path().join("notes")).unwrap();
        std::fs::write(dir.path().join("notes/readme.txt"), "mine").unwrap();

        install_all(dir.path(), &[package("release", "steps")]).unwrap();
        assert!(dir.path().join("notes/readme.txt").exists());
    }
}
