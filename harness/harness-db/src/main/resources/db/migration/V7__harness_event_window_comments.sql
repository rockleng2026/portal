-- =====================================================================================
-- harness V7 :: comment corrections (E-01 write-back)
--
-- The fingerprint comment in V1 said "source+key+hash(window)", but the implementation computes
-- sha256(source + businessKey + sha256(canonical(payload))) - the hash is over the *payload*,
-- not over the window. The window is a separate column. Two places describing the same thing
-- differently is how the next person writes the wrong one.
--
-- The window granularity is now written into the design document (03 §2.2):
--   realtime -> 1 minute, nearline -> 1 hour, batch -> 1 day
--
-- Only comments change here: the column types, widths and keys are untouched, so the unique
-- key uk_fp_window and every index are exactly as they were.
-- =====================================================================================

SET NAMES utf8mb4;

ALTER TABLE `harness_event`
  MODIFY COLUMN `fingerprint` VARCHAR(128) NOT NULL
    COMMENT '去重指纹：source+key+hash(payload)（窗口见 event_window）',
  MODIFY COLUMN `event_window` VARCHAR(64) NOT NULL DEFAULT 'none'
    COMMENT '去重时间窗标识：r<分钟桶>/n<小时桶>/b<日桶>（E-01）';
