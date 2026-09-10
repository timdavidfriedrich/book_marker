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

**1. Deploy key + sparse checkout**

```bash
ssh-keygen -t ed25519 -C "vps1686 book_marker deploy" -f ~/.ssh/book_marker_deploy -N ""
cat ~/.ssh/book_marker_deploy.pub   # add to GitHub repo → Settings → Deploy keys (read-only)

cat >> ~/.ssh/config <<'EOF'
Host github-book-marker
  HostName github.com
  User git
  IdentityFile ~/.ssh/book_marker_deploy
EOF

cd /home/informaten/workspaces
git clone --filter=blob:none --sparse github-book-marker:timdavidfriedrich/book_marker.git book-marker
cd book-marker
git sparse-checkout set server
```

**2. Secrets**, neither file is in git.

`server/.env` (from `.env.prod.example`):

```bash
cd /home/informaten/workspaces/book-marker/server
cp .env.prod.example .env && chmod 600 .env && vi .env
```

`server/book_marker_server/config/passwords.yaml`, copy the local one, replace
every value under `production:` with fresh secrets, and add the PowerSync signing
key. `POSTGRES_PASSWORD`/`REDIS_PASSWORD` in `.env` **must match** `database:`
and `redis:` under `production:`.

```bash
cd server/book_marker_server && dart run tool/generate_keys.dart
```
Public half (`PS_JWK_N`, `PS_JWK_E`, `PS_JWK_KID`) → `.env`.
Private half → `passwords.yaml` as `powerSyncSigningKey`.
**Generate this on the VPS, or anywhere the output is not written to a log.**

**3. First boot, in this order.** PowerSync must not start before the schema and
the replication role exist.

```bash
cd /home/informaten/workspaces/book-marker/server
docker compose -f docker-compose.prod.yaml up -d --build postgres redis
docker compose -f docker-compose.prod.yaml run --rm migrate
```

**4. Replication role, publication and bucket-storage database**, cluster-level
objects, deliberately not in a migration (a migration would commit a database
password, and roles and publications are per-cluster while migrations are
per-database).

```bash
cd /home/informaten/workspaces/book-marker/server/book_marker_server
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
cat /home/informaten/workspaces/book-marker/server/caddy-snippet.conf \
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
cd /home/informaten/workspaces/book-marker
git pull
docker compose -f server/docker-compose.prod.yaml up -d --build
```

`migrate` runs as a one-shot before `serverpod` and `powersync` start, so the
server never boots against an old schema. If it fails, the deploy stops there and
the previous containers keep running.

## Verify

```bash
cd /home/informaten/workspaces/book-marker/server
docker compose -f docker-compose.prod.yaml ps
docker compose -f docker-compose.prod.yaml exec -T postgres \
  psql -U postgres -d book_marker -c "SELECT slot_name, active FROM pg_replication_slots;"
curl -sS -o /dev/null -w '%{http_code}\n' https://book-marker-sync.timdavidfriedrich.de/probes/liveness
```

The replication slot must show `active = t`. An inactive slot accumulates WAL
until the disk fills, it is the most likely way this stack breaks, so it belongs
in whatever monitoring you add.

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
