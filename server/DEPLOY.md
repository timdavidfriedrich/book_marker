# Deploying the Book Marker backend

**Strategy: this repo is the single source of truth. The VPS holds a
pull-only, sparse checkout of `server/` and builds the image itself.**

Nothing is ever authored on the VPS, so the checkout cannot diverge. It also
never sees the Flutter app, `sparse-checkout` limits it to `server/`.

Images are built **on the VPS**, not locally: the Mac is arm64 and the VPS is
x86_64, and cross-building a Dart AOT compile under emulation is painfully slow.
The VPS builds natively in a couple of minutes.

> If build time or memory ever becomes a problem (Dart AOT is hungry, and 7.5 GB
> is shared with the other projects), the upgrade is GitHub Actions building an
> amd64 image, pushing to GHCR, and the VPS running `docker compose pull` with no
> source at all. Do not start there, it solves a problem you do not have yet.

## Topology

Nothing in this stack publishes a host port. Caddy already owns :80 and :443 in
the separate `global-gateway` project and reaches services **by network alias**
over the shared external `global-proxy` network, the same way it reaches
`openclaw-gateway`. This is also why the host's already-occupied :8080 is
irrelevant.

```
Cloudflare ──▶ Caddy (global-gateway, global-proxy network)
                 ├── book-marker-api.timdavidfriedrich.de  ─▶ book-marker-serverpod:8080
                 └── book-marker-sync.timdavidfriedrich.de ─▶ book-marker-powersync:8080

book-marker project, `internal` network (nothing published):
    postgres (wal_level=logical) · redis · serverpod · powersync
```

## First-time setup

Everything here is done once, by hand.

**1. Sparse checkout**

The repository is public, so there is no deploy key and no SSH config. If it is
ever made private, add a read-only deploy key and clone over SSH instead; nothing
else in this file changes.

```bash
cd /home/informaten/workspaces
git clone --filter=blob:none --sparse https://github.com/timdavidfriedrich/book_marker.git book_marker
cd book_marker
git sparse-checkout set server
```

The VPS is pull-only. Nothing is ever authored here, so it cannot diverge.

**2. Secrets**, neither file is in git.

`server/.env` (from `.env.prod.example`):

```bash
cd /home/informaten/workspaces/book_marker/server
cp .env.prod.example .env && chmod 600 .env && vi .env
```

`server/book_marker_server/config/passwords.yaml` is written here, not copied
from the laptop: it holds a `production:` section and nothing else, so no
development secret is ever carried onto the VPS. It needs `database`, `redis`,
`serviceSecret`, `emailSecretHashPepper`, `jwtHmacSha512PrivateKey`,
`jwtRefreshTokenHashPepper`, `powerSyncSigningKey`, and `googleClientSecret`.
All but the last two are fresh `openssl rand` values.

`googleClientSecret` is the **one** value that does come from the laptop, because
it is the same Google web OAuth client in both run modes, so there is nothing to
regenerate. `POSTGRES_PASSWORD`/`REDIS_PASSWORD` in `.env` **must match**
`database:` and `redis:` under `production:`.

Serverpod refuses to boot in production without at least one identity provider,
so a missing `googleClientSecret` is a startup failure, not a degraded sign-in.

Dart is not installed on the VPS and does not need to be. Generate the pair in a
container, from a read-only mount, so the checkout stays pristine:

```bash
cd /home/informaten/workspaces/book_marker/server
docker run --rm -v "$PWD":/src:ro dart:stable sh -c \
  'cp -r /src /tmp/server && cd /tmp/server/book_marker_server \
   && dart pub get >/dev/null 2>&1 && dart run tool/generate_keys.dart'
```
Public half (`PS_JWK_N`, `PS_JWK_E`, `PS_JWK_KID`) → `.env`.
Private half → `passwords.yaml` as `powerSyncSigningKey`.
**Generate this on the VPS, or anywhere the output is not written to a log.**
Development has its own pair, so this one never has to leave the machine.

