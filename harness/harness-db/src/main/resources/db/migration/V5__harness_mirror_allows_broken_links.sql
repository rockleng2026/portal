-- =====================================================================================
-- harness V5 :: the organisation mirror has to be able to hold a broken organisation
-- See harness-db/ERRATA.md E-11.
-- =====================================================================================

SET NAMES utf8mb4;

-- An employee without a department is a data problem in the portal, but it is still an employee
-- and the platform has to be able to see it - an AI employee whose department link is broken
-- must not simply disappear from the mirror. The mirror therefore records the fact and the
-- adapter reports it in harness_dirty_queue (A0-8).
ALTER TABLE `harness_org_employee`
  MODIFY COLUMN `dept_id` INT(11) DEFAULT NULL COMMENT '= portal.employee.department; NULL means the portal row has no department';

-- Same reasoning for the position: an employee can carry a position that has since been deleted.
ALTER TABLE `harness_org_employee`
  MODIFY COLUMN `workposition_id` INT(11) DEFAULT NULL COMMENT '= portal.employee.workposition';
