BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "sync_probes" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sync_probes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ownerId" text NOT NULL,
    "note" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "sync_probes_owner_idx" ON "sync_probes" USING btree ("ownerId");


--
-- MIGRATION VERSION FOR book_marker
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_marker', '20260909114315327', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909114315327', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260824182405944', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182405944', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
