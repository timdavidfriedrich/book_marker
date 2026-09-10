# Book Marker, backend

Serverpod 4.0.0-rc.2 backend for the Book Marker Flutter app, plus a self-hosted
PowerSync service. Implements the plan at
`~/.claude-personal/plans/parsed-beaming-feigenbaum.md`.

## Layout

```
server/
├── pubspec.yaml            pub workspace root for the SERVER side only
└── book_marker_server/     the backend

packages/book_marker_client/    generated client, member of the APP workspace
```

The generated client lives under `packages/`, not here. It is consumed by the
Flutter app, so it resolves with the app; keeping the server in its own workspace
keeps the server's large dependency tree out of the app's resolution. The server
does not depend on the client, so nothing breaks.

Pub also forbids the arrangement the other way round: a workspace member cannot
sit below a stray `pubspec.yaml` (this `server/pubspec.yaml`), so the client
could not have stayed here and joined the app workspace.

Its output path is `config/generator.yaml` → `client_package_path`.

There is no `book_marker_flutter`. The real app is the Flutter project at the
repository root, and it is run with **`fvm flutter run`**, never by
`serverpod start`, the root `CLAUDE.md` makes FVM mandatory and `serverpod start`
would invoke a plain `flutter`.

## What this backend does

- **Sync write API**, applies PowerSync CRUD batches to Postgres. `ownerId` is
  always taken from the session, never from the request body.
- **PowerSync JWTs**, Serverpod signs short-lived RS256 tokens that the PowerSync
  service validates against a static JWK. PowerSync contacts no identity provider.
- **OCR proxy**, holds the model provider's API key, enforces rolling
  day/week/month rate limits, never writes the image to disk.
- **Entitlements**, plan, account status and usage counters. Server-owned; the
  device may only read them.

User content is **end-to-end encrypted**. Content columns hold ciphertext the
server cannot read; only structure (ids, foreign keys, timestamps, flags) is
plaintext. Do not add server logic that reads a `*Cipher` column.

The one exception is `entitlements.backupVerifier`, a known string encrypted
under the master key. It is not key material and the server never decrypts it;
it exists so a device can tell "a backup already exists" from "no backup yet",
and a right recovery code from a wrong one. See the plan.

**Column names are snake_case, set with `column=` in every model.** Serverpod
would otherwise emit camelCase, and the PowerSync sync rules, the PowerSync
client schema and Drift's default column naming are all snake_case. One
convention across the three beats matching the Dart field names.

**Synced tables carry no foreign keys.** PowerSync replicates rows
independently, so a batch can carry a quote whose book the server has not seen;
a constraint would reject the write rather than store an opaque string.
Referential integrity lives on the device, where the cascades are.

## Structure rules

Four layers, and the boundaries are the point:

- `endpoints/`, transport only. Auth check, arg validation, delegate. The **only**
  place `Endpoint` and `Session` appear in signatures. If a method exceeds ~10
  lines, the logic belongs in `domain/`.
- `domain/`, the rules. Never imports an adapter implementation, only its
  interface.
- `adapters/`, one folder per external system, each an interface plus
  implementations. Concrete classes are named in exactly one place:
  `composition.dart`.
- `models/`, `.spy.yaml`, Serverpod's generated persistence.

Tunable values live in `app_config.yaml`, not in code and not in the database, so
they can change in production without a deploy. It is served unauthenticated, so
**nothing secret goes in it**.

## Commands

The Serverpod MCP server is not configured in this repo; use the CLI.

- `serverpod generate`, regenerate server and client code after model or endpoint
  changes.
- `serverpod create-migration`, after changing a model with a `table`
  (`--force` for destructive changes).
- `dart run bin/main.dart --role maintenance --apply-migrations`, apply them.
- `docker compose up --detach`, Postgres, Redis and PowerSync.
- `dart run tool/generate_keys.dart`, the PowerSync JWT keypair. Development and
  production get different pairs; production's is generated on the VPS.
- `dart run tool/mint_powersync_token.dart <auth-user-uuid>`, a token for
  checking the sync path without a signed-in device:
  `curl -m 5 -X POST http://localhost:8095/sync/stream -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' -d '{"raw_data":true}'`
  should answer with one bucket per stream, and only that user's rows.
- `dart test` in `book_marker_server`, tests need no Docker; `config/test.yaml`
  points at an embedded Postgres.

NEVER edit generated code: `lib/src/generated/` and the whole
`packages/book_marker_client` package are rewritten by the generator. Change `.spy.yaml` models, the endpoints,
or `lib/server.dart`.

Migrations are the one exception: a generated `migration.sql` MAY be hand-edited
when the generated SQL would lose data. Never touch the other files in a migration
directory, and keep the resulting schema identical to `definition.sql`, new
databases are built from that file and never run `migration.sql`.

Cluster-level objects (the `powersync_role`, the `powersync` publication) are
**not** in migrations, they live in `powersync/setup_replication.sql` and are run
by hand. Migrations are per-database; roles and publications are per-cluster, and
putting a database password in a committed migration would leak it.

**After any `create-migration --force`, check the publication.** A destructive
migration recreates the table, which silently drops it from the publication, and
sync then goes quiet with no error anywhere:

```sql
SELECT tablename FROM pg_publication_tables WHERE pubname='powersync';
ALTER PUBLICATION powersync ADD TABLE <t>;
```

## Checklist after changes

1. `dart analyze`
2. `dart format .`
3. `serverpod create-migration` + apply, if a model changed
4. `dart test`, if applicable
