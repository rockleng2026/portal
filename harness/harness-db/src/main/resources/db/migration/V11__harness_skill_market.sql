-- =====================================================================================
-- harness V11 :: the skill market
--
-- V1 froze `harness_skill` as the *program memory* contract: versioned, signed, rollbackable,
-- with a visibility scope. That table says everything about how a skill behaves and nothing
-- about how a skill gets into the company or how it gets onto a machine. This migration adds
-- the market.
--
-- Two ways in (01 §8.1.3.4 经验体 → 技能 → 发布流水线):
--
--   1. 外部拉取 - an operator finds a skill in an upstream registry (the pi-web idea: search a
--      registry, install a package) and pulls it in. The content is third-party, so it lands
--      as `candidate` and nobody can install it until a human has reviewed it.
--   2. 内部推送 - a digital employee distils a skill out of its own work and pushes it. Also
--      `candidate`, also reviewed by a human who is not its author (02 R-02).
--
-- Two ways out:
--
--   3. 上架 - a reviewed skill is published to the market with a visibility scope.
--   4. 拉取部署 - a department person or a digital employee browses the market and installs
--      a published skill onto an agent, a terminal or a department.
--
-- The rules this schema has to make impossible to break:
--
--   * a skill is content, never authority - installing one grants no capability (02 R-05);
--   * a skill that was never reviewed cannot be installed (`status` must be `released`);
--   * the author cannot review their own skill (`author_human` vs the reviewer);
--   * every version keeps its own digest and signature, so a rollback is a pointer move and
--     not a re-download (01 P6, 04 A2-2).
-- =====================================================================================

SET NAMES utf8mb4;

-- -------------------------------------------------------------------------------------
-- The market columns on the frozen skill table
-- -------------------------------------------------------------------------------------

ALTER TABLE `harness_skill`
  ADD COLUMN `source`          VARCHAR(16)  NOT NULL DEFAULT 'internal'
    COMMENT 'internal/external —— 技能从哪来',
  ADD COLUMN `source_ref`      VARCHAR(255) DEFAULT NULL
    COMMENT '外部注册源的包引用，如 owner/repo@skill',
  ADD COLUMN `source_url`      VARCHAR(512) DEFAULT NULL
    COMMENT '外部注册源的详情地址',
  ADD COLUMN `publisher`       VARCHAR(128) DEFAULT NULL
    COMMENT '发布者显示名（人名或系统名）',
  ADD COLUMN `dept_id`         INT(11)      DEFAULT NULL
    COMMENT '归属部门；数字员工推送时是自己的部门',
  ADD COLUMN `listing_status`  VARCHAR(16)  NOT NULL DEFAULT 'draft'
    COMMENT 'draft/published/unlisted —— 在不在市场上架',
  ADD COLUMN `visibility`      VARCHAR(16)  NOT NULL DEFAULT 'dept'
    COMMENT 'private/dept/org —— 谁看得见',
  ADD COLUMN `content`         MEDIUMTEXT   NULL
    COMMENT 'SKILL.md 全文（frontmatter + 正文），终端加载的就是它',
  ADD COLUMN `content_digest`  CHAR(64)     NOT NULL DEFAULT ''
    COMMENT 'sha256(content)：终端装机时核对的就是它',
  ADD COLUMN `scripts`         JSON         NULL
    COMMENT '[{name,path,digest}] 随技能附带的脚本',
  ADD COLUMN `install_count`   INT          NOT NULL DEFAULT 0
    COMMENT '被拉取部署的次数',
  ADD COLUMN `created_by`      VARCHAR(64)  NOT NULL DEFAULT 'system:seed'
    COMMENT 'human:<employeeId> / agent:<uuid7> / system:<code>',
  ADD COLUMN `updated_at`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD KEY `idx_skill_market` (`listing_status`,`visibility`,`dept_id`),
  ADD KEY `idx_skill_source` (`source`,`source_ref`),
  ADD KEY `idx_skill_author` (`author_agent`,`author_human`);

-- -------------------------------------------------------------------------------------
-- Where a skill was installed
-- -------------------------------------------------------------------------------------

CREATE TABLE `harness_skill_install` (
  `install_id`   CHAR(36)     NOT NULL COMMENT 'UUIDv7',
  `skill_id`     CHAR(36)     NOT NULL COMMENT 'harness_skill.skill_id',
  `skill_key`    VARCHAR(128) NOT NULL,
  `version`      INT          NOT NULL COMMENT '当前安装的版本',
  `target_type`  VARCHAR(16)  NOT NULL COMMENT 'agent/terminal/dept',
  `target_id`    VARCHAR(64)  NOT NULL COMMENT 'agent_id / terminal_id / dept_id',
  `dept_id`      INT(11)      DEFAULT NULL,
  `status`       VARCHAR(16)  NOT NULL DEFAULT 'installed'
    COMMENT 'installed/updated/removed/failed',
  `installed_by` VARCHAR(64)  NOT NULL COMMENT 'human:<employeeId> / agent:<uuid7>',
  `reason`       VARCHAR(512) DEFAULT NULL,
  `created_at`   DATETIME     NOT NULL,
  `updated_at`   DATETIME     NOT NULL,
  PRIMARY KEY (`install_id`),
  UNIQUE KEY `uk_install_target` (`target_type`,`target_id`,`skill_key`),
  KEY `idx_install_skill` (`skill_id`),
  KEY `idx_install_target` (`target_type`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------------------------------------
-- Upstream registries (the pi-web idea: a registry you search and install from)
-- -------------------------------------------------------------------------------------

CREATE TABLE `harness_skill_registry` (
  `registry_id`  CHAR(36)     NOT NULL COMMENT 'UUIDv7',
  `registry_key` VARCHAR(64)  NOT NULL,
  `name`         VARCHAR(128) NOT NULL,
  `kind`         VARCHAR(16)  NOT NULL DEFAULT 'external' COMMENT 'external —— 外部注册源',
  `search_url`   VARCHAR(512) DEFAULT NULL
    COMMENT '搜索模板，{query} 与 {limit} 是占位符',
  `package_url`  VARCHAR(512) DEFAULT NULL
    COMMENT '取包内容模板，{package} 是占位符',
  `enabled`      TINYINT      NOT NULL DEFAULT 1,
  `created_by`   VARCHAR(64)  NOT NULL COMMENT 'human:<employeeId> / system:seed',
  `created_at`   DATETIME     NOT NULL,
  `updated_at`   DATETIME     NOT NULL,
  PRIMARY KEY (`registry_id`),
  UNIQUE KEY `uk_registry_key` (`registry_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
