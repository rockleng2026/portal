package com.fuao.harness.adapter.portal;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Mirrors the portal organisation into the harness library.
 *
 * <p>What the sync does, and what it refuses to do:
 * <ul>
 *   <li>departments become {@code harness_org_node} with a materialised path, so a subtree query
 *       is one index lookup instead of a recursive walk;</li>
 *   <li>employees become {@code harness_org_employee};</li>
 *   <li>the permission strings of every position are parsed and bound to capabilities in
 *       {@code harness_cap_binding};</li>
 *   <li>everything that cannot be parsed is parked in {@code harness_dirty_queue} and reported -
 *       never dropped (A0-8).</li>
 * </ul>
 *
 * <p>The sync never writes to the portal. Everything that has to change in the portal goes
 * through the portal's own API, so the portal's validation and caches still apply (ADR-008).
 */
@Service
public class PortalSyncService {

    private static final Logger log = LoggerFactory.getLogger(PortalSyncService.class);

    private final PortalOrgReader reader;
    private final MirrorWriter mirror;
    private final CapabilityResolver capabilities;

    public PortalSyncService(PortalOrgReader reader, MirrorWriter mirror, CapabilityResolver capabilities) {
        this.reader = reader;
        this.mirror = mirror;
        this.capabilities = capabilities;
    }

    /** What one sync run did. */
    public record SyncSummary(
            Instant startedAt,
            Instant finishedAt,
            int departments,
            int employees,
            int positions,
            int bindings,
            int dirtyRecords,
            List<String> warnings) {
    }

    /**
     * Resolves a portal function id to a harness capability.
     *
     * <p>Implemented as an interface because the mapping from "portal menu point" to "harness
     * capability" is a decision an operator has to make, not something the adapter may invent.
     * The default implementation maps a portal function id to the capability whose key encodes
     * it, and reports everything it cannot map.
     */
    public interface CapabilityResolver {

        /**
         * @return the capability id for a portal function id, or {@code null} when the function
         *         point has no harness counterpart
         */
        String resolve(int functionId, String subOperation);

        /** Capabilities that may be bound, keyed by the capability key. */
        Map<String, String> knownCapabilities();
    }

