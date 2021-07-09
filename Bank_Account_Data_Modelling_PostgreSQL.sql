CREATE TABLE "customers" (
  "customer_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR,
  "last_name" VARCHAR,
  "city" VARCHAR,
  "mobile_no" VARCHAR,
  "pancard_no" VARCHAR,
  "dob" VARCHAR,
  "created_at" timestampz DEFAULT 'now()',
  "deleted_at" timestampz
);

CREATE TABLE "branchs" (
  "branch_id" SERIAL PRIMARY KEY,
  "branch_name" VARCHAR,
  "branch_location" VARCHAR,
  "created_at" timestampz DEFAULT 'now()',
  "deleted_at" timestampz
);

CREATE TABLE "accounts" (
  "account_id" bigserial PRIMARY KEY,
  "customer_id" int,
  "balance" bigint,
  "account_status" VARCHAR,
  "account_type" VARCHAR,
  "currency" VARCHAR,
  "created_at" timestampz DEFAULT 'now()',
  "deleted_at" timestampz
);

CREATE TABLE "transactions" (
  "transaction_id" bigserial PRIMARY KEY,
  "transaction_type" VARCHAR,
  "from_account_id" bigint,
  "to_account_id" bigint,
  "date_issued" date,
  "amount" bigint,
  "transaction_medium" VARCHAR,
  "created_at" timestampz DEFAULT 'now()',
  "deleted_at" timestampz
);

CREATE TABLE "loans" (
  "loan_id" bigserial PRIMARY KEY,
  "customer_id" int,
  "branch_id" int,
  "loan_amount" bigint,
  "date_issued" date,
  "created_at" timestampz DEFAULT 'now()',
  "deleted_at" timestampz
);

ALTER TABLE "accounts" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("customer_id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("account_id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("account_id");

ALTER TABLE "loans" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("customer_id");

ALTER TABLE "loans" ADD FOREIGN KEY ("branch_id") REFERENCES "branchs" ("branch_id");

CREATE INDEX ON "customers" ("customer_id");

CREATE INDEX ON "customers" ("first_name");

CREATE INDEX ON "customers" ("last_name");

CREATE INDEX ON "branchs" ("branch_id");

CREATE INDEX ON "accounts" ("account_id");

CREATE INDEX ON "transactions" ("from_account_id");

CREATE INDEX ON "transactions" ("to_account_id");

CREATE INDEX ON "transactions" ("from_account_id", "to_account_id");
