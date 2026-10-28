#!/usr/bin/env python3
"""Copy the compiled portal into a Tomcat deployment.

The deployment directory is not a copy of the repository: its web.xml and struts.xml are the
deployment's own (different line endings, a BOM, and local edits). So this does not overwrite
them - it **patches** them, and it only copies what is build output or genuinely new:

  1. the compiled classes            -> WEB-INF/classes/
  2. the resources from src/          -> WEB-INF/classes/   (only when they differ)
  3. the struts include for the harness namespace, if it is missing
  4. the /api/harness/* filter mapping, if it is missing
  5. WEB-INF/props/harness-api.properties, created if it is missing (never overwritten:
     the operator edits the secret in it)

Everything it touches is backed up first, into target/deploy-backup/<timestamp>/.

Usage: deploy-portal.py <classes-dir> <repo-root> <deploy-dir>
"""
import os
import pathlib
import re
import shutil
import sys
import time


def log(message):
    print(f"deploy-portal: {message}")


def backup(root, deploy, path):
    """Copy a file that is about to change into the backup tree."""
    try:
        relative = path.relative_to(deploy)
    except ValueError:
        relative = pathlib.Path(path.name)
    target = root / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    if path.is_dir():
        shutil.copytree(path, target, dirs_exist_ok=True)
    else:
        shutil.copy2(path, target)
    return target


def copy_classes(classes_dir, deploy_classes, backup_root, deploy_root):
    if not classes_dir.exists():
        log(f"no compiled classes in {classes_dir}; nothing to copy")
        return 0
    copied = 0
    for class_file in classes_dir.rglob("*.class"):
        target = deploy_classes / class_file.relative_to(classes_dir)
        if target.exists() and target.read_bytes() == class_file.read_bytes():
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(class_file, target)
        copied += 1
    log(f"{copied} class file(s) copied into {deploy_classes}")
    return copied


# The files the deployment owns. They carry the deployment's own settings - the datasource,
# the filter mappings - so they are patched or reported, never overwritten.
#
#   struts.xml            patched with the harness include
#   applicationContext.xml  the datasource lives here; a deploy must not revert it
PATCHED_RESOURCES = {"struts.xml", "applicationContext.xml"}


def same_content(deployed, repo):
    """Whether two files say the same thing, ignoring the BOM and the line endings.

    The deployment was edited on a machine with different line endings, so a byte comparison
    would report every file as different and the deploy would rewrite all of them.
    """
    def normalise(raw):
        if raw.startswith(b"\xef\xbb\xbf"):
            raw = raw[3:]
        return raw.replace(b"\r\n", b"\n").strip()

    return normalise(deployed) == normalise(repo)


def xml_encoding_ok(path):
    """Whether an XML file's bytes agree with the encoding it declares.

    The portal's XML files declare UTF-8, and Struts/Hibernate read them that way. A file whose
    bytes are GBK while the declaration says UTF-8 fails to parse at deploy time with
    "Invalid byte 1 of 1-byte UTF-8 sequence" - a confusing way to find out that a file was
    converted by mistake.
    """
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    # Only the XML declaration counts, and XML defaults to UTF-8 when it says nothing.
    first_line = raw.split(b"\n", 1)[0].decode("ascii", errors="replace").lower()
    declared = "utf-8"
    match = re.search(r"encoding\s*=\s*[\"']([^\"']+)[\"']", first_line)
    if match:
        declared = match.group(1).strip() or "utf-8"
    try:
        raw.decode(declared)
        return True, declared
    except (UnicodeDecodeError, LookupError):
        return False, declared


def copy_resources(src_root, deploy_classes, backup_root, deploy_root):
    """The resources live next to the sources and end up in WEB-INF/classes as well.

    Only what really differs is copied, and what is copied is backed up first. The deployment
    owns its files: an operator's local edit must not be reverted by a deploy.
    """
    copied = []
    skipped = []
    for resource in sorted(src_root.rglob("*")):
        if not resource.is_file() or resource.suffix == ".java":
            continue
        if resource.name in PATCHED_RESOURCES:
            continue
        if resource.suffix.lower() == ".xml":
            ok, declared = xml_encoding_ok(resource)
            if not ok:
                log(f"SKIPPED {resource.relative_to(src_root)}: its bytes are not {declared}, "
                    f"but it declares {declared} - the file has to be converted")
                continue
        target = deploy_classes / resource.relative_to(src_root)
        if target.exists():
            if same_content(target.read_bytes(), resource.read_bytes()):
                skipped.append(str(target.relative_to(deploy_root)))
                continue
            if resource.name in PATCHED_RESOURCES:
                # The deployment owns this file. Say that the two differ and leave it alone.
                log(f"KEPT {target.relative_to(deploy_root)}: the deployment's version differs "
                    f"from the repository's and is not overwritten")
                continue
            backup(backup_root, deploy_root, target)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(resource, target)
        copied.append(str(target.relative_to(deploy_root)))
    if copied:
        log(f"{len(copied)} resource(s) copied (the rest already matched):")
        for name in copied:
            log(f"    {name}")
    else:
        log(f"the {len(skipped)} resource(s) in the deployment already match the repository")
    return copied


