package com.fuao.harness.adapter.portal;

import com.fuao.harness.protocol.json.Json;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * Parses the portal's permission strings.
 *
 * <p>The portal stores authority as hand-edited comma lists: {@code workposition.permissions}
 * looks like {@code "351.7,352.1"} and {@code functionIDs} like {@code "351,352"} (03 §2.1,
 * 03 §8). There is no schema, no validation and no foreign key behind them, so every one of them
 * is a potential source of quietly wrong authority.
 *
 * <p>Two rules decide what this parser does with a broken entry:
 * <ul>
 *   <li>an entry that cannot be understood is <b>reported</b>, never dropped - a dropped entry
 *       narrows somebody's authority and nobody would notice;</li>
 *   <li>an entry that <em>is</em> understood is kept even if it looks odd, because the portal's
 *       permission model is not ours to reinterpret (03 §8).</li>
 * </ul>
 *
 * <p>This parser is deliberately an independent implementation of the same rules the portal side
 * uses. Acceptance item A0-3 compares the two results; if they ever disagree, the disagreement
 * is the finding.
 */
public final class PermissionStringParser {

    /** One reported problem. */
    public record Problem(String field, String rawValue, String reason) {
    }

    /** The parse result: what was understood, and what was not. */
    public record Result(Map<Integer, List<String>> operations,
                          List<String> functionIds,
                          List<Problem> problems) {

        public boolean clean() {
            return problems.isEmpty();
        }
    }

    private PermissionStringParser() {
    }

    /**
     * Parses a {@code functionID.subID} list.
     *
     * @param field the column the value came from, used in the problem reports
     */
    public static Result parseOperations(String field, String raw) {
        Map<Integer, List<String>> operations = new TreeMap<>();
        List<String> functionIds = new ArrayList<>();
        List<Problem> problems = new ArrayList<>();

        if (raw == null) {
            return new Result(operations, functionIds, problems);
        }
        String trimmed = raw.trim();
        if (trimmed.isEmpty()) {
            // An empty permission string is legitimate: a position with no menu access at all.
            return new Result(operations, functionIds, problems);
        }

        String[] parts = trimmed.split(",");
        for (String part : parts) {
            String entry = part.trim();
            if (entry.isEmpty()) {
                problems.add(new Problem(field, raw, "empty entry between commas"));
                continue;
            }
            int dot = entry.indexOf('.');
            if (dot <= 0 || dot == entry.length() - 1) {
                problems.add(new Problem(field, entry, "not in functionID.subID form"));
                continue;
            }
            String functionId = entry.substring(0, dot).trim();
            String subOperation = entry.substring(dot + 1).trim();
            int parsedId;
            try {
                parsedId = Integer.parseInt(functionId);
            } catch (NumberFormatException e) {
                problems.add(new Problem(field, entry, "function id '" + functionId + "' is not a number"));
                continue;
            }
            if (subOperation.isEmpty()) {
                problems.add(new Problem(field, entry, "no sub operation after the dot"));
                continue;
            }
            if (!functionIds.contains(String.valueOf(parsedId))) {
                functionIds.add(String.valueOf(parsedId));
            }
            List<String> ops = operations.computeIfAbsent(parsedId, k -> new ArrayList<>());
            if (!ops.contains(subOperation)) {
                ops.add(subOperation);
            }
        }
        return new Result(operations, functionIds, problems);
    }

    /**
     * Parses a {@code functionIDs} list: plain ids, comma separated.
     */
    public static Result parseFunctionIds(String field, String raw) {
        Map<Integer, List<String>> operations = new TreeMap<>();
        List<String> functionIds = new ArrayList<>();
        List<Problem> problems = new ArrayList<>();

        if (raw == null) {
            return new Result(operations, functionIds, problems);
        }
        String trimmed = raw.trim();
        if (trimmed.isEmpty()) {
            return new Result(operations, functionIds, problems);
        }
        for (String part : trimmed.split(",")) {
            String entry = part.trim();
            if (entry.isEmpty()) {
                problems.add(new Problem(field, raw, "empty entry between commas"));
                continue;
            }
            try {
                Integer.parseInt(entry);
            } catch (NumberFormatException e) {
                problems.add(new Problem(field, entry, "not a numeric function id"));
                continue;
            }
            if (!functionIds.contains(entry)) {
                functionIds.add(entry);
            }
        }
        return new Result(operations, functionIds, problems);
    }

    /** Parses a comma separated id list such as {@code user_group_info.groupIDs}. */
    public static List<Integer> parseIdList(String field, String raw, List<Problem> problems) {
        List<Integer> ids = new ArrayList<>();
        if (raw == null) {
            return ids;
        }
        String trimmed = raw.trim();
        if (trimmed.isEmpty()) {
            return ids;
        }
        for (String part : trimmed.split(",")) {
            String entry = part.trim();
            if (entry.isEmpty()) {
                problems.add(new Problem(field, raw, "empty entry between commas"));
                continue;
            }
            try {
                int id = Integer.parseInt(entry);
                if (!ids.contains(id)) {
                    ids.add(id);
                }
            } catch (NumberFormatException e) {
                problems.add(new Problem(field, entry, "not a numeric id"));
            }
        }
        return ids;
    }

    /** The parsed shape as JSON, for the comparison in A0-3. */
    public static String toJson(Result result) {
        Map<String, Object> out = new LinkedHashMap<>();
        Map<String, Object> ops = new LinkedHashMap<>();
        result.operations().forEach((functionId, subOperations) -> ops.put(String.valueOf(functionId), subOperations));
        out.put("operations", ops);
        out.put("functionIds", result.functionIds());
        List<Object> problems = new ArrayList<>();
        for (Problem problem : result.problems()) {
            Map<String, Object> p = new LinkedHashMap<>();
            p.put("field", problem.field());
            p.put("rawValue", problem.rawValue());
            p.put("reason", problem.reason());
            problems.add(p);
        }
        out.put("problems", problems);
        return Json.canonical(out);
    }
}