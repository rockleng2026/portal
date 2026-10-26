-- =====================================================================================
-- harness V1 :: core schema
-- Source of truth: document/harness/03-协议与数据模型.md  §1.2 / §2.1 - §2.6
-- This file is a FROZEN CONTRACT. Any change requires a version bump (V2, V3, ...) and a
-- note in document/harness/03-协议与数据模型.md (E-series errata).
--
-- Deviations from the document (spec defects found while transcribing, see ERRATA.md):
--   E-01  harness_event: the unique key uk_fp_window(fingerprint, event_window) references a
--        column that was never declared.  Added `event_window` VARCHAR(64) NOT NULL DEFAULT 'none'.
--        Without it the dedup requirement (A0-7: 1000 identical events -> 1 row) cannot hold.
--   E-02  JSON columns: MySQL 8 forbids a default value on JSON columns.  All JSON columns are
--        declared as plain `JSON NULL`.  Semantics unchanged (absent == NULL).
--   E-03  harness_approval: TTL was declared but there was no expiry column, so an unattended
--        pending approval could never auto-expire (01 §8.2 / 04 §8.3 item 4).  Added
--        `expires_at` DATETIME NOT NULL, populated from ttl_seconds at write time.
--   E-04  harness_issue.state comment did not list `replan`, although the state machine in
--        01 §6.2 includes it.  Comment corrected only; no column change.
--
-- NOT IN THIS FILE: everything that needs a natural-human anchor is by design absent.
-- =====================================================================================

SET NAMES utf8mb4;

-- -------------------------------------------------------------------------------------
-- §2.1 identity & organisation
-- -------------------------------------------------------------------------------------