Cloud OCR needs one more, under `production:`:

```yaml
  geminiApiKey: '<from Google AI Studio, restricted to the Generative Language API>'
```

Without it the server still boots and everything else works; the first cloud
scan fails with a clear `Missing "geminiApiKey"` and the app quietly recognises
on device instead. `recognition.provider: echo` in `app_config.yaml` exercises
the whole quota path with no key and no billing account.

**3. First boot, in this order.** PowerSync must not start before the schema and
the replication role exist.

```bash
cd /home/informaten/workspaces/book_marker/server
docker compose -f docker-compose.prod.yaml up -d --build postgres redis
docker compose -f docker-compose.prod.yaml run --rm migrate
```

**4. Replication role, publication and bucket-storage database**, cluster-level
objects, deliberately not in a migration (a migration would commit a database
password, and roles and publications are per-cluster while migrations are
per-database).

```bash
cd /home/informaten/workspaces/book_marker/server/book_marker_server
sed 's/CHANGE_ME/<the powersync_role password from .env>/' powersync/setup_replication.sql \
  | docker compose -f ../docker-compose.prod.yaml exec -T postgres psql -U postgres -d book_marker

docker compose -f ../docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d postgres -c "CREATE DATABASE powersync_storage WITH OWNER = powersync_role;"
```

**5. Start everything**

```bash
docker compose -f docker-compose.prod.yaml up -d --build
```

**6. Caddy**, append `caddy-snippet.conf` to the gateway's Caddyfile:

```bash
cat /home/informaten/workspaces/book_marker/server/caddy-snippet.conf \
  >> /home/informaten/workspaces/global-gateway/Caddyfile
docker compose -f /home/informaten/workspaces/global-gateway/docker-compose.yml restart caddy
```

**7. DNS**, two Cloudflare A records, `book-marker-api` and `book-marker-sync`,
pointing at the VPS, proxied. Single-label on purpose: free Universal SSL covers
the apex plus **one** label, so a nested `api.book-marker.…` would need paid
Advanced Certificate Manager.

Cloudflare, per hostname: WebSockets **on**, cache rule **Bypass**, Bot Fight
Mode **off** (it rejects non-browser clients and silently kills sync).

## Routine deploy

```bash
cd /home/informaten/workspaces/book_marker
git pull
docker compose -f server/docker-compose.prod.yaml up -d --build
```

`migrate` runs as a one-shot before `serverpod` and `powersync` start, so the
server never boots against an old schema. If it fails, the deploy stops there and
the previous containers keep running.

### After a migration that dropped or recreated a table

Check the publication. A destructive migration recreates the table, which
silently removes it from `powersync`, and sync then goes quiet with no error
anywhere. The first phase 4 deploy is exactly this case: it drops `sync_probes`
and creates the six synced tables, none of which are in the publication yet.

```bash
docker compose -f docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d book_marker -c \
  "SELECT tablename FROM pg_publication_tables WHERE pubname='powersync' ORDER BY tablename;"

docker compose -f docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d book_marker -c \
  "ALTER PUBLICATION powersync ADD TABLE books, quotes, shelves, themes, shelf_books, theme_quotes;"
```

`ALTER DEFAULT PRIVILEGES` already grants `powersync_role` SELECT on new tables,
but it costs nothing to confirm:

```bash
docker compose -f docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d book_marker -c \
  "SELECT table_name, has_table_privilege('powersync_role', 'public.'||table_name, 'SELECT') FROM information_schema.tables WHERE table_schema='public' AND table_name IN ('books','quotes','shelves','themes','shelf_books','theme_quotes');"
```

Then restart PowerSync so it picks up the new sync rules and re-snapshots:

```bash
docker compose -f docker-compose.prod.yaml restart powersync
docker compose -f docker-compose.prod.yaml logs --tail 40 powersync
```

