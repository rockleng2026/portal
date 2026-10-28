package com.fuao.fajxc.dao.harness;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.util.HarnessJson;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;

/**
 * Portal-side data access for the harness API.
 *
 * <p>Two responsibilities, both narrow on purpose:
 * <ul>
 *   <li>answer "is this login name a digital employee?" so the login path can refuse it (A0-2);</li>
 *   <li>give the platform the permission snapshot and perform the onboarding write (01 ¡ì5.1).</li>
 * </ul>
 *
 * <p>The permission snapshot deliberately returns the <em>raw</em> comma separated strings as
 * well as a parsed view. The platform parses the same strings on its own side (03 ¡ì8) and the two
 * results are compared (A0-3). If they disagree, the disagreement is the finding - which is the
 * whole point of having two independent parsers instead of one shared jar.
 */
public class HarnessAccountDao extends BaseDao {

    private static final Logger logger = Logger.getLogger(HarnessAccountDao.class);
    private static final String SECURITY_MARKER = "[HARNESS-SECURITY]";

    /**
     * @return true when the login name belongs to a digital employee
     */
    public boolean isAiAccount(String loginName) {
        if (loginName == null || loginName.trim().length() == 0) {
            return false;
        }
        try {
            Session session = getSession();
            List list = session.createQuery(
                    "select count(u) from Users u where u.loginName = ? and u.isAI = 1")
                    .setString(0, loginName.trim())
                    .list();
            if (list == null || list.isEmpty()) {
                return false;
            }
            Object count = list.get(0);
            return count instanceof Number && ((Number) count).intValue() > 0;
        } catch (Exception e) {
            // The isAI column is a new addition to the legacy schema. If it has not been applied
            // yet the query fails, and the safe answer is "not an AI account": the AI accounts
            // carry a random sentinel password and therefore still cannot authenticate.
            logger.error(SECURITY_MARKER + " isAI lookup failed (has the users.isAI column been applied?): "
                    + e.getMessage());
            return false;
        }
    }

    /**
     * The permission snapshot of one employee, as the portal computes it.
     *
     * @return a map ready for JSON serialisation
     */
    public Map permissionSnapshot(int employeeId) {
        HarnessJson.HarnessMap result = new HarnessJson.HarnessMap();
        HarnessJson.HarnessList warnings = new HarnessJson.HarnessList();
        Session session = getSession();

        Employee employee = (Employee) session.createQuery("from Employee where id = ?")
                .setInteger(0, employeeId).uniqueResult();
        if (employee == null) {
            result.put("found", Boolean.FALSE);
            result.put("employeeId", Integer.valueOf(employeeId));
            return result;
        }
        result.put("found", Boolean.TRUE);
        result.put("employeeId", employee.getId());
        result.put("name", employee.getName());
        result.put("uuid", employee.getUuid());
        result.put("isLeave", employee.getIsLeave());
        result.put("departmentId", employee.getDepartment() == null ? null : employee.getDepartment().getId());
        result.put("groupId", employee.getGroups() == null ? null : employee.getGroups().getGroupId());
        result.put("workpositionId", employee.getWorkposition() == null ? null : employee.getWorkposition().getId());
        result.put("gradeId", employee.getEmpgrade() == null ? null : employee.getEmpgrade().getId());

        Workposition position = employee.getWorkposition();
        String positionPermissions = position == null ? null : position.getPermissions();
        String positionFunctions = position == null ? null : position.getFunctionIDs();

        Users user = findUserByEmployeeId(session, employeeId);
        String rolePermissions = null;
        String roleFunctions = null;
        String personalPermissions = null;
        String personalFunctions = null;
        String resourcePermission = null;
        List groupIds = new ArrayList();

        if (user != null) {
            result.put("userId", user.getUserId());
            result.put("loginName", user.getLoginName());
            result.put("isAI", user.getIsAI());

            Roles role = user.getRoles();
            if (role != null) {
                result.put("roleId", role.getRoleId());
                rolePermissions = role.getPermissions();
                roleFunctions = role.getFunctionIds();
            }

            List personal = session.createQuery("from RoleFunctionInfo where users.userId = ?")
                    .setInteger(0, user.getUserId()).list();
            if (personal != null && !personal.isEmpty()) {
                com.fuao.fajxc.vo.RoleFunctionInfo rfi = (com.fuao.fajxc.vo.RoleFunctionInfo) personal.get(0);
                personalPermissions = rfi.getPermissions();
                personalFunctions = rfi.getFunctionIds();
                result.put("personalOverride", Boolean.TRUE);
            } else {
                result.put("personalOverride", Boolean.FALSE);
            }

            List groupInfos = session.createQuery("from UserGroupInfo where users.userId = ?")
                    .setInteger(0, user.getUserId()).list();
            if (groupInfos != null && !groupInfos.isEmpty()) {
                com.fuao.fajxc.vo.UserGroupInfo ugi = (com.fuao.fajxc.vo.UserGroupInfo) groupInfos.get(0);
                resourcePermission = ugi.getResourcePermission();
                groupIds = parseIds(ugi.getGroupIds(), "user_group_info.groupIDs", warnings);
            }
        }

        HarnessJson.HarnessMap raw = new HarnessJson.HarnessMap();
        raw.put("positionPermissions", positionPermissions);
        raw.put("positionFunctionIDs", positionFunctions);
        raw.put("rolePermissions", rolePermissions);
        raw.put("roleFunctionIDs", roleFunctions);
        raw.put("personalPermissions", personalPermissions);
        raw.put("personalFunctionIDs", personalFunctions);
        result.put("raw", raw);

        HarnessJson.HarnessMap parsed = new HarnessJson.HarnessMap();
        parsed.put("position", parsePermissions(positionPermissions, "workposition.permissions", warnings));
        parsed.put("role", parsePermissions(rolePermissions, "roles.permissions", warnings));
        parsed.put("personal", parsePermissions(personalPermissions, "role_function_info.permissions", warnings));
        parsed.put("groupIds", groupIds);
        parsed.put("resourcePermission", resourcePermission);
        result.put("parsed", parsed);
        result.put("warnings", warnings);
        return result;
    }

