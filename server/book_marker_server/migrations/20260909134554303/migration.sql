BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "entitlements" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ownerId" uuid NOT NULL,
    "plan" text NOT NULL DEFAULT 'free'::text,
    "status" text NOT NULL DEFAULT 'active'::text,
    "blockedReason" text,
    "blockedAt" timestamp without time zone,
    "usedDay" bigint NOT NULL DEFAULT 0,
    "usedWeek" bigint NOT NULL DEFAULT 0,
    "usedMonth" bigint NOT NULL DEFAULT 0,
    "updatedAt" timestamp without time zone NOT NULL,
    "store" text,
    "productId" text,
    "purchaseToken" text,
    "purchasedAt" timestamp without time zone,
    "refundedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "entitlements_owner_idx" ON "entitlements" USING btree ("ownerId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ocr_usage" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ownerId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "engine" text NOT NULL,
    "status" text NOT NULL DEFAULT 'reserved'::text,
    "inputTokens" bigint,
    "outputTokens" bigint
);

-- Indexes
CREATE INDEX "ocr_usage_owner_time_idx" ON "ocr_usage" USING btree ("ownerId", "createdAt");


--
-- MIGRATION VERSION FOR book_marker
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_marker', '20260909134554303', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909134554303', "timestamp" = now();

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