    @Transactional
    public SyncSummary sync() {
        Instant started = Instant.now();
        List<String> warnings = new ArrayList<>();
        int dirty = 0;

        Map<Integer, Integer> depth = new HashMap<>();
        Map<Integer, String> paths = new HashMap<>();

        for (PortalOrgReader.DepartmentRow department : reader.departments()) {
            int level = levelOf(department, depth, paths, warnings);
            mirror.upsertDepartment(department.id(), department.name(), department.parentId(),
                    department.directorId(), department.gradeId(), department.delFlag(), level,
                    paths.get(department.id()), started);
        }

        for (PortalOrgReader.EmployeeRow employee : reader.employees()) {
            boolean isAgent = employee.uuid() != null && employee.uuid().startsWith("agent:");
            mirror.upsertEmployee(employee.id(), employee.uuid(), employee.name(), employee.departmentId(),
                    employee.positionGroupId(), employee.workpositionId(), employee.gradeId(),
                    employee.isLeave(), employee.empNo(), employee.email(), isAgent, started);
            if (employee.departmentId() == null) {
                mirror.reportDirty("adapter", "employee", String.valueOf(employee.id()), "department",
                        null, "employee has no department", "E", started);
                dirty++;
            }
        }

        int bindings = 0;
        for (PortalOrgReader.PositionRow position : reader.positions()) {
            mirror.deleteBindingsFor(position.id(), "position");

            PermissionStringParser.Result operations =
                    PermissionStringParser.parseOperations("workposition.permissions", position.permissions());
            for (PermissionStringParser.Problem problem : operations.problems()) {
                mirror.reportDirty("adapter", "workposition", String.valueOf(position.id()),
                        problem.field(), problem.rawValue(), problem.reason(), "W", started);
                dirty++;
            }

            PermissionStringParser.Result functionIds =
                    PermissionStringParser.parseFunctionIds("workposition.functionIDs", position.functionIds());
            for (PermissionStringParser.Problem problem : functionIds.problems()) {
                mirror.reportDirty("adapter", "workposition", String.valueOf(position.id()),
                        problem.field(), problem.rawValue(), problem.reason(), "W", started);
                dirty++;
            }

            for (Map.Entry<Integer, List<String>> entry : operations.operations().entrySet()) {
                for (String subOperation : entry.getValue()) {
                    String capId = capabilities.resolve(entry.getKey(), subOperation);
                    if (capId == null) {
                        mirror.reportDirty("adapter", "workposition", String.valueOf(position.id()),
                                "capability", entry.getKey() + "." + subOperation,
                                "no harness capability is registered for this portal function point", "W", started);
                        dirty++;
                        continue;
                    }
                    mirror.bindCapability(position.id(), capId, entry.getKey(), subOperation, "position", started);
                    bindings++;
                }
            }
        }

        for (PortalOrgReader.UserRow user : reader.users()) {
            if (user.isAI() != null && user.isAI() == 1) {
                // A digital employee is mirrored like any other employee, but its authority comes
                // from the platform, not from the portal's permission strings.
                continue;
            }
            PortalOrgReader.OverrideRow override = reader.override(user.userId());
            if (override == null) {
                continue;
            }
            PermissionStringParser.Result parsed =
                    PermissionStringParser.parseOperations("role_function_info.permissions", override.permissions());
            for (PermissionStringParser.Problem problem : parsed.problems()) {
                mirror.reportDirty("adapter", "users", String.valueOf(user.userId()),
                        problem.field(), problem.rawValue(), problem.reason(), "W", started);
                dirty++;
            }
        }

        Instant finished = Instant.now();
        log.info("portal sync finished: {} departments, {} employees, {} positions, {} bindings, {} dirty",
                countDepartments(), countEmployees(), countPositions(), bindings, dirty);
        return new SyncSummary(started, finished, countDepartments(), countEmployees(), countPositions(),
                bindings, dirty, warnings);
    }

    private int countDepartments() {
        return reader.departments().size();
    }

    private int countEmployees() {
        return reader.employees().size();
    }

    private int countPositions() {
        return reader.positions().size();
    }

    /**
     * Depth and materialised path of a department.
     *
     * <p>A parent that is not in the table (deleted, or outside the visible set) ends the walk
     * instead of looping forever: the department becomes a root of its own and the problem is
     * reported.
     */
    private int levelOf(PortalOrgReader.DepartmentRow department, Map<Integer, Integer> depth,
                        Map<Integer, String> paths, List<String> warnings) {
        if (depth.containsKey(department.id())) {
            return depth.get(department.id());
        }
        int parentId = department.parentId();
        if (parentId == 0 || parentId == department.id()) {
            depth.put(department.id(), 1);
            paths.put(department.id(), "/" + department.id());
            return 1;
        }
        Integer parentDepth = depth.get(parentId);
        String parentPath = paths.get(parentId);
        if (parentDepth == null || parentPath == null) {
            warnings.add("department " + department.id() + " points at unknown parent " + parentId);
            depth.put(department.id(), 1);
            paths.put(department.id(), "/" + department.id());
            return 1;
        }
        depth.put(department.id(), parentDepth + 1);
        paths.put(department.id(), parentPath + "/" + department.id());
        return parentDepth + 1;
    }

    /** A resolver that maps nothing - the safe default until an operator provides a mapping. */
    public static class EmptyCapabilityResolver implements CapabilityResolver {

        @Override
        public String resolve(int functionId, String subOperation) {
            return null;
        }

        @Override
        public Map<String, String> knownCapabilities() {
            return new LinkedHashMap<>();
        }
    }
}
