BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "sync_probes" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "books" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "status" text NOT NULL,
    "created_at" timestamp without time zone NOT NULL,
    "last_used_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL,
    "key_version" bigint NOT NULL DEFAULT 1,
    "title_cipher" text NOT NULL,
    "authors_cipher" text NOT NULL,
    "isbn_cipher" text,
    "cover_cipher" text
);

-- Indexes
CREATE INDEX "books_owner_idx" ON "books" USING btree ("owner_id");

--
-- ACTION ALTER TABLE
--
DROP INDEX "entitlements_owner_idx";
ALTER TABLE "entitlements" RENAME COLUMN "ownerId" TO "owner_id";
ALTER TABLE "entitlements" RENAME COLUMN "blockedReason" TO "blocked_reason";
ALTER TABLE "entitlements" RENAME COLUMN "blockedAt" TO "blocked_at";
ALTER TABLE "entitlements" RENAME COLUMN "backupVerifier" TO "backup_verifier";
ALTER TABLE "entitlements" RENAME COLUMN "backupInitializedAt" TO "backup_initialized_at";
ALTER TABLE "entitlements" RENAME COLUMN "usedDay" TO "used_day";
ALTER TABLE "entitlements" RENAME COLUMN "usedWeek" TO "used_week";
ALTER TABLE "entitlements" RENAME COLUMN "usedMonth" TO "used_month";
ALTER TABLE "entitlements" RENAME COLUMN "updatedAt" TO "updated_at";
ALTER TABLE "entitlements" RENAME COLUMN "productId" TO "product_id";
ALTER TABLE "entitlements" RENAME COLUMN "purchaseToken" TO "purchase_token";
ALTER TABLE "entitlements" RENAME COLUMN "purchasedAt" TO "purchased_at";
ALTER TABLE "entitlements" RENAME COLUMN "refundedAt" TO "refunded_at";
CREATE UNIQUE INDEX "entitlements_owner_idx" ON "entitlements" USING btree ("owner_id");
--
-- ACTION ALTER TABLE
--
DROP INDEX "ocr_usage_owner_time_idx";
ALTER TABLE "ocr_usage" RENAME COLUMN "ownerId" TO "owner_id";
ALTER TABLE "ocr_usage" RENAME COLUMN "createdAt" TO "created_at";
ALTER TABLE "ocr_usage" RENAME COLUMN "inputTokens" TO "input_tokens";
ALTER TABLE "ocr_usage" RENAME COLUMN "outputTokens" TO "output_tokens";
CREATE INDEX "ocr_usage_owner_time_idx" ON "ocr_usage" USING btree ("owner_id", "created_at");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "quotes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "book_id" uuid NOT NULL,
    "is_favorite" boolean NOT NULL DEFAULT false,
    "created_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL,
    "key_version" bigint NOT NULL DEFAULT 1,
    "quote_cipher" text NOT NULL,
    "note_cipher" text,
    "page_numbers_cipher" text NOT NULL,
    "pages_cipher" text NOT NULL,
    "words_cipher" text NOT NULL,
    "marked_word_indexes_cipher" text NOT NULL,
    "voice_note_cipher" text
);

-- Indexes
CREATE INDEX "quotes_owner_idx" ON "quotes" USING btree ("owner_id");
CREATE INDEX "quotes_book_idx" ON "quotes" USING btree ("book_id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shelf_books" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "shelf_id" uuid NOT NULL,
    "book_id" uuid NOT NULL,
    "updated_at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "shelf_books_owner_idx" ON "shelf_books" USING btree ("owner_id");
CREATE UNIQUE INDEX "shelf_books_pair_idx" ON "shelf_books" USING btree ("shelf_id", "book_id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shelves" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "accent" text,
    "symbol" text,
    "created_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL,
    "key_version" bigint NOT NULL DEFAULT 1,
    "name_cipher" text NOT NULL
);

-- Indexes
CREATE INDEX "shelves_owner_idx" ON "shelves" USING btree ("owner_id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "theme_quotes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "theme_id" uuid NOT NULL,
    "quote_id" uuid NOT NULL,
    "updated_at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "theme_quotes_owner_idx" ON "theme_quotes" USING btree ("owner_id");
CREATE UNIQUE INDEX "theme_quotes_pair_idx" ON "theme_quotes" USING btree ("theme_id", "quote_id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "themes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "owner_id" uuid NOT NULL,
    "accent" text,
    "symbol" text,
    "created_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL,
    "key_version" bigint NOT NULL DEFAULT 1,
    "name_cipher" text NOT NULL
);

-- Indexes
CREATE INDEX "themes_owner_idx" ON "themes" USING btree ("owner_id");


--
-- MIGRATION VERSION FOR book_marker
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_marker', '20260910121917609', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910121917609', "timestamp" = now();

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
