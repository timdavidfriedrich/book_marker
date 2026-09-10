BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "attachment_objects" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "attachment_id" text NOT NULL,
    "size_bytes" bigint NOT NULL,
    "created_at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "attachment_objects_owner_idx" ON "attachment_objects" USING btree ("owner_id");
CREATE UNIQUE INDEX "attachment_objects_key_idx" ON "attachment_objects" USING btree ("owner_id", "attachment_id");


--
-- MIGRATION VERSION FOR book_marker
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_marker', '20260910225154080', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910225154080', "timestamp" = now();

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
