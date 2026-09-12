#!/usr/bin/env bash
# Nightly encrypted backup of the Serverpod database, pushed off the VPS.
#
#   0 3 * * * /home/informaten/workspaces/book_marker/server/backup.sh
#
# powersync_storage is NOT backed up on purpose: it is derivable. Resetting
# PowerSync rebuilds it from this dump, so a copy would only be a second thing
# to keep consistent.
#
# The dump is encrypted before it leaves the machine, with a passphrase that
# lives nowhere on it. Restoring needs BACKUP_PASSPHRASE, so keep it wherever
# the recovery code went, not in .env.
set -euo pipefail

cd "$(dirname "$0")"

: "${BACKUP_PASSPHRASE:?set BACKUP_PASSPHRASE in the environment, not in .env}"
: "${BACKUP_TARGET:?set BACKUP_TARGET to an rclone or scp destination}"

stamp="$(date -u +%Y%m%dT%H%M%SZ)"
archive="/tmp/book_marker-${stamp}.sql.gz.enc"

trap 'rm -f "$archive"' EXIT

docker compose -f docker-compose.prod.yaml exec -T postgres \
  pg_dump -U postgres --format=plain --no-owner book_marker \
  | gzip \
  | openssl enc -aes-256-cbc -pbkdf2 -salt -pass env:BACKUP_PASSPHRASE \
  > "$archive"

# * a dump that is empty or truncated is worse than no dump, because it looks
# * like one. Anything under a kilobyte means pg_dump failed upstream of gzip
if [ "$(stat -c %s "$archive")" -lt 1024 ]; then
  echo "backup looks truncated, refusing to upload: $(stat -c %s "$archive") bytes" >&2
  exit 1
fi

scp "$archive" "$BACKUP_TARGET/"
echo "uploaded $(basename "$archive")"