-- 数字员工（Agent）
CREATE TABLE `harness_agent` (
  `agent_id`      CHAR(36)     NOT NULL COMMENT 'UUIDv7',
  `agent_key`     VARCHAR(128) NOT NULL COMMENT '业务唯一键，如 agent:leon:sales:sh001',
  `name`          VARCHAR(64)  NOT NULL COMMENT '显示名，默认 leon',
  `agent_type`    VARCHAR(32)  NOT NULL COMMENT 'service/management/expert/worker',
  `template_id`   CHAR(36)     DEFAULT NULL COMMENT '来源模板',
  `portal_employee_id` INT(11) DEFAULT NULL COMMENT 'portal.employee.id（入职后回填）',
  `portal_user_id`    INT(11) DEFAULT NULL COMMENT 'portal.users.UserID',
  `portal_workposition_id` INT(11) DEFAULT NULL COMMENT '岗位，对应权限来源',
  `dept_id`       INT(11)      NOT NULL COMMENT 'portal.department.id',
  `reports_to`    INT(11)      DEFAULT NULL COMMENT '汇报对象 portal.employee.id',
  `owner_id`      INT(11)      NOT NULL COMMENT '人类责任人 portal.employee.id（法律与审批锚点）',
  `autonomy_level` TINYINT     NOT NULL DEFAULT 0 COMMENT 'L0..L4 上限',
  `model_id`      VARCHAR(64)  NOT NULL DEFAULT 'brain-core',
  `local_model`   VARCHAR(64)  DEFAULT 'qwen3.8b',
  `status`        VARCHAR(16)  NOT NULL DEFAULT 'draft' COMMENT 'draft/onboarding/active/paused/retired',
  `budget_quota`  JSON         NULL COMMENT '{tokenPerDay, toolCallsPerDay, costPerMonth}',
  `skills`        JSON         NULL COMMENT '技能版本引用 [{skill_id,version}]',
  `skill_sig`     VARCHAR(128) DEFAULT NULL COMMENT '技能集签名，防止被篡改',
  `mem_policy`    VARCHAR(32)  NOT NULL DEFAULT 'standard',
  `created_at`    DATETIME     NOT NULL,
  `updated_at`    DATETIME     NOT NULL,
  `retired_at`    DATETIME     DEFAULT NULL,
  `retire_reason` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `uk_agent_key` (`agent_key`),
  KEY `idx_dept` (`dept_id`), KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 终端（设备）
CREATE TABLE `harness_terminal` (
  `terminal_id`   CHAR(36)     NOT NULL,
  `device_id`     VARCHAR(128) NOT NULL COMMENT '设备指纹（主板+MAC 派生，不可变）',
  `os`            VARCHAR(16)  NOT NULL COMMENT 'windows/linux/macos',
  `os_version`    VARCHAR(64)  DEFAULT NULL,
  `hostname`      VARCHAR(128) DEFAULT NULL,
  `agent_id`      CHAR(36)     DEFAULT NULL COMMENT '绑定的数字员工',
  `bind_type`     VARCHAR(16)  NOT NULL DEFAULT 'none' COMMENT 'none/human/agent',
  `portal_employee_id` INT(11) DEFAULT NULL COMMENT '绑定的自然人（human 模式）',
  `status`        VARCHAR(16)  NOT NULL DEFAULT 'unbound' COMMENT 'unbound/binding/online/offline/revoked',
  `agent_version` VARCHAR(32)  NOT NULL,
  `capabilities`  JSON         NULL COMMENT '本机可用能力（离线可用子集）',
  `last_heartbeat` DATETIME    DEFAULT NULL,
  `bound_at`      DATETIME     DEFAULT NULL,
  `revoked_at`    DATETIME     DEFAULT NULL,
  `metrics`       JSON         NULL,
  PRIMARY KEY (`terminal_id`),
  UNIQUE KEY `uk_device` (`device_id`),
  KEY `idx_agent` (`agent_id`), KEY `idx_hb` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 能力（工具统一抽象：CLI / MCP / OpenAPI / DB / 内建）
CREATE TABLE `harness_capability` (
  `cap_id`      CHAR(36)     NOT NULL,
  `cap_key`     VARCHAR(160) NOT NULL COMMENT '如 cap:portal.mission.complete / cap:ssh.exec',
  `name`        VARCHAR(128) NOT NULL,
  `kind`        VARCHAR(16)  NOT NULL COMMENT 'cli/mcp/openapi/db/internal/http',
  `source_ref`  VARCHAR(255) DEFAULT NULL COMMENT 'MCP server / OpenAPI spec URL / DB view',
  `input_schema`  JSON       NOT NULL,
  `output_schema` JSON       NULL,
  `side_effect` VARCHAR(16)  NOT NULL DEFAULT 'read' COMMENT 'read/write/exec/irreversible',
  `reversible`  TINYINT     NOT NULL DEFAULT 1,
  `blast_radius` TINYINT     NOT NULL DEFAULT 1 COMMENT '影响半径估计（对象数）',
  `requires_human` TINYINT   NOT NULL DEFAULT 0,
  `min_level`   TINYINT      NOT NULL DEFAULT 1 COMMENT '执行所需最低自主等级',
  `risk_class`  VARCHAR(8)   NOT NULL DEFAULT 'R3' COMMENT 'R0..R4',
  `destructive` TINYINT      NOT NULL DEFAULT 0,
  `approval_policy` VARCHAR(32) NOT NULL DEFAULT 'auto' COMMENT 'auto/human/dual',
  `timeout_ms`  INT          NOT NULL DEFAULT 60000,
  `status`      VARCHAR(16)  NOT NULL DEFAULT 'active',
  `owner_id`    INT(11)      DEFAULT NULL,
  `created_at`  DATETIME     NOT NULL,
  PRIMARY KEY (`cap_id`), UNIQUE KEY `uk_cap_key` (`cap_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 规范化镜像：portal 组织树（只读同步，替代直接依赖 portal 脏 schema）
CREATE TABLE `harness_org_node` (
  `node_id`      INT(11) NOT NULL COMMENT '= portal.department.id',
  `name`         VARCHAR(128) NOT NULL,
  `parent_id`    INT(11) NOT NULL,
  `director_id`  INT(11) DEFAULT NULL COMMENT '= portal.department.directorId（汇报关系来源）',
  `grade_id`     INT(11) DEFAULT NULL COMMENT '= portal.department.gradeid',
  `level`        INT(11) DEFAULT NULL COMMENT '推导出的层级深度',
  `path`         VARCHAR(512) DEFAULT NULL COMMENT '物化路径，便于子树查询',
  `delflag`      INT(11) DEFAULT NULL,
  `synced_at`    DATETIME NOT NULL,
  PRIMARY KEY (`node_id`), KEY `idx_parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 规范化镜像：员工（01 §2.1 employee；03 §8 的坑：isLeave 语义与直觉相反）
CREATE TABLE `harness_org_employee` (
  `employee_id`  INT(11) NOT NULL COMMENT '= portal.employee.id',
  `uuid`         VARCHAR(64) DEFAULT NULL COMMENT '= portal.employee.uuid',
  `name`         VARCHAR(64) NOT NULL,
  `dept_id`      INT(11) NOT NULL COMMENT '= portal.employee.department',
  `position`     INT(11) DEFAULT NULL COMMENT '= employee.position -> groups.groupID（权限等级组）',
  `workposition_id` INT(11) DEFAULT NULL COMMENT '= employee.workposition（岗位）',
  `grade_id`     INT(11) DEFAULT NULL COMMENT '= employee.gradeid',
  `emp_no`       VARCHAR(64) DEFAULT NULL,
  `email`        VARCHAR(128) DEFAULT NULL,
  `is_leave`     INT(11) DEFAULT NULL COMMENT 'portal 原值；0=在职 1=离职（与直觉相反，原样保留）',
  `is_agent`     TINYINT NOT NULL DEFAULT 0 COMMENT '1=数字员工（由 employee.agentRef 非空推导）',
  `agent_ref`    VARCHAR(64) DEFAULT NULL COMMENT '= portal.employee.agentRef -> harness_agent.agent_id',
  `synced_at`    DATETIME NOT NULL,
  PRIMARY KEY (`employee_id`), KEY `idx_dept` (`dept_id`), KEY `idx_agent_ref` (`agent_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 规范化镜像：岗位 -> 能力 的映射（由 portal.workposition 解析而来）
CREATE TABLE `harness_cap_binding` (
  `binding_id`   BIGINT NOT NULL AUTO_INCREMENT,
  `workposition_id` INT(11) NOT NULL COMMENT '= portal.workposition.id',
  `cap_id`       CHAR(36) NOT NULL,
  `function_id`  INT(11) DEFAULT NULL COMMENT '= portal.functioninfo.FunctionID',
  `sub_op`       VARCHAR(16) DEFAULT NULL COMMENT '= permissions 中的子操作位，如 .7',
  `source`       VARCHAR(16) NOT NULL DEFAULT 'position' COMMENT 'position/role/individual/grant',
  `synced_at`    DATETIME NOT NULL,
  PRIMARY KEY (`binding_id`),
  UNIQUE KEY `uk_binding` (`workposition_id`,`cap_id`,`source`),
  KEY `idx_cap` (`cap_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 能力授予（能力 ∩ 作用域 ∩ 时效 三层模型）
CREATE TABLE `harness_grant` (
  `grant_id`     CHAR(36)     NOT NULL,
  `agent_id`     CHAR(36)     NOT NULL,
  `cap_id`       CHAR(36)     NOT NULL,
  `scope`        JSON         NOT NULL COMMENT '{deptIds:[],rowFilter:{},resourcePerm:""}',
  `ttl_seconds`  INT          NOT NULL,
  `granted_at`   DATETIME     NOT NULL,
  `expires_at`   DATETIME     NOT NULL,
  `granted_by`   VARCHAR(64)  NOT NULL COMMENT 'human:employeeId / system:xxx',
  `reason`       VARCHAR(255) DEFAULT NULL,
  `revoked_at`   DATETIME     DEFAULT NULL,
  `status`       VARCHAR(16)  NOT NULL DEFAULT 'active',
  PRIMARY KEY (`grant_id`),
  KEY `idx_agent_cap` (`agent_id`,`cap_id`), KEY `idx_exp` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------------------------------------
-- §2.2 events, plans, execution
-- -------------------------------------------------------------------------------------

-- 统一事件总线（所有触发源）
CREATE TABLE `harness_event` (
  `event_id`     CHAR(36)     NOT NULL,
  `fingerprint`  VARCHAR(128) NOT NULL COMMENT '去重指纹：source+key+hash(window)',
  `event_window` VARCHAR(64)  NOT NULL DEFAULT 'none' COMMENT '去重时间窗标识（ERRATA E-01）',
  `source`       VARCHAR(32)  NOT NULL COMMENT 'email/im/group/schedule/todo/patrol/alert/log/system/webhook',
  `event_type`   VARCHAR(64)  NOT NULL,
  `latency_class` VARCHAR(16) NOT NULL DEFAULT 'batch' COMMENT 'realtime/nearline/batch',
  `priority`     TINYINT      NOT NULL DEFAULT 5,
  `payload`      JSON         NOT NULL,
  `content_trust` VARCHAR(8)  NOT NULL DEFAULT 'trusted' COMMENT 'trusted/untrusted —— 指令注入防线',
  `source_ref`   VARCHAR(255) DEFAULT NULL COMMENT 'portal 侧原始对象引用（messageid/taskid/...）',
  `received_at`  DATETIME     NOT NULL,
  `dedup_count`  INT          NOT NULL DEFAULT 1,
  `status`       VARCHAR(16)  NOT NULL DEFAULT 'new',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `uk_fp_window` (`fingerprint`,`event_window`),
  KEY `idx_src_status` (`source`,`status`), KEY `idx_recv` (`received_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 计划
CREATE TABLE `harness_plan` (
  `plan_id`      CHAR(36) NOT NULL,
  `event_id`     CHAR(36) DEFAULT NULL,
  `agent_id`     CHAR(36) NOT NULL,
  `goal`         TEXT     NOT NULL,
  `steps`        JSON     NOT NULL COMMENT '[{seq,action,cap_id,args,acceptance,rollback}]',
  `acceptance`   TEXT     NOT NULL COMMENT '验收标准（可机器判定优先）',
  `budget`       JSON     DEFAULT NULL,
  `risk`         VARCHAR(8) DEFAULT 'R2',
  `status`       VARCHAR(16) NOT NULL DEFAULT 'draft' COMMENT 'draft/approved/running/done/failed/rolled_back',
  `parent_plan_id` CHAR(36) DEFAULT NULL,
  `created_at`   DATETIME NOT NULL,
  `updated_at`   DATETIME NOT NULL,
  PRIMARY KEY (`plan_id`), KEY `idx_agent_status` (`agent_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 执行轨迹（一次工具调用 = 一条，可完整回放）
CREATE TABLE `harness_action` (
  `action_id`    CHAR(36) NOT NULL,
  `plan_id`     CHAR(36) NOT NULL,
  `step_seq`    INT     NOT NULL,
  `agent_id`    CHAR(36) NOT NULL,
  `terminal_id` CHAR(36) DEFAULT NULL,
  `cap_id`      CHAR(36) DEFAULT NULL,
  `arguments`   JSON    NOT NULL,
  `arguments_hash` VARCHAR(64) NOT NULL COMMENT '幂等键：hash(plan+seq+args)',
  `source_refs` JSON    DEFAULT NULL COMMENT '若参数源自不可信内容，必须带引用（引用才可执行）',
  `result`      JSON    DEFAULT NULL,
  `exit_code`   INT     DEFAULT NULL,
  `status`      VARCHAR(16) NOT NULL DEFAULT 'ok' COMMENT 'ok/error/rejected/blocked/timeout',
  `rejected_reason` VARCHAR(255) DEFAULT NULL,
  `started_at`  DATETIME NOT NULL,
  `ended_at`    DATETIME DEFAULT NULL,
  `duration_ms` INT     DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  UNIQUE KEY `uk_idem` (`arguments_hash`),
  KEY `idx_plan` (`plan_id`), KEY `idx_agent_time` (`agent_id`,`started_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 交接包
CREATE TABLE `harness_handover` (
  `handover_id`  CHAR(36) NOT NULL,
  `from_agent`   CHAR(36) NOT NULL,
  `to_agent`     CHAR(36) NOT NULL,
  `plan_id`      CHAR(36) DEFAULT NULL,
  `goal`         TEXT NOT NULL,
  `done`         JSON NOT NULL COMMENT '[{fact,evidence_ref}]',
  `todo`         JSON NOT NULL,
  `pitfalls`     JSON NOT NULL,
  `suggestion`   TEXT,
  `accepted_at`  DATETIME DEFAULT NULL,
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`handover_id`), KEY `idx_to` (`to_agent`,`accepted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 升级（上报）链
CREATE TABLE `harness_escalation` (
  `esc_id`       CHAR(36) NOT NULL,
  `agent_id`     CHAR(36) NOT NULL,
  `to_agent`     CHAR(36) DEFAULT NULL COMMENT 'AI 接收方',
  `to_employee`  INT(11)  DEFAULT NULL COMMENT '真人接收方',
  `hop`          TINYINT  NOT NULL DEFAULT 1,
  `reason`       VARCHAR(255) NOT NULL,
  `out_of_scope` TINYINT  NOT NULL DEFAULT 0 COMMENT '是否超出岗位权限范围',
  `status`       VARCHAR(16) NOT NULL DEFAULT 'open' COMMENT 'open/accepted/closed/handoff',
  `created_at`   DATETIME NOT NULL,
  `closed_at`    DATETIME DEFAULT NULL,
  PRIMARY KEY (`esc_id`), KEY `idx_open` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------------------------------------
-- §2.3 governance: issue / approval / decision
-- -------------------------------------------------------------------------------------

-- 问题单（用户态上报 / 系统发现）
CREATE TABLE `harness_issue` (
  `issue_id`     CHAR(36) NOT NULL,
  `source`       VARCHAR(32) NOT NULL COMMENT 'user_report/agent_detect/system',
  `reporter_agent` CHAR(36) DEFAULT NULL,
  `reporter_employee` INT(11) DEFAULT NULL,
  `domain`       VARCHAR(32) NOT NULL DEFAULT 'general' COMMENT 'sales/presales/support/product/ops/it',
  `title`        VARCHAR(255) NOT NULL,
  `detail`       TEXT NOT NULL,
  `severity`     VARCHAR(8) NOT NULL DEFAULT 'P3' COMMENT 'P0..P4',
  `classification` VARCHAR(16) DEFAULT NULL COMMENT 'not_a_problem/known_issue/defect/requirement',
  `evidence`     JSON DEFAULT NULL COMMENT '证据引用（截图、日志 ID、portal 对象 ID）',
  `suggested_fix` TEXT DEFAULT NULL,
  `needed_cap`   VARCHAR(160) DEFAULT NULL COMMENT '需要的更高能力',
  `state`        VARCHAR(24) NOT NULL DEFAULT 'draft'
    COMMENT 'draft/submitted/reviewing/rejected/self_fixed/approval_pending/escalated/fixed/closed/replan',
  `reviewer_agent` CHAR(36) DEFAULT NULL,
  `reviewer_employee` INT(11) DEFAULT NULL,
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '打回必填',
  `reject_evidence` JSON DEFAULT NULL,
  `portal_ref`   VARCHAR(64) DEFAULT NULL COMMENT 'portal conkout.id / new_question.id',
  `created_at`   DATETIME NOT NULL,
  `updated_at`   DATETIME NOT NULL,
  `closed_at`    DATETIME DEFAULT NULL,
  PRIMARY KEY (`issue_id`), KEY `idx_state` (`state`,`severity`), KEY `idx_reporter` (`reporter_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 审批请求（提权 / 高风险动作）
CREATE TABLE `harness_approval` (
  `approval_id`  CHAR(36) NOT NULL,
  `issue_id`     CHAR(36) DEFAULT NULL,
  `plan_id`      CHAR(36) DEFAULT NULL,
  `agent_id`     CHAR(36) NOT NULL,
  `requested_cap` VARCHAR(160) NOT NULL,
  `scope`        JSON NOT NULL,
  `ttl_seconds`  INT NOT NULL,
  `expires_at`   DATETIME NOT NULL COMMENT '由 ttl_seconds 在写入时算出；超时自动 expired（ERRATA E-03）',
  `risk_class`   VARCHAR(8) NOT NULL DEFAULT 'R3',
  `blast_radius` INT NOT NULL DEFAULT 1,
  `rollback_plan` TEXT NOT NULL,
  `justification` TEXT NOT NULL,
  `status`       VARCHAR(16) NOT NULL DEFAULT 'pending' COMMENT 'pending/approved/rejected/expired/used',
  `decided_by`   VARCHAR(64) DEFAULT NULL COMMENT '必须为 human:employeeId',
  `decided_at`   DATETIME DEFAULT NULL,
  `decision_note` VARCHAR(255) DEFAULT NULL,
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`approval_id`), KEY `idx_pending` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 决策记录（大脑裁决，必须含理由）
CREATE TABLE `harness_decision` (
  `decision_id`  CHAR(36) NOT NULL,
  `topic`        VARCHAR(255) NOT NULL,
  `context`      JSON NOT NULL COMMENT '冲突双方主张',
  `principles_applied` JSON NOT NULL COMMENT '适用原则编号（P1..P8）',
  `outcome`      TEXT NOT NULL,
  `rejected_alternatives` JSON DEFAULT NULL,
  `reversibility` VARCHAR(16) NOT NULL DEFAULT 'reversible' COMMENT 'reversible/irreversible',
  `decided_by`   VARCHAR(64) NOT NULL COMMENT 'brain:core / human:employeeId',
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`decision_id`), KEY `idx_topic` (`topic`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------------------------------------
-- §2.4 evolution: experience / skill / eval / model version
-- -------------------------------------------------------------------------------------

-- 情景记忆（只追加，不可改写）
CREATE TABLE `harness_experience` (
  `exp_id`       CHAR(36) NOT NULL,
  `agent_id`     CHAR(36) NOT NULL,
  `plan_id`      CHAR(36) DEFAULT NULL,
  `task_type`    VARCHAR(64) NOT NULL,
  `outcome`      VARCHAR(16) NOT NULL COMMENT 'success/failure/rejected/rolled_back/complained',
  `verdict_source` VARCHAR(24) NOT NULL DEFAULT 'self' COMMENT 'external/self —— 自评需打折',
  `context_hash` VARCHAR(64) NOT NULL,
  `trajectory`   JSON NOT NULL COMMENT '不可变快照',
  `attribution`  JSON DEFAULT NULL,
  `confidence`   DECIMAL(4,3) NOT NULL DEFAULT 0.500,
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`exp_id`), KEY `idx_agent_outcome` (`agent_id`,`outcome`), KEY `idx_ctx` (`context_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 程序记忆（技能，版本化 + 签名 + 可回滚）
CREATE TABLE `harness_skill` (
  `skill_id`     CHAR(36) NOT NULL,
  `skill_key`    VARCHAR(128) NOT NULL,
  `version`      INT NOT NULL,
  `parent_version` INT DEFAULT NULL,
  `name`         VARCHAR(128) NOT NULL,
  `definition`   JSON NOT NULL COMMENT '{steps[], tools[], preconditions[], postconditions[]}',
  `signature`    VARCHAR(256) NOT NULL COMMENT '内容签名，终端校验后才加载',
  `author_agent` CHAR(36) DEFAULT NULL,
  `author_human` INT(11) DEFAULT NULL,
  `eval_result`  JSON DEFAULT NULL COMMENT '{replayPass, sandboxPass, adversarialPass, score}',
  `status`       VARCHAR(16) NOT NULL DEFAULT 'candidate'
    COMMENT 'candidate/evaluating/approved/gray/released/deprecated/rolled_back',
  `rollout_pct`  INT NOT NULL DEFAULT 0,
  `scope`        JSON DEFAULT NULL COMMENT '可见范围：private/agent/dept/org',
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`skill_id`), UNIQUE KEY `uk_skill_ver` (`skill_key`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 评测集（与训练集严格隔离）
CREATE TABLE `harness_eval_set` (
  `eval_set_id`  CHAR(36) NOT NULL,
  `name`         VARCHAR(128) NOT NULL,
  `kind`         VARCHAR(32) NOT NULL COMMENT 'replay/sandbox/adversarial/regression',
  `cases`        JSON NOT NULL,
  `version`      INT NOT NULL DEFAULT 1,
  `adversarial`  TINYINT NOT NULL DEFAULT 0 COMMENT '是否含注入/越权诱导样本',
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`eval_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 模型版本
CREATE TABLE `harness_model_version` (
  `model_version_id` CHAR(36) NOT NULL,
  `model_id`     VARCHAR(64) NOT NULL,
  `version`      VARCHAR(32) NOT NULL,
  `artifact_ref` VARCHAR(255) NOT NULL,
  `metrics`      JSON DEFAULT NULL,
  `eval_report`  JSON DEFAULT NULL,
  `status`       VARCHAR(16) NOT NULL DEFAULT 'candidate' COMMENT 'candidate/gray/active/rollback',
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`model_version_id`), UNIQUE KEY `uk_mv` (`model_id`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------------------------------------
-- §2.5 system registry & federation
-- -------------------------------------------------------------------------------------

CREATE TABLE `harness_system` (
  `system_id`    CHAR(36) NOT NULL,
  `sys_key`      VARCHAR(64) NOT NULL COMMENT 'portal/cdn/crm/erp/jira/...',
  `name`         VARCHAR(128) NOT NULL,
  `access_type`  VARCHAR(16) NOT NULL COMMENT 'db_ro/openapi/mcp/cli/file',
  `spec_ref`     VARCHAR(255) DEFAULT NULL,
  `cap_ids`      JSON DEFAULT NULL,
  `data_class`   VARCHAR(8) NOT NULL DEFAULT 'C2' COMMENT 'C0..C4 数据分级',
  `owner_id`     INT(11) NOT NULL COMMENT '自然人责任人（审批锚点）',
  `status`       VARCHAR(16) NOT NULL DEFAULT 'active',
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`system_id`), UNIQUE KEY `uk_sys_key` (`sys_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 联邦关系（显式授权）
CREATE TABLE `harness_federation` (
  `fed_id`       CHAR(36) NOT NULL,
  `local_fed_id` VARCHAR(64) NOT NULL,
  `peer_fed_id`  VARCHAR(64) NOT NULL,
  `peer_org`     VARCHAR(128) NOT NULL,
  `status`       VARCHAR(16) NOT NULL DEFAULT 'pending' COMMENT 'pending/active/revoked',
  `allowed_caps` JSON NOT NULL,
  `data_policy`  JSON NOT NULL COMMENT '{crossBorder:false, fields:[], maxBytes:...}',
  `authorized_by` VARCHAR(64) NOT NULL COMMENT 'human:employeeId',
  `authorized_at` DATETIME NOT NULL,
  `revoked_at`   DATETIME DEFAULT NULL,
  `trust_score`  DECIMAL(4,3) NOT NULL DEFAULT 0.500,
  PRIMARY KEY (`fed_id`), UNIQUE KEY `uk_fed` (`local_fed_id`,`peer_fed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 联邦任务
CREATE TABLE `harness_fed_task` (
  `fed_task_id`  CHAR(36) NOT NULL,
  `fed_id`       CHAR(36) NOT NULL,
  `contract`     JSON NOT NULL COMMENT '{goal, acceptance, inputs[], outputs[], deadline}',
  `token_ref`    VARCHAR(128) NOT NULL,
  `status`       VARCHAR(16) NOT NULL DEFAULT 'dispatched',
  `deliverable`  JSON DEFAULT NULL,
  `created_at`   DATETIME NOT NULL,
  `completed_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`fed_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------------------------------------
-- §2.6 metering & conversation mirror
-- -------------------------------------------------------------------------------------

CREATE TABLE `harness_usage` (
  `usage_id`   BIGINT NOT NULL AUTO_INCREMENT,
  `agent_id`   CHAR(36) NOT NULL,
  `day`        DATE NOT NULL,
  `tokens_in`  BIGINT NOT NULL DEFAULT 0,
  `tokens_out` BIGINT NOT NULL DEFAULT 0,
  `tool_calls` INT NOT NULL DEFAULT 0,
  `tasks_done` INT NOT NULL DEFAULT 0,
  `tasks_failed` INT NOT NULL DEFAULT 0,
  `cost`       DECIMAL(12,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`usage_id`), KEY `idx_agent_day` (`agent_id`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 对话与消息镜像（portal 为主，harness 保留索引与可检索副本）
CREATE TABLE `harness_conversation` (
  `conv_id`     CHAR(36) NOT NULL,
  `portal_type` VARCHAR(32) NOT NULL COMMENT 'message/session/group',
  `portal_ref`  VARCHAR(64) NOT NULL COMMENT 'message.messageid / groupID',
  `title`       VARCHAR(255) DEFAULT NULL,
  `participants` JSON DEFAULT NULL,
  `last_indexed_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`conv_id`), UNIQUE KEY `uk_ref` (`portal_type`,`portal_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;