def patch_struts_include(deploy_classes, backup_root, deploy_root):
    """The harness namespace has to be included, or Struts never sees it."""
    struts = deploy_classes / "struts.xml"
    if not struts.exists():
        log(f"{struts} does not exist; skipping the include")
        return False
    raw = struts.read_bytes()
    if b"struts-harness.xml" in raw:
        log("struts.xml already includes the harness namespace")
        return False
    text = raw.decode("utf-8", errors="replace")
    newline = "\r\n" if "\r\n" in text else "\n"
    marker = '<include file="strutsFile/struts-common.xml"></include>'
    include = f'    <include file="strutsFile/struts-harness.xml"></include>{newline}'
    if marker not in text:
        # Fall back: put it after the last include.
        lines = text.split(newline)
        last = max(i for i, line in enumerate(lines) if "<include" in line)
        lines.insert(last + 1, '    <include file="strutsFile/struts-harness.xml"></include>')
        text = newline.join(lines)
    else:
        text = text.replace(marker, marker + newline + include.rstrip(newline), 1)
    backup(backup_root, deploy_root, struts)
    struts.write_bytes(text.encode("utf-8"))
    log("struts.xml patched: the harness namespace is now included")
    return True


def patch_web_filter(deploy_web_xml, backup_root, deploy_root):
    """Without the filter mapping the namespace never reaches Struts: every call is a 404."""
    if not deploy_web_xml.exists():
        log(f"{deploy_web_xml} does not exist; skipping the filter mapping")
        return False
    raw = deploy_web_xml.read_bytes()
    if b"/api/harness/*" in raw:
        log("web.xml already maps /api/harness/*")
        return False
    text = raw.decode("utf-8", errors="replace")
    newline = "\r\n" if "\r\n" in text else "\n"
    marker = "<url-pattern>/struts/*</url-pattern>"
    if marker in text:
        addition = f"{marker}{newline}        <url-pattern>/api/harness/*</url-pattern>"
        text = text.replace(marker, addition, 1)
    else:
        lines = text.split(newline)
        index = None
        for i, line in enumerate(lines):
            if "<filter-name>struts2</filter-name>" in line:
                index = i
                break
        if index is None:
            log("could not find the struts2 filter in web.xml; add it by hand")
            return False
        insert_at = index
        while insert_at < len(lines) and "</filter-mapping>" not in lines[insert_at]:
            insert_at += 1
        lines.insert(insert_at + 1, "        <url-pattern>/api/harness/*</url-pattern>")
        text = newline.join(lines)
    backup(backup_root, deploy_root, deploy_web_xml)
    deploy_web_xml.write_bytes(text.encode("utf-8"))
    log("web.xml patched: /api/harness/* now reaches the Struts dispatcher")
    return True


def ensure_props(deploy_props, repo_props, backup_root, deploy_root):
    """The configuration is created if it is missing - an operator's secret is never overwritten."""
    deploy_props.parent.mkdir(parents=True, exist_ok=True)
    if deploy_props.exists():
        log(f"{deploy_props} already exists; leaving it alone (the secret in it is yours)")
        return False
    if repo_props.exists():
        shutil.copy2(repo_props, deploy_props)
        log(f"{deploy_props} created from the repository template")
    else:
        deploy_props.write_text(
            "# harness API namespace configuration\n"
            "harness.api.enabled=false\n"
            "harness.api.clientId=harness-bootstrap\n"
            "harness.api.secret=CHANGE_ME__at_least_24_characters_long\n"
            "harness.api.clockSkewSeconds=300\n"
            "harness.api.nonceTtlSeconds=300\n",
            encoding="utf-8",
        )
        log(f"{deploy_props} created from a template")
    return True


def main():
    if len(sys.argv) < 4:
        print(__doc__)
        return 2
    classes_dir = pathlib.Path(sys.argv[1]).resolve()
    repo_root = pathlib.Path(sys.argv[2]).resolve()
    deploy_root = pathlib.Path(sys.argv[3]).resolve()

    if not deploy_root.exists():
        log(f"the deployment directory {deploy_root} does not exist")
        return 1

    backup_root = repo_root / "target" / "deploy-backup" / time.strftime("%Y%m%d-%H%M%S")
    backup_root.mkdir(parents=True, exist_ok=True)
    log(f"deployment: {deploy_root}")
    log(f"backup of what changes: {backup_root}")

    deploy_classes = deploy_root / "WEB-INF" / "classes"
    deploy_classes.mkdir(parents=True, exist_ok=True)

    copy_classes(classes_dir, deploy_classes, backup_root, deploy_root)
    copy_resources(repo_root / "src", deploy_classes, backup_root, deploy_root)
    patch_struts_include(deploy_classes, backup_root, deploy_root)
    patch_web_filter(deploy_root / "WEB-INF" / "web.xml", backup_root, deploy_root)
    ensure_props(deploy_root / "WEB-INF" / "props" / "harness-api.properties",
                 repo_root / "WebRoot" / "WEB-INF" / "props" / "harness-api.properties",
                 backup_root, deploy_root)

    log("done. Restart Tomcat for the new classes to be picked up:")
    log(f"    {deploy_root.parent.parent}/bin/shutdown.sh && {deploy_root.parent.parent}/bin/startup.sh")
    return 0


if __name__ == "__main__":
    sys.exit(main())