## Verify

```bash
cd /home/informaten/workspaces/book_marker/server
docker compose -f docker-compose.prod.yaml ps
docker compose -f docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d book_marker -c "SELECT slot_name, active FROM pg_replication_slots;"
curl -sS -o /dev/null -w '%{http_code}\n' https://book-marker-sync.timdavidfriedrich.de/probes/liveness
```

The replication slot must show `active = t`. An inactive slot accumulates WAL
until the disk fills, it is the most likely way this stack breaks, so it belongs
in whatever monitoring you add.

## Attachments

Off by default: `app_config.yaml` ships `attachments.provider: database`, which
keeps blobs in Postgres. That is wrong at scale and exactly right for getting
the stack running, so switch it deliberately.

To use MinIO instead, once:

1. Set `MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD` in `.env` and bring the service
   up. Reach the console through an SSH tunnel, never a public port:
   `ssh -L 9001:127.0.0.1:9001 <vps>` then http://localhost:9001.
2. Create the bucket `book-marker-attachments`, **private**. Every object in it
   is ciphertext this server cannot open, but a public bucket would still leak
   how many attachments an account has and when.
3. Create a **separate access key** scoped to that bucket. The root pair is not
   what the server should use.
4. Put it in `passwords.yaml` under `production:` as `minioAccessKey` and
   `minioSecretKey`.
5. Set `attachments.provider: minio` in `app_config.yaml` and **restart**. This
   one value is read at boot, unlike everything else in that file, because
   Serverpod binds storage backends at startup.
6. Add a lifecycle rule expiring incomplete multipart uploads after a day, so an
   interrupted upload does not sit there forever.

Verify by uploading a page from a premium account, then fetching the object
directly from the console. **If it renders as an image, the encryption failed**
and the phase is not done.

## Keeping it alive

Two cron entries, both scripts in this folder, both silent when healthy so cron
only mails on trouble.

```cron
0  3 * * * BACKUP_PASSPHRASE=... BACKUP_TARGET=user@host:/backups /home/informaten/workspaces/book_marker/server/backup.sh
*/15 * * * *                                                     /home/informaten/workspaces/book_marker/server/check-replication.sh
```

`backup.sh` dumps `book_marker`, gzips it, encrypts it with AES-256 and pushes
it off the machine. `powersync_storage` is deliberately not backed up: it is
derivable, and resetting PowerSync rebuilds it from this dump. The passphrase
must not live on the VPS, so it goes wherever the recovery code went; without
it the backups are as unreadable to you as the quotes are.

**Restore-test the dump.** A backup nobody has restored is not a backup, it is a
file. Once, into a throwaway database:

```bash
openssl enc -d -aes-256-cbc -pbkdf2 -pass env:BACKUP_PASSPHRASE -in book_marker-<stamp>.sql.gz.enc \
  | gunzip \
  | docker compose -f docker-compose.prod.yaml exec -T postgres psql -U postgres -d restore_test
```

`check-replication.sh` is the one that matters most. An inactive replication slot
holds WAL until the disk fills, and nothing else complains until it does; it also
catches a slot that exists but has fallen far behind, and a liveness probe that
has stopped answering.

## Gotchas

- **After any `serverpod create-migration --force`** the table is recreated and
  silently dropped from the publication. Sync then goes quiet with no error.
  Re-add it: `ALTER PUBLICATION powersync ADD TABLE <t>;` plus
  `GRANT SELECT ON ALL TABLES IN SCHEMA public TO powersync_role;`
- **`config/development.yaml` must not regain a `dataPath`.** Serverpod scaffolds
  one, which makes it run an embedded Postgres and ignore Docker entirely.
- **Insights (8081) is not in the Caddyfile** and must stay out. Reach it over
  Tailscale.
- **Never `docker compose down -v`** in production; `-v` destroys the
  `postgres_data` volume.
