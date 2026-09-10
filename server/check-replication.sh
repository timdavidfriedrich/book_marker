#!/usr/bin/env bash
# The single most likely way this stack breaks: an inactive replication slot
# holds WAL until the disk fills, and nothing else complains until it does.
#
#   */15 * * * * /home/informaten/workspaces/book-marker/server/check-replication.sh
#
# Prints nothing when healthy, so cron only mails on trouble.
set -euo pipefail

cd "$(dirname "$0")"

# * megabytes of WAL the slot is holding back. A busy stack sits near zero; a
# * stalled consumer climbs without limit
readonly LAG_LIMIT_MB=2048

status="$(docker compose -f docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d book_marker -tA -F' ' -c \
  "SELECT slot_name, active, coalesce(pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn) / 1024 / 1024, 0)::bigint
   FROM pg_replication_slots WHERE slot_name LIKE 'powersync%';")"

if [ -z "$status" ]; then
  echo "no powersync replication slot exists: sync is not replicating at all" >&2
  exit 1
fi

while read -r name active lag; do
  [ -z "$name" ] && continue
  if [ "$active" != "t" ]; then
    echo "replication slot $name is INACTIVE, holding ${lag}MB of WAL" >&2
    exit 1
  fi
  if [ "$lag" -gt "$LAG_LIMIT_MB" ]; then
    echo "replication slot $name is ${lag}MB behind, over the ${LAG_LIMIT_MB}MB limit" >&2
    exit 1
  fi
done <<< "$status"

liveness="$(curl -sS -o /dev/null -w '%{http_code}' https://book-marker-sync.timdavidfriedrich.de/probes/liveness || echo 000)"
if [ "$liveness" != "200" ]; then
  echo "powersync liveness probe returned $liveness" >&2
  exit 1
fi
