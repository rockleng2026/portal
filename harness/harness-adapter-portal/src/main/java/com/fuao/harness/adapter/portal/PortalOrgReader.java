package com.fuao.harness.adapter.portal;

import java.util.List;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/**
 * Reads the organisation out of the portal database.
 *
 * <p>Only SELECTs, always parameterised (03 §8.1: the legacy portal is full of concatenated SQL
 * and the adapter must not copy that habit). The column lists are spelled out rather than
 * selected with {@code *}: a column added to the portal years from now must not silently change
 * the meaning of a row.
 */
@Repository
public class PortalOrgReader {

    private final JdbcClient portal;

    public PortalOrgReader(@Qualifier("portalJdbc") JdbcClient portalJdbc) {
        this.portal = portalJdbc;
    }

    public record DepartmentRow(int id, String name, int parentId, Integer directorId, Integer gradeId,
                                Integer delFlag) {
    }

    public record EmployeeRow(int id, String uuid, String name, Integer departmentId, Integer positionGroupId,
                              Integer workpositionId, Integer gradeId, Integer isLeave, String empNo,
                              String email, Integer isLoginAccount) {
    }

    public record PositionRow(int id, String name, Integer deptId, String workcontent, String functionIds,
                              String permissions, Integer ispersonman, String edittime) {
    }

    public record UserRow(int userId, String loginName, String userName, Integer roleId,
                           Integer employeeId, Integer isAI) {
    }

    public List<DepartmentRow> departments() {
        return portal.sql("""
                        SELECT id, name, parentId, directorId, gradeid, delflag
                          FROM department
                         ORDER BY id
                        """)
                .query((rs, i) -> new DepartmentRow(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("parentId"),
                        (Integer) rs.getObject("directorId"),
                        (Integer) rs.getObject("gradeid"),
                        (Integer) rs.getObject("delflag")))
                .list();
    }

    public List<EmployeeRow> employees() {
        return portal.sql("""
                        SELECT id, uuid, name, department, position, workposition, gradeid, isLeave, empNo,
                               email, isLoginAccount
                          FROM employee
                         ORDER BY id
                        """)
                .query((rs, i) -> new EmployeeRow(
                        rs.getInt("id"),
                        rs.getString("uuid"),
                        rs.getString("name"),
                        (Integer) rs.getObject("department"),
                        (Integer) rs.getObject("position"),
                        (Integer) rs.getObject("workposition"),
                        (Integer) rs.getObject("gradeid"),
                        (Integer) rs.getObject("isLeave"),
                        rs.getString("empNo"),
                        rs.getString("email"),
                        (Integer) rs.getObject("isLoginAccount")))
                .list();
    }

    public List<PositionRow> positions() {
        return portal.sql("""
                        SELECT id, name, deptid, workcontent, functionIDs, permissions, ispersonman, edittime
                          FROM workposition
                         ORDER BY id
                        """)
                .query((rs, i) -> new PositionRow(
                        rs.getInt("id"),
                        rs.getString("name"),
                        (Integer) rs.getObject("deptid"),
                        rs.getString("workcontent"),
                        rs.getString("functionIDs"),
                        rs.getString("permissions"),
                        (Integer) rs.getObject("ispersonman"),
                        rs.getString("edittime")))
                .list();
    }

    public List<UserRow> users() {
        return portal.sql("""
                        SELECT UserID, loginName, userName, RoleID, CustomerOrEmployeeId, isAI
                          FROM users
                         WHERE delflag = 0
                         ORDER BY UserID
                        """)
                .query((rs, i) -> new UserRow(
                        rs.getInt("UserID"),
                        rs.getString("loginName"),
                        rs.getString("userName"),
                        (Integer) rs.getObject("RoleID"),
                        (Integer) rs.getObject("CustomerOrEmployeeId"),
                        (Integer) rs.getObject("isAI")))
                .list();
    }

    /** The resource visibility scope of one user, from {@code user_group_info}. */
    public GroupRow groupInfo(int userId) {
        return portal.sql("""
                        SELECT groupIds, supergroupIds, resourcePermission
                          FROM user_group_info
                         WHERE userId = :userId
                        """)
                .param("userId", userId)
                .query((rs, i) -> new GroupRow(
                        rs.getString("groupIds"),
                        rs.getString("supergroupIds"),
                        rs.getString("resourcePermission")))
                .optional()
                .orElse(null);
    }

    public record GroupRow(String groupIds, String supergroupIds, String resourcePermission) {
    }

    /** The personal permission override of one user, from {@code role_function_info}. */
    public OverrideRow override(int userId) {
        return portal.sql("""
                        SELECT functionIDs, permissions
                          FROM role_function_info
                         WHERE userId = :userId
                        """)
                .param("userId", userId)
                .query((rs, i) -> new OverrideRow(rs.getString("functionIDs"), rs.getString("permissions")))
                .optional()
                .orElse(null);
    }

    public record OverrideRow(String functionIds, String permissions) {
    }
}