    /**
     * Creates the portal side of a digital employee: the employee row, the login account and the
     * position binding (01 ¡ì5.1, ADR-002).
     *
     * <p>The account gets a random sentinel password and {@code isAI = 1}. The password is never
     * returned and never usable: the login path refuses AI accounts outright (A0-2), and the
     * sentinel is random so that even a bug in that check would not be exploitable.
     */
    public Map onboard(Map command) {
        HarnessJson.HarnessMap result = new HarnessJson.HarnessMap();
        Session session = getSession();

        String agentKey = string(command, "agentKey");
        String name = string(command, "name");
        int deptId = integer(command, "deptId");
        int workpositionId = integer(command, "workpositionId");
        int groupId = integer(command, "groupId");
        int roleId = integer(command, "roleId");
        String loginName = string(command, "loginName");

        if (agentKey == null || name == null || deptId <= 0) {
            result.put("ok", Boolean.FALSE);
            result.put("error", "agentKey, name and deptId are required");
            return result;
        }
        if (loginName == null || loginName.length() == 0) {
            loginName = agentKey;
        }

        List existing = session.createQuery("from Employee where uuid = ?").setString(0, agentKey).list();
        if (existing != null && !existing.isEmpty()) {
            Employee employee = (Employee) existing.get(0);
            result.put("ok", Boolean.TRUE);
            result.put("created", Boolean.FALSE);
            result.put("employeeId", employee.getId());
            result.put("uuid", agentKey);
            return result;
        }

        Employee employee = new Employee();
        employee.setUuid(agentKey);
        employee.setName(name);
        employee.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        employee.setIsLoginAccount(Integer.valueOf(1));
        // 0 = left the company, 1 = employed. The portal's own comment is counter-intuitive and
        // so is this code; see 03 ¡ì8.
        employee.setIsLeave(Integer.valueOf(1));
        employee.setEmpNo(agentKey);
        employee.setDelflag(Integer.valueOf(0));
        Department department = new Department();
        department.setId(Integer.valueOf(deptId));
        employee.setDepartment(department);
        if (groupId > 0) {
            Groups groups = new Groups();
            groups.setGroupId(Integer.valueOf(groupId));
            employee.setGroups(groups);
        }
        if (workpositionId > 0) {
            Workposition position = new Workposition();
            position.setId(Integer.valueOf(workpositionId));
            employee.setWorkposition(position);
        }
        session.save(employee);

        Users user = new Users();
        user.setLoginName(loginName);
        user.setUserName(name);
        user.setPassword(sentinelPassword());
        user.setMark("employee");
        user.setCustomerOrEmployeeId(employee.getId());
        user.setStartTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        user.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        user.setLastLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        user.setCounts(Integer.valueOf(0));
        user.setIpPart("");
        user.setLastIpPart("");
        user.setStatus(Integer.valueOf(0));
        user.setDelflag("0");
        user.setIsAI(Integer.valueOf(1));
        if (roleId > 0) {
            Roles role = new Roles();
            role.setRoleId(Integer.valueOf(roleId));
            user.setRoles(role);
        }
        session.save(user);

        if (workpositionId > 0) {
            WorkpositionEmployee binding = new WorkpositionEmployee();
            binding.setEmployee(employee);
            binding.setWorkposition(employee.getWorkposition());
            binding.setEdittime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            binding.setPositiontype(Integer.valueOf(0));
            session.save(binding);
        }

        session.flush();

        result.put("ok", Boolean.TRUE);
        result.put("created", Boolean.TRUE);
        result.put("employeeId", employee.getId());
        result.put("userId", user.getUserId());
        result.put("uuid", agentKey);
        result.put("loginName", loginName);
        return result;
    }

