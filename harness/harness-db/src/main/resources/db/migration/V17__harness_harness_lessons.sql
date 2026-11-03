-- =====================================================================================
-- harness V14 :: the harness gets better as the tasks accumulate
--
-- Harness² (Google, arXiv 2610.14224) calls the persistent harness the *improvement
-- harness*: after each task it is updated with the harnesses that were adopted and with
-- evidence-supported lessons, and the next task starts from them.
--
-- Ours is the same shape, with one rule that the paper is strict about: a lesson is only
-- stored when it rests on **evidence** - the cue, the lesson and the evidence all have to be
-- there. A lesson that rests on nothing is a guess, and a guess in the library poisons every
-- later task.
--
-- The lesson says which component of the harness it concerns (harness2's rule: "the lesson
-- must name the component it concerns"), and it is stored as a proposal: a human adopts it,
-- because the harness decides how the agent works and the policy decides what it may do, and
-- the difference between the two is exactly what a human has to keep an eye on.
--
-- An adopted lesson is a **candidate** until the next task shows whether it helped. That is
-- the probe: one task of evidence, and the lesson is confirmed or rolled back.
-- =====================================================================================

SET NAMES utf8mb4;

CREATE TABLE `harness_harness_lesson` (
  `lesson_id`   CHAR(36)     NOT NULL COMMENT 'UUIDv7',
  `agent_id`    CHAR(36)     DEFAULT NULL COMMENT '这条lesson属于哪个数字员工',
  `terminal_id` CHAR(36)     DEFAULT NULL,
  `cue`         VARCHAR(512) NOT NULL COMMENT '什么样的情形下适用（形状，不是这件事的细节）',
  `lesson`      VARCHAR(1024) NOT NULL COMMENT '对 harness 做什么操作',
  `component`   VARCHAR(32)  NOT NULL DEFAULT 'tool_guidance'
    COMMENT 'systemprompt/guardrails/tool_guidance/memory',
  `evidence`    TEXT         NOT NULL COMMENT '凭什么这么改：执行上的对比',
  `confidence`  VARCHAR(16)  NOT NULL DEFAULT 'medium',
  `status`      VARCHAR(16)  NOT NULL DEFAULT 'proposed'
    COMMENT 'proposed/candidate/confirmed/rolled_back/rejected',
  `task_id`     CHAR(36)     DEFAULT NULL COMMENT '从哪一次执行里学到的',
  `proposed_by` VARCHAR(64)  NOT NULL COMMENT '谁提的',
  `decided_by`  VARCHAR(64)  DEFAULT NULL,
  `created_at`  DATETIME     NOT NULL,
  `updated_at`  DATETIME     NOT NULL,
  PRIMARY KEY (`lesson_id`),
  KEY `idx_lesson_status` (`status`,`created_at`),
  KEY `idx_lesson_agent` (`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- The record of what a run actually did. The reflection reads it, and so does anybody who
-- asks why the agent behaves the way it does.
CREATE TABLE `harness_task_run` (
  `run_id`      CHAR(36)     NOT NULL,
  `task_id`     CHAR(36)     NOT NULL,
  `agent_id`    CHAR(36)     DEFAULT NULL,
  `terminal_id` CHAR(36)     DEFAULT NULL,
  `steps`       INT          NOT NULL DEFAULT 0,
  `tool_calls`  INT          NOT NULL DEFAULT 0,
  `files`       INT          NOT NULL DEFAULT 0,
  `first_turn_acted` TINYINT NOT NULL DEFAULT 0 COMMENT '第一轮就动手了吗',
  `delivery_note`   TINYINT NOT NULL DEFAULT 0 COMMENT '交了自己的交付说明吗',
  `ended_on`    VARCHAR(32)  NOT NULL DEFAULT 'finished'
    COMMENT 'finished/out_of_steps/out_of_context/failed',
  `observed_at` DATETIME     NOT NULL,
  PRIMARY KEY (`run_id`),
  KEY `idx_run_task` (`task_id`),
  KEY `idx_run_agent` (`agent_id`,`observed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
