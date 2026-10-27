-- =====================================================================================
-- harness V9 :: the channel between the console and the terminal
--
-- The console is a human at a keyboard; the agent is a process on a machine. Something has to
-- carry the request from one to the other, and it has to be revocable, auditable and
-- answerable - the same properties every other action in this system has.
--
-- This table is that channel. A row is one request:
--   pending -> running -> done | failed
--
-- The terminal polls for work, runs it under its own policy (the same capability set and
-- approval tokens the platform granted it), and posts the answer back. Nothing here grants
-- anything: a task is a request, not an authority.
--
-- The transport is HTTP for now, reusing the existing HMAC service-account authentication
-- (03 §9). The TCP frame channel (03 §3) is the eventual transport; the row layout does not
-- change when it arrives.
-- =====================================================================================

SET NAMES utf8mb4;

CREATE TABLE `harness_terminal_task` (
  `task_id`     CHAR(36) NOT NULL,
  `terminal_id` CHAR(36) NOT NULL COMMENT '请求发给哪台终端',
  `prompt`      TEXT NOT NULL COMMENT '人写的那个请求',
  `status`      VARCHAR(16) NOT NULL DEFAULT 'pending'
    COMMENT 'pending/running/done/failed/cancelled',
  `answer`      TEXT DEFAULT NULL COMMENT '智能体的回答',
  `transcript`  JSON DEFAULT NULL COMMENT '工具调用轨迹，可回放',
  `touched`     JSON DEFAULT NULL COMMENT '被改动的文件',
  `error`       VARCHAR(512) DEFAULT NULL,
  `created_by`  VARCHAR(64) NOT NULL COMMENT 'human:<employeeId> - 任务永远由人发起',
  `created_at`  DATETIME NOT NULL,
  `started_at`  DATETIME DEFAULT NULL,
  `finished_at` DATETIME DEFAULT NULL,
  `claimed_at`  DATETIME DEFAULT NULL COMMENT '终端认领的时间，防止两个终端抢同一条',
  PRIMARY KEY (`task_id`),
  KEY `idx_terminal_status` (`terminal_id`,`status`,`created_at`),
  KEY `idx_status` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
