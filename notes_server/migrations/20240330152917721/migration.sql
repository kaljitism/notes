BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "note" (
    "id" serial PRIMARY KEY,
    "text" text NOT NULL,
    "created" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240330152917721', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240330152917721', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
