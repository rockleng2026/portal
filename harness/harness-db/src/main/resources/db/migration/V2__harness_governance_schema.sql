-- =====================================================================================
-- harness V2 :: M0 governance additions
-- Required by, but not table-specified in, document/harness/03-协议与数据模型.md:
--   - 01 §0 P4   每次自主动作都留痕，可回放到分钟级      -> harness_audit
--   - 04 §8.2    必备 Kill-Switch（5 个粒度）             -> harness_killswitch
--   - 01 §6.3    Agent 模板市场                           -> harness_agent_template
--   - 01 §2.3    不复用 users.password，独立凭证体系      -> harness_principal
--   - 01 §5.1    生命周期可追溯                           -> harness_agent_state_log
--   - 03 §8.2    脏数据不静默丢弃                         -> harness_dirty_queue
--
-- Deliberately NOT here (Redis is the specified store, see README "存储分工"):
--   - binding_code (TTL 10min, 03 §3.5), HMAC nonce (TTL 5min, 03 §9)
-- =====================================================================================

SET NAMES utf8mb4;

-- 事件聚合计数器：01 §7.3 要求"相同指纹的异常在时间窗内合并为一条，附计数"。
-- harness_event 是冻结的转写件，因此 last_seen_at 放在本增量中（received_at 即首次出现时间）。
ALTER TABLE `harness_event`
  ADD COLUMN `last_seen_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    COMMENT '同一去重窗口内最近一次命中时间',
  ADD COLUMN `last_event_id` CHAR(36) DEFAULT NULL
    COMMENT '窗口内最近一次到达的 event_id，便于回溯与对账';

-- 只追加的治理审计流。任何"谁在什么时候让系统做了什么/拒绝了什么"都必须在此可查。
CREATE TABLE `harness_audit` (
  `audit_id`     CHAR(36)  NOT NULL,
  `at`           DATETIME(3) NOT NULL COMMENT '毫秒精度：回放需要分钟级且可排序',
  `trace_id`     CHAR(36)  NOT NULL COMMENT '一次请求/一次任务的链路 id，可串起 event->plan->action',
  `actor_type`   VARCHAR(16) NOT NULL COMMENT 'human/agent/terminal/system',
  `actor_id`     VARCHAR(64) NOT NULL COMMENT 'human:<employeeId> / agent:<uuid7> / terminal:<uuid7> / system:<code>',
  `op`           VARCHAR(64) NOT NULL COMMENT '如 grant.issue/grant.revoke/cap.call/issue.reject/agent.pause',
  `object_type`  VARCHAR(32) NOT NULL COMMENT 'agent/terminal/capability/grant/issue/plan/action/killswitch',
  `object_id`    VARCHAR(64) DEFAULT NULL,
  `outcome`      VARCHAR(16) NOT NULL COMMENT 'allow/deny/approval/reject/error',
  `reason_code`  VARCHAR(64) DEFAULT NULL COMMENT '机器可读的拒绝原因码',
  `reason`       VARCHAR(512) DEFAULT NULL COMMENT '人类可读说明',
  `evidence`     JSON DEFAULT NULL COMMENT '引用的 event_id/plan_id/action_id/审批 id/对象快照',
  `source_ip`    VARCHAR(45) DEFAULT NULL,
  `prev_hash`    CHAR(64) DEFAULT NULL COMMENT '前一条记录的 hash，构成防篡改链',
  `entry_hash`   CHAR(64) NOT NULL COMMENT 'hash(prev_hash + 本条规范字段)',
  PRIMARY KEY (`audit_id`),
  KEY `idx_actor` (`actor_type`,`actor_id`,`at`),
  KEY `idx_object` (`object_type`,`object_id`,`at`),
  KEY `idx_trace` (`trace_id`),
  KEY `idx_op_at` (`op`,`at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Kill-Switch：全局/部门/Agent/能力/终端 五个粒度（04 §8.2）
