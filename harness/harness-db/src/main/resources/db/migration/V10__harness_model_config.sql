-- =====================================================================================
-- harness V10 :: the model configuration of a terminal
--
-- A digital employee needs a brain. Which model, and with which key, is a decision the
-- operator makes in the console - not something that has to be typed into a shell on the
-- machine (and certainly not something that belongs in the terminal's own file, which the
-- operator cannot reach).
--
-- So the platform holds the configuration and hands it to the terminal that is bound to the
-- agent. The key is stored encrypted: the platform has to be able to give it back (the
-- terminal has to call the model provider with it), so it cannot be hashed the way a login
-- secret is. Encrypting it at rest with a platform key is the difference between "a key
-- sitting in a table" and "a key sitting in a table".
--
-- Scope: a terminal (the usual case), an agent, or the whole platform. A terminal inherits
-- from its agent, and an agent from the platform, unless it has one of its own.
-- =====================================================================================

SET NAMES utf8mb4;

CREATE TABLE `harness_model_config` (
  `config_id`    CHAR(36) NOT NULL,
  `scope`        VARCHAR(16) NOT NULL DEFAULT 'terminal'
    COMMENT 'terminal/agent/global - 越具体的越优先',
  `scope_id`     VARCHAR(64) NOT NULL DEFAULT '*' COMMENT 'terminal_id / agent_id / *',
  `provider`     VARCHAR(32) NOT NULL DEFAULT 'anthropic' COMMENT 'anthropic/openai',
  `model_name`   VARCHAR(128) NOT NULL DEFAULT 'claude-sonnet-4-5',
  `base_url`     VARCHAR(255) DEFAULT NULL COMMENT '自建/代理网关的地址',
  `api_key_cipher` TEXT NOT NULL COMMENT 'AES-GCM 加密后的密钥（iv+ciphertext+tag）',
  `created_by`   VARCHAR(64) NOT NULL COMMENT 'human:<employeeId>',
  `created_at`   DATETIME NOT NULL,
  `updated_at`   DATETIME NOT NULL,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `uk_scope` (`scope`,`scope_id`),
  KEY `idx_scope` (`scope`,`scope_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