    private Users findUserByEmployeeId(Session session, int employeeId) {
        List list = session.createQuery("from Users where customerOrEmployeeId = ? and mark = 'employee'")
                .setInteger(0, employeeId).list();
        if (list == null || list.isEmpty()) {
            return null;
        }
        return (Users) list.get(0);
    }

    /**
     * Parses a {@code functionID.subID} list such as {@code "351.7,352.1"}.
     *
     * <p>Every malformed entry produces a warning instead of being dropped: the portal's
     * permission strings are hand-edited comma lists, and silently ignoring a broken entry would
     * quietly widen or narrow somebody's authority (03 ¡ì8).
     */
    public static Map parsePermissions(String raw, String field, List warnings) {
        HarnessJson.HarnessMap parsed = new HarnessJson.HarnessMap();
        if (raw == null) {
            return parsed;
        }
        String trimmed = raw.trim();
        if (trimmed.length() == 0) {
            return parsed;
        }
        String[] parts = trimmed.split(",");
        for (int i = 0; i < parts.length; i++) {
            String part = parts[i].trim();
            if (part.length() == 0) {
                continue;
            }
            int dot = part.indexOf('.');
            if (dot <= 0 || dot == part.length() - 1) {
                warnings.add(field + " entry '" + part + "' is not in functionID.subID form");
                continue;
            }
            String functionId = part.substring(0, dot).trim();
            String subOp = part.substring(dot + 1).trim();
            try {
                Integer.parseInt(functionId);
            } catch (NumberFormatException e) {
                warnings.add(field + " entry '" + part + "' has a non numeric function id");
                continue;
            }
            Object existing = parsed.get(functionId);
            if (existing == null) {
                HarnessJson.HarnessList ops = new HarnessJson.HarnessList();
                ops.append(subOp);
                parsed.put(functionId, ops);
            } else {
                ((HarnessJson.HarnessList) existing).append(subOp);
            }
        }
        return parsed;
    }

    private static List parseIds(String raw, String field, List warnings) {
        List ids = new ArrayList();
        if (raw == null) {
            return ids;
        }
        String[] parts = raw.split(",");
        for (int i = 0; i < parts.length; i++) {
            String part = parts[i].trim();
            if (part.length() == 0) {
                continue;
            }
            try {
                ids.add(Integer.valueOf(part));
            } catch (NumberFormatException e) {
                warnings.add(field + " entry '" + part + "' is not a number");
            }
        }
        return ids;
    }

    private static String sentinelPassword() {
        // 32 hex characters of CSPRNG output. It is not stored anywhere else and never returned.
        byte[] bytes = new byte[16];
        new java.security.SecureRandom().nextBytes(bytes);
        return HarnessHmacHex(bytes);
    }

    private static String HarnessHmacHex(byte[] bytes) {
        char[] out = new char[bytes.length * 2];
        char[] hex = "0123456789abcdef".toCharArray();
        for (int i = 0; i < bytes.length; i++) {
            int v = bytes[i] & 0xFF;
            out[i * 2] = hex[v >>> 4];
            out[i * 2 + 1] = hex[v & 0x0F];
        }
        return new String(out);
    }

    private static String string(Map command, String key) {
        Object value = command.get(key);
        if (value == null) {
            return null;
        }
        String text = String.valueOf(value).trim();
        return text.length() == 0 ? null : text;
    }

    private static int integer(Map command, String key) {
        Object value = command.get(key);
        if (value == null) {
            return 0;
        }
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        try {
            return Integer.parseInt(String.valueOf(value).trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    static Map emptyMap() {
        return new HashMap();
    }
}