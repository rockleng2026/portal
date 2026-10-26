-- =====================================================================================
-- portal 20160513 :: the only schema changes harness is allowed to make
-- Source: document/harness/03-协议与数据模型.md §1.1
--
-- >>> DO NOT RUN AUTOMATICALLY. Apply by hand, on a staging copy first, with a DBA present.
-- >>> These are the only three exceptions to the "harness never touches the portal schema"
-- >>> rule. Everything else is read-only access through /api/harness/** (01 §17).
--
-- Pre-checks (run before applying):
--   SELECT COUNT(*) FROM information_schema.columns
--     WHERE table_schema = DATABASE()
--       AND ((table_name='users'    AND column_name='isAI')
--         OR (table_name='employee' AND column_name='agentRef')
--         OR (table_name='message'  AND column_name='isAgentMsg'));
--   -- expect 0. Any non-zero means a previous attempt already ran; re-check before deciding.
--
-- Rollback:
--   ALTER TABLE `users`    DROP COLUMN `isAI`;
--   ALTER TABLE `employee` DROP COLUMN `agentRef`;
--   ALTER TABLE `message`  DROP COLUMN `isAgentMsg`;
--   (dropping columns is safe only while no harness component reads them; stop the platform first)
--
-- Notes
--   * `isAI` closes acceptance item A0-2: with it set, LoginAction rejects the account before
--     any password comparison, so an AI account can never hold a human session.
--   * `agentRef` is how a portal employee row becomes "really" a digital employee (ADR-002):
--     harness_agent.portal_employee_id and employee.agentRef point at each other.
--   * `isAgentMsg` is optional (03 §1.1 exception 3 is marked optional). It exists so the UI can
--     render an AI badge next to a message instead of leaving users to guess who they are
--     talking to. If the portal team prefers a `mark` convention, drop this statement.
--   * portal is utf8_general_ci; these columns are ASCII-only on purpose, so no collation
--     surprises are introduced into the legacy database.
-- =====================================================================================

-- 例外 1
ALTER TABLE `users` ADD COLUMN `isAI` tinyint(4) NOT NULL DEFAULT 0
    COMMENT 'whether this is a digital-employee account (1 = AI, login to portal is refused)';

-- 例外 2
ALTER TABLE `employee` ADD COLUMN `agentRef` varchar(64) DEFAULT NULL
    COMMENT 'harness agent uuid7 when this employee is a digital employee';

-- 例外 3 (optional)
ALTER TABLE `message` ADD COLUMN `isAgentMsg` tinyint(4) NOT NULL DEFAULT 0
    COMMENT 'whether the message was sent by a digital employee';

-- -------------------------------------------------------------------------------------
-- Verification after applying
-- -------------------------------------------------------------------------------------
-- SELECT COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_COMMENT
--   FROM information_schema.columns
--  WHERE table_schema = DATABASE()
--    AND ((table_name = 'users'    AND column_name = 'isAI')
--      OR (table_name = 'employee' AND column_name = 'agentRef')
--      OR (table_name = 'message'  AND column_name = 'isAgentMsg'));
--
-- Row counts must be unchanged by the ALTERs:
-- SELECT 'users' t, COUNT(*) c FROM `users`
-- UNION ALL SELECT 'employee', COUNT(*) FROM `employee`
-- UNION ALL SELECT 'message', COUNT(*) FROM `message`;