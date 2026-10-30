-- =====================================================================================
-- harness V13 :: a skill gets a note and a category
--
-- The market could say what a skill is (its SKILL.md) but not two things an operator needs
-- every single day:
--
--   * **备注** - "这个技能是干什么的、什么时候该用它". The description in the frontmatter is
--     written for the agent; the note is written for the person deciding whether to install
--     it. It is metadata about the *skill*, not about one version of it, so editing it does
--     not bump the version - a version bump means "the content changed", and it did not.
--
--   * **分类** - a market with hundreds of skills in one flat list is a list nobody reads.
--     The categories are the ones a company actually uses; the ones that are built in are
--     seeded here, and an operator can add and rename their own (02: a list of choices is
--     data, not code).
--
-- The category is stored by name on the skill, and the table holds the list of choices. The
-- alternative - an id and a join - buys nothing here: a category is a label, renaming one is
-- one UPDATE on the table and one on the skills, and filtering stays a plain WHERE.
-- =====================================================================================

SET NAMES utf8mb4;

ALTER TABLE `harness_skill`
  ADD COLUMN `note`     VARCHAR(512) DEFAULT NULL COMMENT '备注：干什么用的、什么时候用',
  ADD COLUMN `category` VARCHAR(64)  DEFAULT NULL COMMENT '分类',
  ADD KEY `idx_skill_category` (`category`);

CREATE TABLE `harness_skill_category` (
  `category_id` CHAR(36)     NOT NULL COMMENT 'UUIDv7',
  `name`        VARCHAR(64)  NOT NULL,
  `builtin`     TINYINT      NOT NULL DEFAULT 0 COMMENT '内置分类可以改名，不能删',
  `sort_order`  INT          NOT NULL DEFAULT 100,
  `created_by`  VARCHAR(64)  NOT NULL COMMENT 'human:<employeeId> / system:seed',
  `created_at`  DATETIME     NOT NULL,
  `updated_at`  DATETIME     NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uk_category_name` (`name`),
  KEY `idx_category_sort` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- The categories a company actually reaches for. An operator can rename them and add their
-- own; these are a starting point, not a cage.
INSERT INTO `harness_skill_category`
  (category_id, name, builtin, sort_order, created_by, created_at, updated_at)
VALUES
  ('0198f600-0000-7000-8000-000000000001', '通用',     1, 10,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000002', '开发',     1, 20,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000003', '前端',     1, 30,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000004', '后端',     1, 40,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000005', '数据库',   1, 50,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000006', '运维',     1, 60,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000007', '测试',     1, 70,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000008', '文档',     1, 80,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-000000000009', '流程规范', 1, 90,  'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-00000000000a', '数据分析', 1, 100, 'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-00000000000b', '设计',     1, 110, 'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-00000000000c', '沟通协作', 1, 120, 'system:seed', NOW(), NOW()),
  ('0198f600-0000-7000-8000-00000000000d', '安全',     1, 130, 'system:seed', NOW(), NOW());
