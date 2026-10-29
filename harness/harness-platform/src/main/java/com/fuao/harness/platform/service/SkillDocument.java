package com.fuao.harness.platform.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * A SKILL.md document, parsed the way the terminal parses it.
 *
 * <p>The terminal loads a skill from a directory that holds a {@code SKILL.md}: a frontmatter
 * block with a {@code name} and a {@code description}, then the instructions. The terminal's
 * parser is strict - a skill whose frontmatter is broken is <em>reported</em>, not skipped -
 * because a skill that cannot be read is a skill that silently does nothing.
 *
 * <p>The platform therefore parses it with the same rules. If the platform accepted a document
 * the terminal would reject, the skill would be published, installed and then ignored on every
 * machine, which is the worst possible failure: it looks like it works.
 *
 * <p>The structured fields of the frozen {@code definition} column are read out of the same
 * document: {@code tools}, {@code preconditions} and {@code postconditions} are comma-separated
 * frontmatter values, and the numbered lines of the body are the {@code steps}.
 */
public record SkillDocument(
        String name,
        String description,
        String instructions,
        Map<String, String> frontmatter,
        List<String> steps,
        List<String> tools,
        List<String> preconditions,
        List<String> postconditions) {

    /** A numbered line in the body: "1. run the tests". */
    private static final Pattern NUMBERED = Pattern.compile("^\\s*\\d+[.)]\\s+(.*)$");

    /** Raised when the document is not a skill the terminal could load. */
    public static class MalformedSkillException extends RuntimeException {
        public MalformedSkillException(String message) {
            super(message);
        }
    }

    /**
     * Parses a SKILL.md.
     *
     * @throws MalformedSkillException when the document has no frontmatter or no name - the two
     *                                 things the terminal refuses to load without
     */
    public static SkillDocument parse(String content) {
        if (content == null || content.isBlank()) {
            throw new MalformedSkillException("the skill has no content");
        }
        String trimmed = content.stripLeading();
        if (!trimmed.startsWith("---")) {
            throw new MalformedSkillException("the skill has no frontmatter: a SKILL.md starts with ---");
        }
        String rest = trimmed.replaceFirst("^-{3,}", "");
        int end = rest.indexOf("\n---");
        if (end < 0) {
            throw new MalformedSkillException("the skill's frontmatter is not closed");
        }
        String frontmatter = rest.substring(0, end);
        String body = rest.substring(end + 4);

        Map<String, String> values = new LinkedHashMap<>();
        for (String line : frontmatter.split("\n")) {
            String[] field = frontmatterField(line);
            if (field != null) {
                values.putIfAbsent(field[0], field[1]);
            }
        }

        String name = values.getOrDefault("name", "");
        if (name.isEmpty()) {
            throw new MalformedSkillException("the skill's frontmatter has no name");
        }
        String description = values.getOrDefault("description", "");

        List<String> steps = new ArrayList<>();
        for (String line : body.split("\n")) {
            Matcher m = NUMBERED.matcher(line);
            if (m.matches()) {
                steps.add(m.group(1).trim());
            }
        }

        return new SkillDocument(
                name,
                description,
                body.strip(),
                values,
                List.copyOf(steps),
                commaList(values.get("tools")),
                commaList(values.get("preconditions")),
                commaList(values.get("postconditions")));
    }

    /**
     * One {@code key: value} line of a frontmatter block, split into its two halves.
     *
     * <p>The rule is the terminal's rule: the key has to be followed by a colon, with nothing but
     * whitespace in between. A line that does not match is not a field - it is ignored.
     *
     * @return {@code {key, value}}, or {@code null} when the line is not a field
     */
    private static String[] frontmatterField(String line) {
        String l = line.trim();
        int colon = l.indexOf(':');
        if (colon <= 0) {
            return null;
        }
        String key = l.substring(0, colon).trim();
        if (key.isEmpty() || key.contains(" ")) {
            return null;
        }
        String value = l.substring(colon + 1).strip();
        if (value.length() >= 2
                && ((value.startsWith("\"") && value.endsWith("\""))
                    || (value.startsWith("'") && value.endsWith("'")))) {
            value = value.substring(1, value.length() - 1);
        }
        return new String[]{key, value};
    }

    private static List<String> commaList(String value) {
        if (value == null || value.isBlank()) {
            return List.of();
        }
        List<String> out = new ArrayList<>();
        for (String part : value.split(",")) {
            String p = part.strip();
            if (!p.isEmpty()) {
                out.add(p);
            }
        }
        return List.copyOf(out);
    }

    /** The {@code definition} the frozen {@code harness_skill.definition} column holds. */
    public Map<String, Object> toDefinition() {
        Map<String, Object> definition = new LinkedHashMap<>();
        definition.put("name", name);
        definition.put("description", description);
        definition.put("instructions", instructions);
        definition.put("steps", steps);
        definition.put("tools", tools);
        definition.put("preconditions", preconditions);
        definition.put("postconditions", postconditions);
        return definition;
    }
}
