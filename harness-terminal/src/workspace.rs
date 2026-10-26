//! The workspace: the project the agent works in.
//!
//! Two things matter here. First, **what is in it** - the agent has to understand the shape of
//! a codebase before it changes anything. Second, **what is allowed**: every path the agent
//! touches is resolved against the workspace root and checked against the allowed roots, so a
//! tool argument like `../../etc/passwd` cannot reach outside.

use anyhow::{anyhow, Context, Result};
use ignore::WalkBuilder;
use std::collections::BTreeMap;
use std::path::{Component, Path, PathBuf};

/// Directories that are never interesting and are always expensive.
const DEFAULT_IGNORED: &[&str] = &[
    ".git",
    "node_modules",
    "target",
    "build",
    "dist",
    "out",
    ".idea",
    ".vscode",
    ".gradle",
    "vendor",
    "__pycache__",
    ".venv",
    "venv",
    ".mypy_cache",
    ".pytest_cache",
    ".next",
    ".nuxt",
    ".turbo",
    "coverage",
];

/// The languages the agent can recognise, with the extensions that identify them.
///
/// The list is not decoration: the agent uses it to decide which files are worth reading and
/// which parser to lean on when it summarises a file.
const LANGUAGES: &[(&str, &[&str])] = &[
    ("rust", &["rs"]),
    ("go", &["go"]),
    ("java", &["java"]),
    ("kotlin", &["kt", "kts"]),
    ("scala", &["scala"]),
    ("python", &["py", "pyi"]),
    ("typescript", &["ts", "tsx", "mts", "cts"]),
    ("javascript", &["js", "jsx", "mjs", "cjs"]),
    ("vue", &["vue"]),
    ("svelte", &["svelte"]),
    ("c", &["c", "h"]),
    ("cpp", &["cpp", "cc", "cxx", "hpp", "hh", "hxx"]),
    ("csharp", &["cs"]),
    ("ruby", &["rb", "rake"]),
    ("php", &["php"]),
    ("swift", &["swift"]),
    ("objective-c", &["m", "mm"]),
    ("shell", &["sh", "bash", "zsh", "fish"]),
    ("powershell", &["ps1", "psm1"]),
    ("sql", &["sql"]),
    ("html", &["html", "htm"]),
    ("css", &["css", "scss", "less"]),
    ("markdown", &["md", "markdown"]),
    ("yaml", &["yaml", "yml"]),
    ("toml", &["toml"]),
    ("json", &["json"]),
    ("xml", &["xml"]),
    ("groovy", &["groovy"]),
    ("perl", &["pl", "pm"]),
    ("lua", &["lua"]),
    ("r", &["r"]),
    ("dart", &["dart"]),
    ("haskell", &["hs"]),
    ("elixir", &["ex", "exs"]),
    ("erlang", &["erl"]),
    ("clojure", &["clj", "cljs"]),
    ("zig", &["zig"]),
    ("nim", &["nim"]),
    ("crystal", &["cr"]),
    ("fortran", &["f90", "f95"]),
    ("julia", &["jl"]),
    ("solidity", &["sol"]),
    ("terraform", &["tf", "tfvars"]),
    ("graphql", &["graphql", "gql"]),
    ("protobuf", &["proto"]),
    ("assembly", &["asm", "s"]),
    ("makefile", &["mk"]),
    ("dockerfile", &["dockerfile"]),
];

/// One file in the workspace.
#[derive(Debug, Clone)]
pub struct FileEntry {
    /// Path relative to the workspace root, with forward slashes.
    pub path: String,
    pub size: u64,
    pub language: Option<&'static str>,
}

/// The workspace the agent works in.
#[derive(Debug, Clone)]
pub struct Workspace {
    root: PathBuf,
    ignored: Vec<String>,
    max_file_bytes: u64,
}

impl Workspace {
    /// Opens a workspace at `root`.
    pub fn new(root: impl AsRef<Path>) -> Result<Self> {
        let root = root.as_ref();
        let canonical = root
            .canonicalize()
            .with_context(|| format!("workspace {} does not exist", root.display()))?;
        if !canonical.is_dir() {
            return Err(anyhow!("{} is not a directory", canonical.display()));
        }
        Ok(Self {
            root: canonical,
            ignored: DEFAULT_IGNORED.iter().map(|s| s.to_string()).collect(),
            max_file_bytes: 2 * 1024 * 1024,
        })
    }

