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
}
