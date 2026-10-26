#!/usr/bin/env bash
# =====================================================================================
# Applies the harness migrations to a throwaway MySQL 8 and asserts the contracts that
# only a real database can prove (collation behaviour, the dedup unique key, JSON columns).
#
# This is the check behind "the frozen DDL was validated against MySQL 8.4 on 2026-10-23".
#
#   ./harness/db/verify.sh                 # start a container, verify, remove it
#   ./harness/db/verify.sh --keep          # leave the container running for inspection
#
# Requires: docker. Never points at a real database - the container name is unique and the
# port is bound to loopback only.
# =====================================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTAINER="harness-mysql-verify-$$"
PORT="13399"
KEEP=0
[[ "${1:-}" == "--keep" ]] && KEEP=1

cleanup() {
  if [[ $KEEP -eq 0 ]]; then
    docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  else
    echo "container kept: $CONTAINER (port $PORT)"
  fi
}
trap cleanup EXIT

echo "==> starting MySQL 8 on 127.0.0.1:$PORT"
docker run -d --name "$CONTAINER" \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_DATABASE=harness \
  -p "127.0.0.1:$PORT:3306" \
  mysql:8 --character-set-server=utf8mb4 --collation-server=utf8mb4_bin >/dev/null

echo "==> waiting for the server and the harness database"
# The entrypoint answers on its unix socket while MYSQL_DATABASE is still being created,
# so waiting for "select 1" alone is not enough - wait for the schema we are going to use.
for i in $(seq 1 60); do
  if docker exec "$CONTAINER" mysql -uroot -e "use harness" >/dev/null 2>&1; then break; fi
  if [[ $i -eq 60 ]]; then echo "harness database did not come up"; exit 1; fi
  sleep 2
done

echo "==> applying migrations"
for f in "$SCRIPT_DIR"/../harness-db/src/main/resources/db/migration/V*.sql; do
  echo "    $(basename "$f")"
  docker exec -i "$CONTAINER" mysql -uroot harness < "$f"
done

echo "==> asserting contracts"
docker exec -i "$CONTAINER" mysql -uroot harness <<'SQL'
-- every table carries the harness_ prefix, which is also how we avoid MySQL reserved words
-- such as `groups` and `order` (03 §8.1)
SELECT CASE WHEN COUNT(*) = 0 THEN 'OK   no reserved-word table names'
            ELSE 'FAIL offending tables: ' END AS assert_reserved_words
  FROM information_schema.tables
 WHERE table_schema = 'harness' AND table_name NOT LIKE 'harness\_%';

-- the dedup contract (A0-7): 1000 identical triggers collapse into one row with a counter
DELETE FROM harness_event;
INSERT INTO harness_event (event_id,fingerprint,event_window,source,event_type,payload,received_at)
VALUES ('0198f0c2-0000-7000-8000-000000000001','verify:fp','w1','im','group.at','{}',NOW());
INSERT INTO harness_event (event_id,fingerprint,event_window,source,event_type,payload,received_at)
VALUES ('0198f0c2-0000-7000-8000-000000000002','verify:fp','w1','im','group.at','{}',NOW())
  ON DUPLICATE KEY UPDATE dedup_count = dedup_count + 1, last_seen_at = NOW();
INSERT INTO harness_event (event_id,fingerprint,event_window,source,event_type,payload,received_at)
VALUES ('0198f0c2-0000-7000-8000-000000000003','verify:fp','w2','im','group.at','{}',NOW());
SELECT CASE WHEN (SELECT COUNT(*) FROM harness_event) = 2
             AND (SELECT dedup_count FROM harness_event WHERE event_window='w1') = 2
            THEN 'OK   dedup: same window collapses, new window does not'
            ELSE 'FAIL dedup contract broken' END AS assert_dedup;

-- E-01: the unique key references event_window, so the column has to exist. The spec (03 §2.2)
-- used the key without ever declaring the column - a schema that cannot be created.
SELECT CASE WHEN COUNT(*) = 1
            THEN 'OK   event_window exists (E-01): the dedup key is usable'
            ELSE 'FAIL event_window is missing - uk_fp_window cannot be enforced' END AS assert_event_window
  FROM information_schema.columns
 WHERE table_schema = 'harness' AND table_name = 'harness_event' AND column_name = 'event_window';

-- E-05: the frame MAC covers the whole frame, so the wire format is defined by the version
-- byte. Nothing to assert in the database, but the migration set must not leave a half-fixed
-- dedup window behind.
SELECT CASE WHEN (SELECT COUNT(*) FROM information_schema.statistics
                   WHERE table_schema='harness' AND table_name='harness_event'
                     AND index_name='uk_fp_window' AND column_name='event_window') = 1
            THEN 'OK   the dedup key really is on event_window'
            ELSE 'FAIL uk_fp_window does not cover event_window' END AS assert_dedup_key;

-- the idempotency key is a hard unique constraint, so a replayed action cannot execute twice
INSERT INTO harness_action (action_id,plan_id,step_seq,agent_id,arguments,arguments_hash,started_at)
VALUES ('0198f0c2-0000-7000-8000-00000000000a','p1',1,'a1','{}','verify:idempotency',NOW());
INSERT IGNORE INTO harness_action (action_id,plan_id,step_seq,agent_id,arguments,arguments_hash,started_at)
VALUES ('0198f0c2-0000-7000-8000-00000000000b','p1',1,'a1','{}','verify:idempotency',NOW());
SELECT CASE WHEN (SELECT COUNT(*) FROM harness_action WHERE arguments_hash='verify:idempotency') = 1
            THEN 'OK   idempotency key is enforced by the database'
            ELSE 'FAIL idempotency key not enforced' END AS assert_idempotency;

-- charset: the harness library is utf8mb4 so that names, notes and Chinese payloads survive
SELECT CASE WHEN COUNT(*) = 0 THEN 'OK   all tables utf8mb4'
            ELSE 'FAIL tables with another charset' END AS assert_charset
  FROM information_schema.tables
 WHERE table_schema = 'harness' AND table_collation NOT LIKE 'utf8mb4%';

-- every table the policy engine reads at request time is indexed on its hot path
SELECT CASE WHEN COUNT(DISTINCT index_name) = 6
            THEN 'OK   grant/approval/audit hot-path indexes present'
            ELSE CONCAT('FAIL expected 6 hot-path indexes, found ', COUNT(DISTINCT index_name))
       END AS assert_indexes
  FROM information_schema.statistics
 WHERE table_schema = 'harness' AND index_name IN
   ('idx_agent_cap','idx_exp','idx_pending','idx_trace','idx_open','uk_fp_window');
SQL

echo "==> done"