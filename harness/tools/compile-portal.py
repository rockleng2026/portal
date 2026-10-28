#!/usr/bin/env python3
"""Compile the portal with a JDK 6 javac.

The sources are a mess: 647 files in GBK, 267 in UTF-8, one with a UTF-8 BOM, and
dependencies that cross the encoding boundary (a UTF-8 class that extends a GBK one). javac takes
one encoding for the whole invocation and compiles what it pulls in from the source path with
that same encoding - so a single invocation cannot get them all right.

So the build works in three moves:

  1. compile in chunks, each chunk with the encoding its own files have;
  2. a chunk that fails loses only its own files - compile them one by one;
  3. a file that still fails is reported, with the reason.

Everything that is compiled is written to the output directory; the deploy copies it from there.

Usage: compile-portal.py <jdk6> <repo-root> <out-dir> <classpath>
"""
import os
import pathlib
import subprocess
import sys
import tempfile


def log(message):
    print(f"compile-portal: {message}", flush=True)


def detect_encoding(raw):
    try:
        raw.decode("utf-8")
        return "UTF-8"
    except UnicodeDecodeError:
        return "GBK"


def compile_files(jdk, files, encoding, classpath, sourcepath, out):
    """Compiles a list of files. Returns (ok, stderr)."""
    if not files:
        return True, ""
    cmd = [f"{jdk}/bin/javac", "-nowarn", "-encoding", encoding, "-source", "1.6", "-target", "1.6",
           "-cp", classpath, "-sourcepath", sourcepath, "-d", str(out)] + [str(f) for f in files]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.returncode == 0, result.stderr


def main():
    if len(sys.argv) < 5:
        print(__doc__)
        return 2
    jdk, repo_root, out_dir, classpath = sys.argv[1], pathlib.Path(sys.argv[2]), pathlib.Path(sys.argv[3]), sys.argv[4]
    sourcepath = str(repo_root / "src")
    out_dir.mkdir(parents=True, exist_ok=True)

    sources = sorted((repo_root / "src").rglob("*.java"))
    encoding_of = {}
    groups = {"GBK": [], "UTF-8": []}
    for source in sources:
        encoding = detect_encoding(source.read_bytes())
        encoding_of[source] = encoding
        groups[encoding].append(source)
    log(f"{len(sources)} java files ({len(groups['GBK'])} GBK, {len(groups['UTF-8'])} UTF-8)")

    # A UTF-8 BOM is an illegal character to javac, so that one file is compiled from a copy
    # without it.
    bom_sources = [s for s in sources if s.read_bytes().startswith(b"\xef\xbb\xbf")]
    for source in bom_sources:
        copy_dir = out_dir / "bom" / source.parent.relative_to(repo_root / "src")
        copy_dir.mkdir(parents=True, exist_ok=True)
        copy = copy_dir / source.name
        copy.write_bytes(source.read_bytes()[3:])
        sources.remove(source)
        groups["UTF-8"].remove(source)
        groups["UTF-8"].append(copy)
        encoding_of[copy] = "UTF-8"
    if bom_sources:
        log(f"{len(bom_sources)} file(s) carry a UTF-8 BOM; compiled from a copy without it")

    failed = []
    chunk_size = 40
    for encoding, files in groups.items():
        for start in range(0, len(files), chunk_size):
            chunk = files[start:start + chunk_size]
            ok, _ = compile_files(jdk, chunk, encoding, classpath, sourcepath, out_dir)
            if ok:
                continue
            # The chunk failed: compile its files one by one, each with its own encoding.
            for source in chunk:
                single_ok, stderr = compile_files(
                    jdk, [source], encoding_of.get(source, encoding),
                    f"{out_dir}:{classpath}", sourcepath, out_dir)
                if not single_ok:
                    failed.append((source, stderr))

    compiled = len(list(out_dir.rglob("*.class")))
    log(f"{compiled} classes in {out_dir}")
    if failed:
        log(f"{len(failed)} file(s) could not be compiled:")
        for source, stderr in failed:
            first = next((line for line in stderr.splitlines()
                          if ": error:" in line or "does not exist" in line or "cannot find symbol" in line),
                         stderr.splitlines()[0] if stderr.splitlines() else "")
            log(f"    {source.relative_to(repo_root)}: {first.strip()[:150]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
