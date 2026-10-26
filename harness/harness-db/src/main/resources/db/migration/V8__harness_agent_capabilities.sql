-- =====================================================================================
-- harness V8 :: the capabilities the terminal agent actually uses
--
-- The seed (V3) had the portal-side capabilities and the file capabilities, but not the two
-- git ones - and the terminal agent's tool vocabulary is the platform's vocabulary, so a tool
-- whose capability key does not exist can never be granted and the agent can never act.
--
-- The levels match the tool definitions in the agent runtime (harness-terminal/src/tools):
--   git.read   L0  reading the repository state
--   git.commit L2  creating a commit
--
-- The file capabilities (cap:file.read/write/delete) and cap:ssh.exec already existed in V3
-- with these levels; the agent runtime was aligned to them.
-- =====================================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO `harness_capability`
  (`cap_id`, `cap_key`, `name`, `kind`, `input_schema`, `side_effect`, `reversible`, `blast_radius`,
   `requires_human`, `min_level`, `risk_class`, `destructive`, `approval_policy`, `timeout_ms`, `status`)
VALUES
  ('0198f300-0000-7000-8000-000000000030', 'cap:git.read', '读取仓库状态', 'cli',
   '{"type":"object","properties":{}}', 'read', 1, 1, 0, 0, 'R1', 0, 'auto', 30000, 'active'),
  ('0198f300-0000-7000-8000-000000000031', 'cap:git.commit', '创建 git 提交', 'cli',
   '{"type":"object","properties":{"message":{"type":"string"}}}', 'write', 1, 1, 0, 2, 'R2', 0, 'auto', 30000, 'active');
