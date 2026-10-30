-- =====================================================================================
-- harness V12 :: the external registries speak three real protocols
--
-- V11 added `harness_skill_registry` with two URL templates - one to search, one to fetch a
-- package. That is enough for one kind of registry and wrong for the two that actually
-- exist in the wild:
--
--   1. A **search** registry answers a query and hands back a package reference
--      (skills.sh: GET /api/search?q=... -> {"skills":[...]}, GET /api/download/{owner}/{repo}/{slug}
--      -> {"files":[{"path","contents"}]}).
--
--   2. A **catalog** registry publishes the whole catalogue at a well-known address and the
--      reader filters it locally. This is RFC 8615 applied to skills, and it is what the
--      ecosystem standardises on:
--
--        https://<host>/.well-known/agent-skills/index.json   (preferred)
--        https://<host>/.well-known/skills/index.json         (legacy fallback)
--
--      Two shapes are in the wild: v0.2.0 ({name, description, type, url, digest}) and the
--      older one ({name, description, files[]}). In the older one the files are fetched from
--      https://<host>/.well-known/agent-skills/<skill>/<path>.
--
--   3. An **audit** registry answers "has anybody checked this skill?". skills.sh publishes
--      the verdicts of several scanners (Socket, Snyk, Gen Agent Trust Hub) without a token.
--      That is the one thing that makes a third-party skill safe to pull in, so the platform
--      stores it next to the skill instead of throwing it away.
--
-- So the registry gains a catalogue address and an audit address. The search address and the
-- package address stay as they are - they are still what a search registry needs.
-- =====================================================================================

SET NAMES utf8mb4;

ALTER TABLE `harness_skill_registry`
  ADD COLUMN `catalog_url` VARCHAR(512) DEFAULT NULL
    COMMENT '目录型注册源的清单地址（RFC 8615 的 index.json）；kind=catalog 时用它',
  ADD COLUMN `audit_url`   VARCHAR(512) DEFAULT NULL
    COMMENT '安全审计地址模板，{package} 是占位符；拉取时把结论存进技能的 eval_result';
