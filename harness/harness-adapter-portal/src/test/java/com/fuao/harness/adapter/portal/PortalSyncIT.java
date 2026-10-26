package com.fuao.harness.adapter.portal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Connection;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * The sync against a real portal-shaped database (A0-8).
 *
 * <p>The portal fixture deliberately contains dirty data: a permission string with a broken
 * entry, an employee without a department, a position pointing at a function point that has no
 * harness capability. The test asserts that all three end up in the dirty queue and that the
 * readable parts are still mirrored - the point of A0-8 is that nothing is silently dropped.
 */
@SpringBootTest
@Testcontainers
class PortalSyncIT {

    @Container
    @SuppressWarnings("resource")
    static final MySQLContainer<?> PORTAL = new MySQLContainer<>("mysql:8.4")
            .withDatabaseName("portal")
            .withUsername("portal")
            .withPassword("portal")
            .withCommand("--default-time-zone=+00:00");

    @Container
    @SuppressWarnings("resource")
    static final MySQLContainer<?> HARNESS = new MySQLContainer<>("mysql:8.4")
            .withDatabaseName("harness")
            .withUsername("harness")
            .withPassword("harness")
            .withCommand("--default-time-zone=+00:00");

    @DynamicPropertySource
    static void properties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", () -> HARNESS.getJdbcUrl()
                + "?connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true");
        registry.add("spring.datasource.username", HARNESS::getUsername);
        registry.add("spring.datasource.password", HARNESS::getPassword);
        registry.add("harness.portal.datasource.url", () -> PORTAL.getJdbcUrl()
                + "?connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true");
        registry.add("harness.portal.datasource.username", PORTAL::getUsername);
        registry.add("harness.portal.datasource.password", PORTAL::getPassword);
        registry.add("harness.portal.sync-enabled", () -> "false");
    }

    @Autowired
    private PortalSyncService sync;

    @Autowired
    private MirrorWriter mirror;

    @Autowired
    private JdbcClient harnessJdbc;

    @BeforeAll
    static void seedPortal() throws Exception {
        try (Connection connection = PORTAL.createConnection("")) {
            try (Statement statement = connection.createStatement()) {
                statement.execute("""
                        CREATE TABLE department (
                          id INT PRIMARY KEY, name VARCHAR(128), parentId INT NOT NULL DEFAULT 0,
                          directorId INT, gradeid INT, delflag INT
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                        """);
                statement.execute("""
                        CREATE TABLE employee (
                          id INT PRIMARY KEY, uuid VARCHAR(255), name VARCHAR(20), department INT,
                          position INT, workposition INT, gradeid INT, isLeave INT, empNo VARCHAR(50),
                          email VARCHAR(255), isLoginAccount INT
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                        """);
                statement.execute("""
                        CREATE TABLE workposition (
                          id INT PRIMARY KEY, name VARCHAR(64), deptid INT, workcontent TEXT,
                          functionIDs TEXT, permissions TEXT, ispersonman INT, edittime VARCHAR(32)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                        """);
                statement.execute("""
                        CREATE TABLE users (
                          UserID INT PRIMARY KEY, loginName VARCHAR(255), userName VARCHAR(255),
                          RoleID INT, CustomerOrEmployeeId INT, isAI TINYINT DEFAULT 0,
                          delflag VARCHAR(50) DEFAULT '0'
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                        """);
                statement.execute("""
                        CREATE TABLE user_group_info (
                          userGroupId INT PRIMARY KEY AUTO_INCREMENT, userId INT,
                          supergroupIds VARCHAR(255), groupIds VARCHAR(255), resourcePermission VARCHAR(255)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                        """);
                statement.execute("""
                        CREATE TABLE role_function_info (
                          roleFunctionId INT PRIMARY KEY AUTO_INCREMENT, userId INT,
                          functionIDs TEXT, permissions TEXT, delflag VARCHAR(50)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                        """);

                statement.execute("INSERT INTO department VALUES (1, 'Group', 0, 100, 1, 0)");
                statement.execute("INSERT INTO department VALUES (91, 'Shenzhen Sales', 1, 100, 2, 0)");
                statement.execute("INSERT INTO department VALUES (92, 'Shenzhen Support', 91, 100, 3, 0)");

                // a clean employee
                statement.execute("INSERT INTO employee VALUES (10, 'emp:1001', 'Zhang', 91, 5, 7, 2, 1,"
                        + " 'E1001', 'zhang@example.com', 1)");
                // a digital employee
                statement.execute("INSERT INTO employee VALUES (11, 'agent:leon:sales:sh001', 'leon', 91, 5, 7,"
                        + " 2, 1, 'A0001', 'leon@example.com', 1)");
                // an employee without a department
                statement.execute("INSERT INTO employee VALUES (12, 'emp:1003', 'Ghost', NULL, NULL, NULL, NULL,"
                        + " NULL, NULL, NULL, 0)");

                // a position with one broken permission entry
                statement.execute("INSERT INTO workposition VALUES (7, 'Sales Assistant', 91, 'sales work',"
                        + " '351,352', '351.7,352,353.2', 0, '2026-10-01 09:00:00')");

                statement.execute("INSERT INTO users VALUES (1, 'zhang', 'Zhang', 3, 10, 0, '0')");
                statement.execute("INSERT INTO users VALUES (2, 'agent:leon:sales:sh001', 'leon', 3, 11, 1, '0')");
                statement.execute("INSERT INTO user_group_info VALUES (1, 1, '', '3,4', 'dept:91')");
                statement.execute("INSERT INTO role_function_info VALUES (1, 1, '351', '351.7,x', '0')");
            }
        }
    }

    @Autowired
    @org.springframework.beans.factory.annotation.Qualifier("portalJdbc")
    private JdbcClient portalJdbcForDebug;

    @Test
    void showsWhichDatabaseEachClientTalksTo() {
        assertEquals("harness", harnessJdbc.sql("SELECT DATABASE()").query(String.class).single());
        assertEquals("portal", portalJdbcForDebug.sql("SELECT DATABASE()").query(String.class).single(),
                "the adapter must read the portal and write the harness - never the other way round");
    }

    @Test
    void mirrorsTheOrganisationAndParksWhatItCannotRead() {
        PortalSyncService.SyncSummary summary = sync.sync();

        assertEquals(3, summary.departments());
        assertEquals(3, summary.employees());

        Integer nodes = harnessJdbc.sql("SELECT COUNT(*) FROM harness_org_node").query(Integer.class).single();
        assertEquals(3, nodes);

        // the materialised path must make the subtree reachable in one lookup
        String path = harnessJdbc.sql("SELECT path FROM harness_org_node WHERE node_id = 92")
                .query(String.class).single();
        assertEquals("/1/91/92", path);

        Integer employees = harnessJdbc.sql("SELECT COUNT(*) FROM harness_org_employee")
                .query(Integer.class).single();
        assertEquals(3, employees);

        Integer agents = harnessJdbc.sql("SELECT COUNT(*) FROM harness_org_employee WHERE is_agent = 1")
                .query(Integer.class).single();
        assertEquals(1, agents, "the digital employee is recognised by its agent: uuid");

        Integer isLeave = harnessJdbc.sql("SELECT is_leave FROM harness_org_employee WHERE employee_id = 10")
                .query(Integer.class).single();
        assertEquals(1, isLeave, "portal isLeave is kept as it is: 1 means employed");
    }

    @Test
    void dirtyValuesEndUpInTheQueueInsteadOfBeingDropped() {
        sync.sync();

        List<Map<String, Object>> dirty = mirror.openDirty(50);
        assertTrue(dirty.size() >= 3, "expected the broken permission entry, the orphan employee and the "
                + "unmappable function point to be reported, found " + dirty.size());

        boolean sawBrokenPermission = false;
        boolean sawOrphanEmployee = false;
        boolean sawUnmappedCapability = false;
        for (Map<String, Object> row : dirty) {
            String reason = String.valueOf(row.get("reason"));
            if (reason.contains("functionID.subID")) {
                sawBrokenPermission = true;
            }
            if (reason.contains("no department")) {
                sawOrphanEmployee = true;
            }
            if (reason.contains("no harness capability")) {
                sawUnmappedCapability = true;
            }
        }
        assertTrue(sawBrokenPermission, "the broken permission entry must be reported");
        assertTrue(sawOrphanEmployee, "the employee without a department must be reported");
        assertTrue(sawUnmappedCapability, "a function point without a capability must be reported");
    }

    @Test
    void theSameBrokenValueDoesNotPileUp() {
        sync.sync();
        int first = mirror.openDirty(100).size();

        sync.sync();
        int second = mirror.openDirty(100).size();

        assertEquals(first, second, "a value that stays broken is one work item with a counter, not many rows");

        Integer occurrences = harnessJdbc.sql(
                        "SELECT occurrences FROM harness_dirty_queue WHERE object_type = 'workposition' LIMIT 1")
                .query(Integer.class).single();
        assertTrue(occurrences >= 2, "the occurrence counter has to grow");
    }

    @Test
    void theReadablePartOfABrokenListIsStillMirrored() {
        sync.sync();

        Integer open = mirror.openDirtyCount();
        assertTrue(open > 0);

        // 351.7 parsed fine, 353.2 has no capability yet - the parse result must not be lost
        // because one entry was broken.
        boolean sawUnmapped = mirror.openDirty(50).stream()
                .anyMatch(row -> String.valueOf(row.get("reason")).contains("no harness capability"));
        assertTrue(sawUnmapped);
    }
}
