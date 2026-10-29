package com.fuao.harness.platform.domain;

import java.time.Instant;
import java.util.List;
import java.util.Map;

/**
 * Row of {@code harness_skill} (03 §2.4) as the market sees it.
 *
 * <p>The frozen V1 columns say what a skill <em>is</em>: a key, a version, a definition, a
 * signature, an author, an evaluation result, a lifecycle status, a rollout percentage and a
 * visibility scope. The V11 columns say where it came from and whether it is on the shelf:
 * {@code source}, {@code listing_status}, {@code visibility}, {@code content} and
 * {@code content_digest}.
 *
 * <p>The content is a SKILL.md document - the same shape the terminal loads (frontmatter with a
 * name and a description, then the instructions). The platform refuses a skill whose frontmatter
 * the terminal would refuse, because a skill the terminal cannot read is a skill that silently
 * does nothing at the worst possible moment.
 */
public record SkillRecord(
        String skillId,
        String skillKey,
        int version,
        Integer parentVersion,
        String name,
        Map<String, Object> definition,
        String signature,
        String authorAgent,
        Integer authorHuman,
        Map<String, Object> evalResult,
        Status status,
        int rolloutPct,
        Map<String, Object> scope,
        Source source,
        String sourceRef,
        String sourceUrl,
        String publisher,
        Integer deptId,
        ListingStatus listingStatus,
        Visibility visibility,
        String content,
        String contentDigest,
        List<Map<String, Object>> scripts,
        int installCount,
        String createdBy,
        Instant createdAt,
        Instant updatedAt) {

    /**
     * The lifecycle of a skill version (03 §2.4).
     *
     * <p>{@code candidate} is what a skill starts as, whoever produced it. Only a human moves it
     * on, and only past {@code approved} can it be published and installed.
     */
    public enum Status {
        CANDIDATE,
        EVALUATING,
        APPROVED,
        GRAY,
        RELEASED,
        DEPRECATED,
        ROLLED_BACK;

        public String wire() {
            return name().toLowerCase();
        }

        public static Status fromWire(String s) {
            return Status.valueOf(s.toUpperCase());
        }
    }

    /** Whether the skill is on the shelf. */
    public enum ListingStatus {
        /** Not in the market yet - the author is still working on it. */
        DRAFT,
        /** In the market: browsable and installable. */
        PUBLISHED,
        /** Taken down. The versions stay, so a rollback is still possible. */
        UNLISTED;

        public String wire() {
            return name().toLowerCase();
        }

        public static ListingStatus fromWire(String s) {
            return ListingStatus.valueOf(s.toUpperCase());
        }
    }

    /** Who may see the skill. */
    public enum Visibility {
        /** Only the author. */
        PRIVATE,
        /** The owning department. */
        DEPT,
        /** The whole company. */
        ORG;

        public String wire() {
            return name().toLowerCase();
        }

        public static Visibility fromWire(String s) {
            return Visibility.valueOf(s.toUpperCase());
        }
    }

    /** Where the skill came from. */
    public enum Source {
        /** Written here: a digital employee distilled it, or a person typed it in. */
        INTERNAL,
        /** Pulled from an upstream registry. */
        EXTERNAL;

        public String wire() {
            return name().toLowerCase();
        }

        public static Source fromWire(String s) {
            return Source.valueOf(s.toUpperCase());
        }
    }
}
