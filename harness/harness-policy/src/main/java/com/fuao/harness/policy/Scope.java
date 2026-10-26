package com.fuao.harness.policy;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

/**
 * Data-level scope of a permission (01 §5.2). A permission is
 * {@code capability ∩ scope ∩ TTL} - a capability alone is never sufficient.
 *
 * <p>{@code deptIds} mirrors portal's {@code department} subtree; {@code resourcePerm} mirrors
 * {@code user_group_info.resourcePermission} (03 §8). Row filters are a harness-side concept
 * used by the portal adapter for statements like "only tickets of my own department".
 */
public record Scope(Set<Integer> deptIds, Map<String, Object> rowFilter, String resourcePerm) {

    /** Unbounded scope. Only ever handed to a human or to the platform itself. */
    public static final Scope UNBOUNDED = new Scope(null, Map.of(), null);

    public Scope {
        deptIds = deptIds == null || deptIds.isEmpty() ? null : Set.copyOf(deptIds);
        rowFilter = rowFilter == null ? Map.of() : Map.copyOf(rowFilter);
    }

    public static Scope ofDept(int... deptIds) {
        Set<Integer> s = new LinkedHashSet<>();
        for (int d : deptIds) {
            s.add(d);
        }
        return new Scope(s, Map.of(), null);
    }

    public boolean isUnbounded() {
        return deptIds == null;
    }

    /**
     * Whether this (granted) scope fully contains the scope of {@code requested}.
     *
     * <p>Containment, not overlap: a grant of department 91 does not "cover" a request that
     * touches 91 and 92, because the grant cannot pay for 92. An unbounded grant covers
     * everything; a bounded grant never covers an unbounded request, because "this agent may
     * touch department 91" must never become "this agent may touch the whole organisation".
     */
    public boolean covers(Scope requested) {
        Objects.requireNonNull(requested, "requested");
        if (isUnbounded()) {
            return true;
        }
        if (requested.isUnbounded()) {
            return false; // a bounded grant must never authorise a whole-organisation action
        }
        return deptIds.containsAll(requested.deptIds);
    }

    /**
     * Narrowest scope satisfying both sides, or {@code null} when they do not meet.
     * Used when two grants stack (position grant ∩ temporary escalation) and when a grant is
     * matched against the object being requested.
     *
     * <p>An unbounded {@code other} returns {@code this} - a request that is not narrowed
     * inherits the grant's bound. The reverse does not hold: a bounded scope intersected with an
     * unbounded request yields {@code null}, because "this agent may touch department 91" must
     * never become "this agent may touch the whole organisation".
     *
     * <p>Row filters and the resource permission are constraints, not preferences: when the two
     * sides name the same key with different values they contradict each other and the
     * intersection is empty. The requested scope therefore can never <em>widen</em> a grant -
     * a request carrying {@code owner=everyone} does not escape a grant limited to
     * {@code owner=me} (01 §5.2, red-team R-01).
     */
    public Scope intersect(Scope other) {
        if (isUnbounded()) {
            return other;
        }
        if (other.isUnbounded()) {
            return null;
        }
        Set<Integer> overlap = new LinkedHashSet<>(deptIds);
        overlap.retainAll(other.deptIds);
        if (overlap.isEmpty()) {
            return null;
        }
        Map<String, Object> filters = new LinkedHashMap<>(rowFilter);
        for (Map.Entry<String, Object> e : other.rowFilter.entrySet()) {
            Object mine = filters.get(e.getKey());
            if (mine != null && !mine.equals(e.getValue())) {
                return null; // contradictory constraints: nothing satisfies both
            }
            filters.put(e.getKey(), e.getValue());
        }
        if (other.resourcePerm() != null && resourcePerm() != null
                && !other.resourcePerm().equals(resourcePerm())) {
            return null; // contradictory resource permissions
        }
        String perm = other.resourcePerm() != null ? other.resourcePerm() : resourcePerm();
        return new Scope(overlap, filters, perm);
    }

    public Map<String, Object> toMap() {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("deptIds", deptIds == null ? List.of() : List.copyOf(deptIds));
        m.put("rowFilter", rowFilter);
        m.put("resourcePerm", resourcePerm == null ? "" : resourcePerm);
        return m;
    }

    public static Scope fromMap(Map<String, Object> m) {
        Set<Integer> depts = null;
        Object raw = m.get("deptIds");
        if (raw instanceof Collection<?> c && !c.isEmpty()) {
            Set<Integer> s = new LinkedHashSet<>();
            for (Object o : c) {
                s.add(o instanceof Number n ? n.intValue() : Integer.parseInt(String.valueOf(o)));
            }
            depts = s;
        }
        Map<String, Object> filters = new LinkedHashMap<>();
        Object rf = m.get("rowFilter");
        if (rf instanceof Map<?, ?> fm) {
            fm.forEach((k, v) -> filters.put(String.valueOf(k), v));
        }
        String perm = m.get("resourcePerm") instanceof String s ? s : null;
        return new Scope(depts, filters, (perm == null || perm.isBlank()) ? null : perm);
    }
}