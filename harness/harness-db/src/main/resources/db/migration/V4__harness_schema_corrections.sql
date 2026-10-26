-- =====================================================================================
-- harness V4 :: corrections to frozen columns that are too narrow for their own contract
-- See harness-db/ERRATA.md E-08 .. E-10.
--
-- This migration exists instead of editing V1 so that databases which already ran V1/V2/V3
-- converge on the same schema as a fresh install.
-- =====================================================================================

SET NAMES utf8mb4;

-- E-09: content_trust VARCHAR(8) cannot store 'untrusted' (9 characters).
-- The column's own comment lists both values, so the DDL contradicted the contract; widening is
-- the only fix that keeps the declared vocabulary readable.
ALTER TABLE `harness_event`
  MODIFY COLUMN `content_trust` VARCHAR(16) NOT NULL DEFAULT 'trusted'
    COMMENT 'trusted/untrusted - instruction-injection defence (03 §4)';

-- E-10: reason / reason_code are bounded. The platform truncates before writing rather than
-- failing an audit insert, because losing the record of a decision during an incident is worse
-- than losing the tail of its explanation.
ALTER TABLE `harness_audit`
  MODIFY COLUMN `reason` VARCHAR(1024) DEFAULT NULL COMMENT 'human-readable explanation (truncated by the writer)';

ALTER TABLE `harness_approval`
  MODIFY COLUMN `decision_note` VARCHAR(1024) DEFAULT NULL COMMENT 'approver note (truncated by the writer)';