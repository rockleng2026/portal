-- =====================================================================================
-- harness V6 :: corrections found during the M0 acceptance review
--
-- E-12  harness_capability.blast_radius is TINYINT (max 127) but the column is documented as
--        "影响半径估计（对象数）" - an object count. The seed data writes 1000 for cap:db.ddl,
--        which MySQL truncates to 127 (and warns about). The column type is corrected to INT.
--
-- E-13  harness_principal.principal_type said "service/agent/terminal/console", but the code
--        gates every human-only endpoint on the type being 'human'. A machine principal that
--        merely carries an employee_id would otherwise pass the gate. The vocabulary is fixed
--        and the role/department of a human principal are added, so that the approver can be
--        the responsible person and not "anybody with a console" (red-team R-02).
--
-- E-14  harness_approval has no place to record the *individual* signatures of a dual
--        approval (L4 / destructive). The row stayed PENDING after the first signature, so a
--        single human could approve a production DDL. harness_approval_signoff records every
--        signature separately; the row only becomes APPROVED once two distinct humans signed.
--
-- E-15  harness_principal.api_scope defaults to '/api/harness/*'. The default stays (a
--        principal that is created without a scope still needs one), but the meaning is
--        documented as a path prefix and the default is now explicitly noted as "every
--        endpoint" rather than a silent wildcard.
-- =====================================================================================

SET NAMES utf8mb4;

-- E-12 -----------------------------------------------------------------------------
ALTER TABLE `harness_capability`
  MODIFY COLUMN `blast_radius` INT NOT NULL DEFAULT 1 COMMENT '影响半径估计（对象数）';

-- The seed data was written while the column was still TINYINT, so MySQL truncated 1000 to 127
-- (INSERT IGNORE turned the error into a warning). The column can hold the value now, so the
-- seed is restored to the radius it was meant to have.
UPDATE `harness_capability` SET `blast_radius` = 1000 WHERE `cap_key` = 'cap:db.ddl';

-- E-13 -----------------------------------------------------------------------------
ALTER TABLE `harness_principal`
  MODIFY COLUMN `principal_type` VARCHAR(16) NOT NULL
    COMMENT 'human/service/agent/terminal - 决定该账号能否通过“自然人”闸门',
  ADD COLUMN `role` VARCHAR(32) NOT NULL DEFAULT 'employee'
    COMMENT 'human 账号的职责：employee/dept_director/system_admin（审批层级依据）',
  ADD COLUMN `dept_id` INT(11) DEFAULT NULL
    COMMENT 'human 账号所属部门；部门主管只能审批本部门的提权';

-- E-14 -----------------------------------------------------------------------------
CREATE TABLE `harness_approval_signoff` (
  `signoff_id`   CHAR(36) NOT NULL,
  `approval_id`  CHAR(36) NOT NULL,
  `employee_id`  INT(11) NOT NULL COMMENT '签字的自然人 portal.employee.id',
  `decided_at`   DATETIME NOT NULL,
  `note`         VARCHAR(1024) DEFAULT NULL,
  `created_at`   DATETIME NOT NULL,
  PRIMARY KEY (`signoff_id`),
  UNIQUE KEY `uk_approval_employee` (`approval_id`,`employee_id`),
  KEY `idx_approval` (`approval_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
