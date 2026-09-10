-- One-time Postgres setup for PowerSync replication.
--
-- Run by hand, once, against the Serverpod database:
--   psql -h 127.0.0.1 -p 8090 -U postgres -d book_marker -f powersync/setup_replication.sql
--
-- Replace CHANGE_ME first, and use the SAME password in .env (PS_SOURCE_URI and
-- PS_STORAGE_URI).
--
-- This is deliberately NOT part of a Serverpod migration. The integration guide
-- appends it to migration.sql, but that would commit a database password to git,
-- and Serverpod migrations are not the right place for cluster-level objects
-- (roles and publications are per-cluster, migrations are per-database).

-- 1. A read-only role that may consume a replication slot. BYPASSRLS because
--    PowerSync must see every row it is asked to replicate.
CREATE ROLE powersync_role WITH REPLICATION BYPASSRLS LOGIN PASSWORD 'CHANGE_ME';

GRANT SELECT ON ALL TABLES IN SCHEMA public TO powersync_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO powersync_role;

-- 2. The publication PowerSync consumes. It MUST be named "powersync".
--
--    Explicit table list, NOT "FOR ALL TABLES". Replicating everything would
--    pull Serverpod's auth and session tables, migration bookkeeping, the OCR
--    usage log and (later) attachment bytes into the sync buckets. A bare
--    scaffold has 34 tables; this publication covers seven.
--
--    A DESTRUCTIVE migration silently drops its table from the publication,
--    because it recreates the table, and sync then goes quiet with no error
--    anywhere. After any `create-migration --force`, run:
--      ALTER PUBLICATION powersync ADD TABLE <t>;
--    and check the grant with has_table_privilege('powersync_role', ...).
CREATE PUBLICATION powersync FOR TABLE
  books, quotes, shelves, themes, shelf_books, theme_quotes, entitlements;

-- 3. PowerSync's bucket storage lives in its own database. It will NOT create
--    this for you.
--    Run separately, outside a transaction, connected to any database:
--      CREATE DATABASE powersync_storage WITH OWNER = powersync_role;