CREATE TABLE `harness_killswitch` (
  `switch_id`    CHAR(36) NOT NULL,
  `scope`        VARCHAR(16) NOT NULL COMMENT 'global/dept/agent/cap/terminal',
  `scope_id`     VARCHAR(64) NOT NULL DEFAULT '*' COMMENT 'global 用 *；其余为具体 id 或 cap_key',
  `effect`       VARCHAR(16) NOT NULL DEFAULT 'to_l0' COMMENT 'to_l0/stop/halt 执行包',
  `active`       TINYINT NOT NULL DEFAULT 1,
  `reason`       VARCHAR(255) NOT NULL,
  `activated_by` VARCHAR(64) NOT NULL COMMENT '必须 human:<employeeId>',
  `activated_at` DATETIME NOT NULL,
  `released_by`  VARCHAR(64) DEFAULT NULL,
  `released_at`  DATETIME DEFAULT NULL,
  PRIMARY KEY (`switch_id`),
  UNIQUE KEY `uk_scope` (`scope`,`scope_id`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Agent 模板市场（01 §6.3）：内置售前/售后/软件工程师/助理小C/市场分析师/UI/测试/运维/数据/项目管家
CREATE TABLE `harness_agent_template` (
  `template_id`  CHAR(36) NOT NULL,
  `template_key` VARCHAR(64) NOT NULL COMMENT '如 tpl.support_engineer',
  `name`         VARCHAR(64) NOT NULL,
  `agent_type`   VARCHAR(32) NOT NULL COMMENT 'service/management/expert/worker',
  `domain`       VARCHAR(32) NOT NULL DEFAULT 'general' COMMENT 'sales/presales/support/product/ops/it',
  `description`  VARCHAR(512) DEFAULT NULL,
  `autonomy_level` TINYINT NOT NULL DEFAULT 0 COMMENT '新建时的自治等级上限',
  `model_id`     VARCHAR(64) NOT NULL DEFAULT 'brain-core',
  `local_model`  VARCHAR(64) DEFAULT 'qwen3.8b',
  `goals`        JSON DEFAULT NULL COMMENT 'goal_set 种子（01 §8.1）',
  `skill_refs`   JSON DEFAULT NULL COMMENT '[{skill_key,version}] 预装技能',
  `position_hint` INT(11) DEFAULT NULL COMMENT '建议绑定的 portal.workposition.id',
  `cap_keys`     JSON DEFAULT NULL COMMENT '建议申请的能力（仍需人工确认）',
  `status`       VARCHAR(16) NOT NULL DEFAULT 'active' COMMENT 'active/deprecated',
  `built_in`     TINYINT NOT NULL DEFAULT 0,
  `created_by`   VARCHAR(64) NOT NULL COMMENT 'human:<employeeId> / system:seed',
  `created_at`   DATETIME NOT NULL,
  `updated_at`   DATETIME NOT NULL,
  PRIMARY KEY (`template_id`), UNIQUE KEY `uk_tpl_key` (`template_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 机器到机器身份（03 §9）：服务账号 + HMAC，密钥只存 hash，绝不落 portal.users.password
CREATE TABLE `harness_principal` (
  `principal_id` CHAR(36) NOT NULL,
  `client_id`    VARCHAR(64) NOT NULL COMMENT 'HMAC 客户端标识',
  `principal_type` VARCHAR(16) NOT NULL COMMENT 'service/agent/terminal/console',
  `secret_hash`  CHAR(64) NOT NULL COMMENT 'sha256(secret)；明文只在创建时返回一次',
  `agent_id`     CHAR(36) DEFAULT NULL,
  `terminal_id`  CHAR(36) DEFAULT NULL,
  `employee_id`  INT(11) DEFAULT NULL COMMENT '自然人时记录',
  `api_scope`    VARCHAR(255) NOT NULL DEFAULT '/api/harness/*' COMMENT '允许的路径前缀',
  `status`       VARCHAR(16) NOT NULL DEFAULT 'active' COMMENT 'active/disabled/expired',
  `created_by`   VARCHAR(64) NOT NULL COMMENT 'human:<employeeId>',
  `expires_at`   DATETIME DEFAULT NULL,
  `last_used_at` DATETIME DEFAULT NULL,
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`principal_id`), UNIQUE KEY `uk_client` (`client_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 数字员工生命周期轨迹（01 §5.1：入职/停权/退役可追溯，旧版本可回滚）
CREATE TABLE `harness_agent_state_log` (
  `log_id`       BIGINT NOT NULL AUTO_INCREMENT,
  `agent_id`     CHAR(36) NOT NULL,
  `from_status`  VARCHAR(16) DEFAULT NULL,
  `to_status`    VARCHAR(16) NOT NULL,
  `reason`       VARCHAR(255) NOT NULL,
  `changed_by`   VARCHAR(64) NOT NULL COMMENT 'human:<employeeId> 或 system:<rule>',
  `snapshot`     JSON DEFAULT NULL COMMENT '变更前后的岗位/权限/自治等级快照',
  `at`           DATETIME NOT NULL,
  PRIMARY KEY (`log_id`), KEY `idx_agent` (`agent_id`,`at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 脏数据队列（03 §8.2）：解析失败不静默丢弃，显式告警 + 可追溯
CREATE TABLE `harness_dirty_queue` (
  `dirty_id`     CHAR(36) NOT NULL,
  `source`       VARCHAR(32) NOT NULL COMMENT 'adapter 来源：portal/harness',
  `object_type`  VARCHAR(32) NOT NULL COMMENT '如 workposition.permission / scheduleplan.begintime',
  `object_ref`   VARCHAR(128) NOT NULL COMMENT '主键或复合键',
  `field`        VARCHAR(64) DEFAULT NULL,
  `raw_value`    TEXT DEFAULT NULL COMMENT '原始脏值（截断存储）',
  `reason`       VARCHAR(255) NOT NULL COMMENT '解析失败原因',
  `severity`     VARCHAR(8) NOT NULL DEFAULT 'W' COMMENT 'W 脏数据 / E 阻塞同步',
  `occurrences`  INT NOT NULL DEFAULT 1,
  `first_seen_at` DATETIME NOT NULL,
  `last_seen_at` DATETIME NOT NULL,
  `status`       VARCHAR(16) NOT NULL DEFAULT 'open' COMMENT 'open/resolved/ignored',
  `resolved_by`  VARCHAR(64) DEFAULT NULL,
  `resolved_at`  DATETIME DEFAULT NULL,
  `resolution`   VARCHAR(512) DEFAULT NULL,
  PRIMARY KEY (`dirty_id`),
  UNIQUE KEY `uk_obj` (`source`,`object_type`,`object_ref`,`field`),
  KEY `idx_open` (`status`,`severity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;