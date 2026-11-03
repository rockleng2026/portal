//! The harness: the system around the model that turns it into an agent.
//!
//! Google's "Harness²: Recursive Agent Harnessing for an Open World" (arXiv 2610.14224)
//! makes the harness a set of **editable components** rather than one prompt string:
//! system prompt, guardrails, memory, tool guidance, subagents, skills, scripts and plugins.
//! Two of its ideas are worth having here:
//!
//! - **a named component beats prose.** A paragraph in the always-on text is paid for on
//!   every run; a file that can be edited on its own is not. The always-on text is also
//!   expensive in the sharpest way: every word of it competes with the model's own output
//!   budget, and the most expensive failure is a run that reasons until the budget is gone
//!   and produces nothing.
//! - **the harness can be improved from the work.** The lessons a run leaves behind are
//!   written into the harness, so the next run starts from them. That is the "harnessing
//!   level" of Harness²'s recursion: the execution harness for the current task, and a
//!   persistent one that gets better as the tasks accumulate.
//!
//! Ours has four always-on components, all of them plain files on the machine, and the
//! skills that arrive from the skill market beside them:
//!
//! ```text
//! harness/systemprompt.md    who it is and how it works
//! harness/guardrails.md      standing rules
//! harness/tool_guidance.md   how to use the tools
//! harness/memory.md          what it learned from the tasks it has done
//! ```
//!
//! The files are the surface: an edit is a file, and the platform hands the terminal the
//! lessons it has adopted. Nothing here can widen the agent's authority - the policy and the
//! grant decide what it may do, and the harness only decides how it does it.

use anyhow::{Context, Result};
use std::path::{Path, PathBuf};

/// How much always-on text goes into the prompt.
///
/// The number is Harness²'s (24 000 characters for the OpenCode surface). It is a cap
/// because every character of it competes with the model's output budget.
pub const ALWAYS_ON_MAX_CHARS: usize = 24_000;

/// The components, in the order they are assembled.
pub const COMPONENTS: [&str; 4] = ["systemprompt", "guardrails", "tool_guidance", "memory"];

/// The harness on one machine.
pub struct Harness {
    root: PathBuf,
}

impl Harness {
    /// Loads the harness, writing the defaults if it is not there yet.
    ///
    /// <p>A machine that has never run one gets the defaults, so upgrading the terminal is
    /// enough to give it a harness - there is no installation step.
    pub fn load_or_seed(root: &Path) -> Result<Self> {
        let harness = Harness {
            root: root.to_path_buf(),
        };
        harness.seed_if_missing()?;
        Ok(harness)
    }

    /// The directory the harness lives in.
    pub fn root(&self) -> &Path {
        &self.root
    }

    fn component_path(&self, name: &str) -> PathBuf {
        self.root.join(format!("{name}.md"))
    }

    /// Writes the default content of a component that is not there yet.
    fn seed_if_missing(&self) -> Result<()> {
        std::fs::create_dir_all(&self.root)
            .with_context(|| format!("cannot create the harness directory {}", self.root.display()))?;
        for (name, content) in defaults() {
            let path = self.component_path(name);
            if !path.exists() {
                std::fs::write(&path, content)
                    .with_context(|| format!("cannot write {}", path.display()))?;
            }
        }
        Ok(())
    }

    /// One component's text.
    pub fn component(&self, name: &str) -> String {
        std::fs::read_to_string(self.component_path(name)).unwrap_or_default()
    }

    /// Replaces one component's text.
    pub fn set_component(&self, name: &str, content: &str) -> Result<()> {
        let path = self.component_path(name);
        if let Some(parent) = path.parent() {
            std::fs::create_dir_all(parent)?;
        }
        std::fs::write(&path, content)
            .with_context(|| format!("cannot write {}", path.display()))
    }

    /// The lessons the platform has adopted, written into the memory.
    ///
    /// <p>The platform is the authority: it sends the whole set every time, so a lesson that
    /// was rolled back simply stops being sent and the file is rewritten without it. Adding
    /// them one by one would leave a rolled-back lesson on the machine for ever.
    ///
    /// <p>Each lesson names the component it concerns, so the file reads as a list of what
    /// was learned and where it applies - Harness²'s rule that a lesson must name the
    /// component it concerns.
    pub fn set_lessons(&self, lessons: &[(String, String)]) -> Result<usize> {
        let mut out = String::new();
        let mut count = 0;
        for (component, text) in lessons {
            let trimmed = text.trim();
            if trimmed.is_empty() {
                continue;
            }
            if !out.is_empty() {
                out.push('\n');
            }
            out.push_str(&format!("- [{}] {}", component.trim(), trimmed));
            count += 1;
        }
        self.set_component("memory", &out)?;
        Ok(count)
    }

