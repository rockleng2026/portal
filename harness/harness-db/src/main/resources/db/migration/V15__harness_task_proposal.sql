-- =====================================================================================
-- harness V15 :: a task the brain proposed
--
-- The brain observes and advises: every tool it has reads, and a change goes through the
-- console, where a natural human is the one who presses the button and the audit records
-- it (ADR-007, 02 R-02). That is the right shape for authority - but it leaves one thing
-- impossible: the operator asks the brain "give the R&D centre something to do", and the
-- brain cannot even write down what it was asked for.
--
-- So the brain may write a **proposal** - a request, not a task. A proposal changes nothing:
-- no portal row, no assignment, no machine. It sits in a queue until a natural human
-- publishes it, and publishing is what creates the task in the portal.
--
-- The proposal also carries the delivery and the verdict, so "the brain asked, the employee
-- did it, the brain checked" is one row that can be read back.
-- =====================================================================================

SET NAMES utf8mb4;

CREATE TABLE `harness_task_proposal` (
  `proposal_id`         CHAR(36)     NOT NULL COMMENT 'UUIDv7',
  `title`               VARCHAR(64)  NOT NULL COMMENT '任务标题（portal 的 functionname 上限 20 字）',
  `description`         TEXT         NOT NULL COMMENT '任务说明',
  `target_agent_key`    VARCHAR(128) DEFAULT NULL COMMENT '给哪个数字员工',
  `target_dept_id`      INT(11)      DEFAULT NULL COMMENT '给哪个部门（没指定数字员工时）',
  `proposed_by`         VARCHAR(64)  NOT NULL COMMENT 'brain:core / human:<employeeId>',
  `status`              VARCHAR(16)  NOT NULL DEFAULT 'proposed'
    COMMENT 'proposed/published/delivered/assessed/rejected',
  `portal_mission_id`   INT(11)      DEFAULT NULL,
  `portal_assignment_id` VARCHAR(64)  DEFAULT NULL,
  `harness_task_id`     CHAR(36)     DEFAULT NULL,
  `delivered_at`        DATETIME     DEFAULT NULL,
  `assessment`          TEXT         DEFAULT NULL COMMENT '大脑的验收结论',
  `decided_by`          VARCHAR(64)  DEFAULT NULL COMMENT '谁发布了 / 谁驳回了',
  `created_at`          DATETIME     NOT NULL,
  `updated_at`          DATETIME     NOT NULL,
  PRIMARY KEY (`proposal_id`),
  KEY `idx_proposal_status` (`status`,`created_at`),
  KEY `idx_proposal_agent` (`target_agent_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
