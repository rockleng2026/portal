package com.fuao.harness.adapter.portal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import org.junit.jupiter.api.Test;

class PermissionStringParserTest {

    @Test
    void parsesAWellFormedPermissionList() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseOperations("workposition.permissions", "351.7,352.1,351.7");

        assertTrue(result.clean());
        assertEquals(List.of("351", "352"), result.functionIds());
        assertEquals(List.of("7"), result.operations().get(351));
        assertEquals(List.of("1"), result.operations().get(352));
    }

    @Test
    void anEmptyPermissionStringIsNotAProblem() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseOperations("workposition.permissions", "");

        assertTrue(result.clean(), "a position with no menu access is legitimate");
        assertTrue(result.operations().isEmpty());
    }

    @Test
    void aNullPermissionStringIsNotAProblem() {
        assertTrue(PermissionStringParser.parseOperations("workposition.permissions", null).clean());
    }

    @Test
    void reportsAnEntryWithoutASubOperation() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseOperations("workposition.permissions", "351,352.1");

        assertFalse(result.clean());
        assertEquals(1, result.problems().size());
        assertEquals("351", result.problems().get(0).rawValue());
        assertTrue(result.problems().get(0).reason().contains("functionID.subID"));
        assertEquals(List.of("352"), result.functionIds(), "the readable entry is still kept");
    }

    @Test
    void reportsANonNumericFunctionId() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseOperations("workposition.permissions", "abc.1");

        assertFalse(result.clean());
        assertTrue(result.problems().get(0).reason().contains("not a number"));
        assertTrue(result.operations().isEmpty());
    }

    @Test
    void reportsAnEmptyEntryBetweenCommas() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseOperations("workposition.permissions", "351.7,,352.1");

        assertFalse(result.clean());
        assertEquals(1, result.problems().size());
        assertEquals(2, result.operations().size());
    }

    @Test
    void parsesFunctionIdLists() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseFunctionIds("workposition.functionIDs", "351,352,351");

        assertTrue(result.clean());
        assertEquals(List.of("351", "352"), result.functionIds());
    }

    @Test
    void reportsBadFunctionIdListEntries() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseFunctionIds("workposition.functionIDs", "351,abc,,352");

        assertFalse(result.clean());
        assertEquals(2, result.problems().size());
        assertEquals(List.of("351", "352"), result.functionIds());
    }

    @Test
    void parsesIdListsAndReportsTheBrokenOnes() {
        List<PermissionStringParser.Problem> problems = new java.util.ArrayList<>();
        List<Integer> ids = PermissionStringParser.parseIdList("user_group_info.groupIDs", "3,4,x,5", problems);

        assertEquals(List.of(3, 4, 5), ids);
        assertEquals(1, problems.size());
        assertEquals("not a numeric id", problems.get(0).reason());
    }

    @Test
    void theJsonFormIsStable() {
        PermissionStringParser.Result result =
                PermissionStringParser.parseOperations("workposition.permissions", "351.7,352.1");
        String json = PermissionStringParser.toJson(result);

        assertTrue(json.contains("\"351\":[\"7\"]"), json);
        assertTrue(json.contains("\"352\":[\"1\"]"), json);
        assertTrue(json.contains("\"problems\":[]"), json);
        assertTrue(json.contains("\"functionIds\":[\"351\",\"352\"]"), json);
    }
}