    pub fn root(&self) -> &Path {
        &self.root
    }

    /// Narrows the workspace to a subdirectory. Used by the tools that take a `path`
    /// argument, so the listing and the search stay inside the workspace.
    pub fn with_root(&self, root: impl Into<PathBuf>) -> Self {
        let mut clone = self.clone();
        clone.root = normalize(&root.into());
        clone
    }

    /// Adds an ignore rule on top of the defaults.
    pub fn ignore(&mut self, pattern: impl Into<String>) -> &mut Self {
        self.ignored.push(pattern.into());
        self
    }

    pub fn max_file_bytes(&mut self, bytes: u64) -> &mut Self {
        self.max_file_bytes = bytes;
        self
    }

    /// Resolves a path argument against the workspace root.
    ///
    /// Absolute paths and `..` segments are allowed here - the policy decides whether the
    /// result may be touched. What this function guarantees is that the result is a real,
    /// normalised path, so the policy's check cannot be fooled by a spelling.
    pub fn resolve(&self, path: &str) -> Result<PathBuf> {
        let candidate = Path::new(path);
        let joined = if candidate.is_absolute() {
            candidate.to_path_buf()
        } else {
            self.root.join(candidate)
        };
        Ok(normalize(&joined))
    }

    /// The path of `path` relative to the workspace root, with forward slashes.
    pub fn relative(&self, path: &Path) -> String {
        let rel = path.strip_prefix(&self.root).unwrap_or(path);
        rel.components()
            .map(|c| c.as_os_str().to_string_lossy().to_string())
            .collect::<Vec<_>>()
            .join("/")
    }

    /// Lists the files in the workspace, honouring the ignore rules.
    pub fn list_files(&self) -> Result<Vec<FileEntry>> {
        let mut builder = WalkBuilder::new(&self.root);
        builder
            .hidden(false)
            .git_ignore(true)
            .git_global(false)
            .parents(false)
            .follow_links(false);
        for pattern in &self.ignored {
            builder.add_ignore(pattern);
        }
        let ignored = self.ignored.clone();
        builder.filter_entry(move |entry| {
            // The noise directories are skipped by name. A gitignore pattern would do the
            // same, but a pattern is a spelling and a name is not.
            if !entry.file_type().map(|t| t.is_dir()).unwrap_or(false) {
                return true;
            }
            let name = entry.file_name().to_string_lossy().to_string();
            !ignored.iter().any(|ignored| ignored == &name)
        });
        let mut files = Vec::new();
        for entry in builder.build() {
            let entry = match entry {
                Ok(e) => e,
                Err(_) => continue,
            };
            if !entry.file_type().map(|t| t.is_file()).unwrap_or(false) {
                continue;
            }
            let path = entry.path();
            let size = entry.metadata().map(|m| m.len()).unwrap_or(0);
            if size > self.max_file_bytes {
                continue;
            }
            files.push(FileEntry {
                path: self.relative(path),
                size,
                language: language_of(path),
            });
        }
        files.sort_by(|a, b| a.path.cmp(&b.path));
        Ok(files)
    }

    /// A tree of the workspace, indented, for the model to read.
    pub fn tree(&self, max_entries: usize) -> Result<String> {
        let files = self.list_files()?;
        let mut out = String::new();
        let mut counts: BTreeMap<&str, usize> = BTreeMap::new();
        for file in &files {
            *counts.entry(file.language.unwrap_or("other")).or_default() += 1;
        }
        let summary: Vec<String> = counts
            .iter()
            .map(|(lang, count)| format!("{lang}: {count}"))
            .collect();
        out.push_str(&format!(
            "{} files, {}\n",
            files.len(),
            summary.join(", ")
        ));
        for file in files.iter().take(max_entries) {
            out.push_str(&file.path);
            out.push('\n');
        }
        if files.len() > max_entries {
            out.push_str(&format!(
                "... and {} more files\n",
                files.len() - max_entries
            ));
        }
        Ok(out)
    }