    /// The always-on text, assembled and capped.
    pub fn system_prompt(&self) -> String {
        let mut out = String::new();
        for (name, title) in [
            ("systemprompt", ""),
            ("guardrails", "# 规矩"),
            ("tool_guidance", "# 怎么用工具"),
            ("memory", "# 学到的"),
        ] {
            let content = self.component(name);
            if content.trim().is_empty() {
                continue;
            }
            if !out.is_empty() {
                out.push_str("\n\n");
            }
            if !title.is_empty() {
                out.push_str(title);
                out.push_str("\n\n");
            }
            out.push_str(content.trim());
        }
        if out.chars().count() > ALWAYS_ON_MAX_CHARS {
            // The tail goes first: the rules at the end are the ones that were added last
            // and the ones a lesson added - and a lesson that does not fit is a lesson that
            // has to be said more briefly.
            let all: Vec<char> = out.chars().collect();
            let start = all.len().saturating_sub(ALWAYS_ON_MAX_CHARS);
            let mut trimmed: String = all[start..].iter().collect();
            if let Some(cut) = trimmed.find('\n') {
                trimmed = trimmed[cut + 1..].to_string();
            }
            return trimmed;
        }
        out
    }
}

/// The default harness.
///
/// <p>The wording is the one that was learned the hard way: the first version of this agent
/// burned its whole budget designing an HTML demo in prose and never wrote a file, and a
/// later one kept polishing a file it had already finished. Both are in here now, because
/// a harness is supposed to carry what has been learned.
fn defaults() -> Vec<(&'static str, &'static str)> {
    vec![
        (
            "systemprompt",
            "你是一个在代码工作区里干活的数字员工。\n\
             \n\
             干活的步骤：先看（list_files / read_file / search_code），再改（write_file / edit_file），\n\
             再验（read_file 看回来 / run_tests / shell_exec）。改完说清楚改了什么、怎么验的。\n\
             \n\
             要产出新东西时，先动手：写一个能跑的最小版本，再一步步改好。\n\
             方案写在脑子里不算进度，写在工作区里的文件才算。",
        ),
        (
            "guardrails",
            "- 工具报错要看报错、修原因，不要原样重试。\n\
             - 做完就停：交一句话说明，然后交回。不要一直打磨。\n\
             - 产出物要写进工作区的文件；不要把文件内容打在回答里。\n\
             - 回答里不要出现任务的事实，要写做了什么。",
        ),
        (
            "tool_guidance",
            "- 要产出新文件时，先 write_file 落一个最小版本，再 edit_file 改。不要在回答里写文件内容。\n\
             - read_file 读的是整个文件；文件很大时只读你需要的那一段，不要反复读整份。\n\
             - 改完用 read_file 看回来，确认写进去的是你要的。\n\
             - 一次改动只改一件事，改完看一眼再改下一件。",
        ),
        ("memory", ""),
    ]
}

#[cfg(test)]
mod tests {
    use super::*;

    fn seeded(root: &Path) -> Harness {
        Harness::load_or_seed(root).expect("the harness must be seeded")
    }

    #[test]
    fn a_machine_that_never_had_a_harness_gets_one() {
        let dir = tempfile::tempdir().unwrap();
        let harness = seeded(dir.path());
        let prompt = harness.system_prompt();
        assert!(prompt.contains("代码工作区"), "the prompt says what it is: {}", prompt);
        assert!(prompt.contains("规矩"), "the guardrails are in the prompt");
        assert!(prompt.contains("怎么用工具"), "the tool guidance is in the prompt");
        // The files are there, so they can be edited.
        assert!(dir.path().join("systemprompt.md").exists());
        assert!(dir.path().join("guardrails.md").exists());
        assert!(dir.path().join("tool_guidance.md").exists());
        assert!(dir.path().join("memory.md").exists());
    }

    #[test]
    fn the_lessons_are_the_platforms_to_give() {
        let dir = tempfile::tempdir().unwrap();
        let harness = seeded(dir.path());
        harness
            .set_lessons(&[
                ("tool_guidance".to_string(), "写完文件就用一句话交差。".to_string()),
                ("memory".to_string(), "这个仓库的测试要先跑 npm test。".to_string()),
            ])
            .unwrap();
        let memory = harness.component("memory");
        assert!(memory.contains("[tool_guidance] 写完文件就用一句话交差。"), "{}", memory);
        assert!(memory.contains("[memory] 这个仓库的测试要先跑 npm test。"), "{}", memory);
        assert!(harness.system_prompt().contains("写完文件就用一句话交差。"));

        // The platform is the authority: it sends the whole set every time, so a lesson that
        // was rolled back simply stops being sent.
        harness.set_lessons(&[]).unwrap();
        assert!(!harness.component("memory").contains("交差"), "a withdrawn lesson is gone");
    }

    #[test]
    fn the_always_on_text_is_capped() {
        let dir = tempfile::tempdir().unwrap();
        let harness = seeded(dir.path());
        harness
            .set_component("systemprompt", &"x".repeat(ALWAYS_ON_MAX_CHARS * 2))
            .unwrap();
        let prompt = harness.system_prompt();
        assert!(
            prompt.chars().count() <= ALWAYS_ON_MAX_CHARS + 200,
            "the always-on text has to fit: {}",
            prompt.chars().count()
        );
    }

    #[test]
    fn the_lesson_the_tasks_taught_is_in_the_default_harness() {
        // The first version of this agent burned its whole budget designing an HTML demo in
        // prose and never wrote a file. The harness carries what was learned.
        let dir = tempfile::tempdir().unwrap();
        let harness = seeded(dir.path());
        let guidance = harness.component("tool_guidance");
        assert!(
            guidance.contains("最小版本"),
            "the harness says to write a first version before polishing: {}",
            guidance
        );
        let prompt = harness.system_prompt();
        assert!(prompt.contains("最小版本"), "and it is in the prompt the model sees");
    }
}
