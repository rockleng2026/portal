-- =====================================================================================
-- harness V14 :: a task that came from the portal
--
-- The console-to-terminal channel (V9) can carry a request a human typed into the harness
-- console. It has nowhere to say "this is really portal task 1, and the answer has to go back
-- there" - and the portal is where the work actually lives: the assignment is in new_task, the
-- employee's own todo is in mission_emp, and a human reads the result there.
--
-- So the task carries the link back. Without it the platform could pick the work up and the
-- portal would never learn that it was done - the digital employee would look busy and the
-- task list would stay exactly as it was.
--
-- The link is the assignment (new_task.id), not the mission: one mission can be assigned to
-- several employees, and each of them does their own part of it.
-- =====================================================================================

SET NAMES utf8mb4;

ALTER TABLE `harness_terminal_task`
  ADD COLUMN `portal_assignment_id` VARCHAR(64) DEFAULT NULL
    COMMENT 'portal new_task.id —— 这条任务在 portal 里是哪一条分派',
  ADD COLUMN `portal_mission_id`   INT(11)     DEFAULT NULL
    COMMENT 'portal mission.task_id —— 任务本身',
  ADD COLUMN `portal_sbh`         VARCHAR(64) DEFAULT NULL
    COMMENT 'portal mission.sbh —— 任务的不变标识',
  ADD COLUMN `portal_employee_id` INT(11)     DEFAULT NULL
    COMMENT 'portal employee.id —— 干活的数字员工',
  ADD COLUMN `portal_delivered`   VARCHAR(512) DEFAULT NULL
    COMMENT '交付说明：回了 portal 什么',
  ADD UNIQUE KEY `uk_portal_assignment` (`portal_assignment_id`, `terminal_id`);
