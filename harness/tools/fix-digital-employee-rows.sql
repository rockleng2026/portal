-- =====================================================================================
-- 数字员工的行：部门与工号
--
-- 之前数字员工是用手写的参数入职的，参数里 deptId 写成了 1（portal 的根部门），
-- 工号写成了业务键（agent:leon:sales:sh001）。两个都不对：
--
--   * 部门是 1 = 集团根部门：它在组织树里不属于任何人，每份人数报表都会把它算成
--     某个人的同事；
--   * 工号是业务键：正常员工的工号是一串数字（地域 + 部门 + 序号），混进一个
--     非数字的工号，任何导入导出都会把它当成脏数据。
--
-- 这份脚本把已经写错的行按新规则修好：
--   * 工号 = AI + 地域码 + 部门码 + 序号（与 portal 侧生成的规则一致）；
--   * 部门 = 数字员工自己的部门。
--
-- 工号里的序号由 portal 自己算（每个部门里 AI 员工的序号），所以这里先向 portal
-- 要答案，再改数据；不要自己编一个序号。
--
-- 用法：
--   mysql -u<user> -p<password> portal20160513 < harness/tools/fix-digital-employee-rows.sql
--
-- 改之前先备份：
--   mysqldump -u<user> -p<password> portal20160513 employee users > /tmp/employee-before.sql
-- =====================================================================================

-- leon：平台上的数字员工 dept_id=91，portal 里旧的行落在根部门 1。
-- 工号按 portal 的规则算出来是 AI0160001（地域 016 + 部门 160 + 序号 001）。
-- uuid 是平台与 portal 之间唯一的关联（平台用它判断「这个数字员工入职了没有」），
-- 早先一次手工测试写成了另一个业务键，这里一并改回。
UPDATE employee
   SET department = 91,
       empNo = 'AI0160001',
       uuid = 'agent:leon:sales:sh001'
 WHERE uuid IN ('agent:leon:portal:sh001', 'agent:leon:sales:sh001')
   AND empNo = 'agent:leon:portal:sh001';

-- 平台侧记的 portal 员工号是旧的一次测试留下的（323），真实的是 326。
-- 这一句跑在 harness 库上：
--   mysql -u<user> -p<password> harness \
--     -e "UPDATE harness_agent SET portal_employee_id = 326, portal_user_id = 293
--          WHERE agent_key = 'agent:leon:sales:sh001' AND portal_employee_id = 323;"
