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
 *   <li>give the platform the permission snapshot and perform the onboarding write (01 ��5.1).</li>
 * </ul>
 *
 * <p>The permission snapshot deliberately returns the <em>raw</em> comma separated strings as
 * well as a parsed view. The platform parses the same strings on its own side (03 ��8) and the two
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
     * position binding (01 ��5.1, ADR-002).
     *
     * <p>The account gets a random sentinel password and {@code isAI = 1}. The password is never
     * returned and never usable: the login path refuses AI accounts outright (A0-2), and the
     * sentinel is random so that even a bug in that check would not be exploitable.
     */
    /**
     * What hiring this digital employee would write - and nothing more.
     *
     * <p>The employee number is decided here, because the portal owns the department codes
     * and the sequence. The platform asks before it writes, so the operator sees the number
     * the employee will really carry instead of a guess.
     */
    public Map onboardPreview(Map command) {
        HarnessJson.HarnessMap result = new HarnessJson.HarnessMap();
        Session session = getSession();
        String agentKey = string(command, "agentKey");
        int deptId = integer(command, "deptId");

        if (agentKey == null || deptId <= 0) {
            result.put("ok", Boolean.FALSE);
            result.put("error", "agentKey and deptId are required");
            return result;
        }
        Department target = (Department) session.createQuery("from Department where id = ?")
                .setInteger(0, Integer.valueOf(deptId)).uniqueResult();
        if (target == null) {
            result.put("ok", Boolean.FALSE);
            result.put("error", "no such department: " + deptId);
            return result;
        }
        result.put("ok", Boolean.TRUE);
        result.put("deptId", Integer.valueOf(deptId));
        result.put("deptName", target.getName());
        result.put("employeeNumber", digitalEmployeeNo(session, target, agentKey));
        result.put("employeeNumberRule", "AI + 地域码 + 部门码 + 序号（与正常员工的纯数字工号区分）");
        return result;
    }

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

        // The department has to exist. Writing a row that points at a department nobody has is
        // how a digital employee ends up in the root department and shows up in every org
        // report as if it were nobody's colleague.
        Department target = (Department) session.createQuery("from Department where id = ?")
                .setInteger(0, Integer.valueOf(deptId)).uniqueResult();
        if (target == null) {
            result.put("ok", Boolean.FALSE);
            result.put("error", "no such department: " + deptId);
            return result;
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

        // One transaction for both rows. An employee row without its login account is a
        // half-created digital employee: it shows up in the org tree and cannot be reached.
        org.hibernate.Transaction transaction = session.beginTransaction();
        try {
        Employee employee = new Employee();
        employee.setUuid(agentKey);
        employee.setName(name);
        employee.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        employee.setIsLoginAccount(Integer.valueOf(1));
        // 0 = left the company, 1 = employed. The portal's own comment is counter-intuitive and
        // so is this code; see 03 ��8.
        employee.setIsLeave(Integer.valueOf(1));
        // The employee number. A normal employee's number is a string of digits - region,
        // department, sequence - and a digital employee must never be mistaken for one, so it
        // gets a prefix: the number is recognisable at a glance in every list, and no import
        // can read it as a colleague's number.
        employee.setEmpNo(digitalEmployeeNo(session, target, agentKey));
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
        if (roleId <= 0) {
            // The portal's user row has a NOT NULL role column, so a digital employee without
            // a role cannot be created at all. It cannot log in anyway (A0-2), so the role
            // only has to be the most limited one there is.
            roleId = digitalRoleId();
        }
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
        transaction.commit();

        result.put("ok", Boolean.TRUE);
        result.put("created", Boolean.TRUE);
        result.put("employeeId", employee.getId());
        result.put("userId", user.getUserId());
        result.put("uuid", agentKey);
        result.put("loginName", loginName);
        result.put("employeeNumber", employee.getEmpNo());
        result.put("deptId", Integer.valueOf(deptId));
        return result;
        } catch (RuntimeException e) {
            try {
                transaction.rollback();
            } catch (Exception ignored) {
                // The original failure is the interesting one.
            }
            throw e;
        }
    }

    /**
     * The role a digital employee gets when the caller does not name one.
     *
     * <p>Read from the harness configuration ({@code harness.api.digitalRoleId}).
     */
    private int digitalRoleId() {
        try {
            java.io.InputStream in = getClass().getResourceAsStream("/WEB-INF/props/harness-api.properties");
            if (in == null) {
                return 0;
            }
            try {
                java.util.Properties properties = new java.util.Properties();
                properties.load(in);
                String value = properties.getProperty("harness.api.digitalRoleId", "");
                return Integer.parseInt(value.trim());
            } finally {
                in.close();
            }
        } catch (Exception e) {
            logger.error("cannot read harness.api.digitalRoleId", e);
            return 0;
        }
    }

    /**
     * The employee number of a digital employee.
     *
     * <p>Shape: the prefix, then the region code, then the department code, then the sequence
     * inside that department - the same pieces a normal employee's number is made of, so the
     * two sorts of number can be read the same way, with the prefix telling them apart.
     *
     * <p>The sequence counts the digital employees already in that department, so the number
     * is stable and readable: "AI" + 11 + 05 + 003 is the third digital employee of
     * department 11.05 in region 11.
     */
    private String digitalEmployeeNo(Session session, Department department, String agentKey) {
        String region = regionCode(session, department);
        String dept = digitsOf(department.getDepNo());
        if (dept.length() == 0) {
            dept = String.valueOf(department.getId());
        }
        // The count comes back as a Long on MySQL and as an Integer elsewhere, so it is read
        // as a Number rather than cast to one of them.
        Number count = (Number) session.createQuery(
                        "select count(*) from Users u, Employee e"
                                + " where u.customerOrEmployeeId = e.id and u.isAI = 1"
                                + " and e.department.id = ?")
                .setInteger(0, department.getId()).uniqueResult();
        int sequence = (count == null ? 0 : count.intValue()) + 1;
        String number = "AI" + region + dept + pad(sequence, 3);
        // Two digital employees must never share a number.
        if (employeeNoTaken(session, number)) {
            number = number + "-" + Math.abs(agentKey.hashCode() % 1000);
        }
        return number;
    }

    /**
     * The region code: the topmost department above this one, if it has a numeric code.
     *
     * <p>The region is the root of the department tree. The portal keeps the parent as an id
     * only, so the chain is walked one query at a time.
     */
    private String regionCode(Session session, Department department) {
        Integer currentId = department.getId();
        int guard = 0;
        while (guard++ < 16) {
            Department current = (Department) session.createQuery("from Department where id = ?")
                    .setInteger(0, currentId).uniqueResult();
            if (current == null || current.getParentId() == null) {
                String code = current == null ? "" : digitsOf(current.getDepNo());
                return code.length() == 0 ? "0" : code;
            }
            currentId = current.getParentId();
        }
        return "0";
    }

    /** Keeps the digits of a code and drops everything else. */
    private String digitsOf(String code) {
        if (code == null) {
            return "";
        }
        StringBuilder text = new StringBuilder();
        for (int i = 0; i < code.length(); i++) {
            char c = code.charAt(i);
            if (c >= '0' && c <= '9') {
                text.append(c);
            }
        }
        return text.toString();
    }

    /** A sequence with leading zeros. */
    private String pad(int value, int width) {
        String text = String.valueOf(value);
        StringBuilder padded = new StringBuilder();
        for (int i = text.length(); i < width; i++) {
            padded.append('0');
        }
        return padded.append(text).toString();
    }

    /** Is this employee number already taken by somebody else? */
    private boolean employeeNoTaken(Session session, String empNo) {
        List existing = session.createQuery("from Employee where empNo = ?").setString(0, empNo).list();
        return existing != null && !existing.isEmpty();
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
     * quietly widen or narrow somebody's authority (03 ��8).
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