    /// Reads a file, refusing anything that is not a file.
    pub fn read_file(&self, path: &str) -> Result<String> {
        let resolved = self.resolve(path)?;
        let metadata = std::fs::metadata(&resolved)
            .with_context(|| format!("cannot stat {}", resolved.display()))?;
        if !metadata.is_file() {
            return Err(anyhow!("{} is not a file", resolved.display()));
        }
        if metadata.len() > self.max_file_bytes {
            return Err(anyhow!(
                "{} is {} bytes, over the {} byte limit",
                resolved.display(),
                metadata.len(),
                self.max_file_bytes
            ));
        }
        let bytes = std::fs::read(&resolved)
            .with_context(|| format!("cannot read {}", resolved.display()))?;
        Ok(String::from_utf8_lossy(&bytes).to_string())
    }

    /// Writes a file, creating the parent directories.
    pub fn write_file(&self, path: &str, content: &str) -> Result<()> {
        let resolved = self.resolve(path)?;
        if let Some(parent) = resolved.parent() {
            std::fs::create_dir_all(parent)
                .with_context(|| format!("cannot create {}", parent.display()))?;
        }
        std::fs::write(&resolved, content)
            .with_context(|| format!("cannot write {}", resolved.display()))?;
        Ok(())
    }

    /// The language of a path, by extension.
    pub fn language_of(path: &str) -> Option<&'static str> {
        language_of(Path::new(path))
    }
}

/// Normalises a path without touching the filesystem.
///
/// `Path::canonicalize` would resolve symlinks and require the path to exist; this only
/// removes `.` and `..` segments, which is what a policy check needs.
pub fn normalize(path: &Path) -> PathBuf {
    let mut out = PathBuf::new();
    for component in path.components() {
        match component {
            Component::CurDir => {}
            Component::ParentDir => {
                if !out.pop() {
                    out.push("..");
                }
            }
            other => out.push(other.as_os_str()),
        }
    }
    if out.as_os_str().is_empty() {
        out.push(".");
    }
    out
}

/// The language of a path, by extension.
pub fn language_of(path: &Path) -> Option<&'static str> {
    let name = path.file_name()?.to_string_lossy().to_lowercase();
    if name == "dockerfile" {
        return Some("dockerfile");
    }
    if name == "makefile" {
        return Some("makefile");
    }
    let ext = path.extension()?.to_string_lossy().to_lowercase();
    for (language, extensions) in LANGUAGES {
        if extensions.contains(&ext.as_str()) {
            return Some(language);
        }
    }
    None
}

/// The number of languages the agent can recognise.
pub fn supported_language_count() -> usize {
    LANGUAGES.len()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn recognises_languages_by_extension() {
        assert_eq!(language_of(Path::new("src/main.rs")), Some("rust"));
        assert_eq!(language_of(Path::new("a/b/c.py")), Some("python"));
        assert_eq!(language_of(Path::new("Dockerfile")), Some("dockerfile"));
        assert_eq!(language_of(Path::new("README")), None);
    }

    #[test]
    fn normalises_dot_segments() {
        assert_eq!(normalize(Path::new("/srv/data/../etc/passwd")), PathBuf::from("/srv/etc/passwd"));
        assert_eq!(normalize(Path::new("/srv/./data")), PathBuf::from("/srv/data"));
    }

    #[test]
    fn lists_the_workspace_and_hides_the_noise() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::create_dir_all(dir.path().join("src")).unwrap();
        std::fs::create_dir_all(dir.path().join("node_modules/pkg")).unwrap();
        std::fs::write(dir.path().join("src/main.rs"), "fn main() {}").unwrap();
        std::fs::write(dir.path().join("node_modules/pkg/index.js"), "x").unwrap();

        let workspace = Workspace::new(dir.path()).unwrap();
        let files = workspace.list_files().unwrap();
        let paths: Vec<&str> = files.iter().map(|f| f.path.as_str()).collect();
        assert_eq!(paths, vec!["src/main.rs"]);
    }

    #[test]
    fn reads_and_writes_inside_the_workspace() {
        let dir = tempfile::tempdir().unwrap();
        let workspace = Workspace::new(dir.path()).unwrap();
        workspace.write_file("a/b.txt", "hello").unwrap();
        assert_eq!(workspace.read_file("a/b.txt").unwrap(), "hello");
        assert!(workspace.read_file("a/missing.txt").is_err());
    }
}
