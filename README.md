# Bank-DataBase-Design
# 📩 Latest Blog Posts : Data Modelling / Database Design
Database design is structuring data and organised relationships in a database. It goes beyond how the database further works.
I was learning about a cool stuff [dbdigram.io](https://dbdiagram.io) for designing a database so hitting a random try for Bank Database design. 

**Requirements**
1. Create and manage accounts { owner, branch, balance details...}
2. Record all transactions history from accounts -> to accounts etc.
3. Perform money transfer between 2 accounts consistently within a transactions
4. Maintaining a Loan Records

**Database Design**

The basics of database design is identifying what data needs to get stored, grouping such data into tables or collections and adding relationships between related data points. The whole database design process involves

Using *Entity-Relationship(ER)* diagrams to visualize the objects that get stored and their relationships.

Lets see how this can be designed on diagrams using [dbdigram.io](https://dbdiagram.io) and then converted to SQL and PostgreSQL. 

Exciting right?


**How to use dbdigram**
The tool is simple: you write code, it renders the ER diagram 👌. You can then export to PDF, PNG or generate SQL code with it ⭐️.

It uses DBML (database markup language) to define and document database schemas.



![Pic_1](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/17gpz0f1eu92te908dab.png)

*customer_id is primary key(pk keyword) and auto incremented*
*created_at enclose timezone information as well*
*deleted_at for maintaining the deletion record*

![Pic_2](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/a0z80gmdhev8ccsnt3av.png)

*bigserial in PostgreSQL is basically a big autoincrementing integers (8-byte/64-bit)*
*customer_id int [ref: > C.customer_id], customer_id is foreign key user here*

![Pic_3](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/0ssvjfm3l68w41vq6ir4.png)

*Hence the Final ER - Diagram Result:*
![Pic_4](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/nrmnjjkfmauguzmq8525.png)

**Let's write/generate mysql Code for this schema now**

CREATE DATABASE bank;
USE bank;

CREATE TABLE `customers` (
  `customer_id` int PRIMARY KEY AUTO_INCREMENT,
  `first_name` VARCHAR,
  `last_name` VARCHAR,
  `city` VARCHAR,
  `mobile_no` VARCHAR,
  `pancard_no` VARCHAR,
  `dob` VARCHAR,
  `created_at` timestampz DEFAULT "now()",
  `deleted_at` timestampz
);

CREATE TABLE `branchs` (
  `branch_id` int PRIMARY KEY AUTO_INCREMENT,
  `branch_name` VARCHAR,
  `branch_location` VARCHAR,
  `created_at` timestampz DEFAULT "now()",
  `deleted_at` timestampz
);

CREATE TABLE `accounts` (
  `account_id` bigserial PRIMARY KEY,
  `customer_id` int,
  `balance` bigint,
  `account_status` VARCHAR,
  `account_type` VARCHAR,
  `currency` VARCHAR,
  `created_at` timestampz DEFAULT "now()",
  `deleted_at` timestampz
);

CREATE TABLE `transactions` (
  `transaction_id` bigserial PRIMARY KEY,
  `transaction_type` VARCHAR,
  `from_account_id` bigint,
  `to_account_id` bigint,
  `date_issued` date,
  `amount` bigint,
  `transaction_medium` VARCHAR,
  `created_at` timestampz DEFAULT "now()",
  `deleted_at` timestampz
);

CREATE TABLE `loans` (
  `loan_id` bigserial PRIMARY KEY,
  `customer_id` int,
  `branch_id` int,
  `loan_amount` bigint,
  `date_issued` date,
  `created_at` timestampz DEFAULT "now()",
  `deleted_at` timestampz
);

ALTER TABLE `accounts` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `transactions` ADD FOREIGN KEY (`from_account_id`) REFERENCES `accounts` (`account_id`);

ALTER TABLE `transactions` ADD FOREIGN KEY (`to_account_id`) REFERENCES `accounts` (`account_id`);

ALTER TABLE `loans` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `loans` ADD FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`branch_id`);




**PostgreSQL Code**



CREATE TABLE `"customers"` (
  `"customer_id"` SERIAL PRIMARY KEY,
  `"first_name"` VARCHAR,
  `"last_name"` VARCHAR,
  `"city"` VARCHAR,
  `"mobile_no"` VARCHAR,
  `"pancard_no"` VARCHAR,
  `"dob"` VARCHAR,
  `"created_at"` timestampz DEFAULT 'now()',
  `"deleted_at"` timestampz
);

CREATE TABLE `"branchs"` (
  `"branch_id"` SERIAL PRIMARY KEY,
  `"branch_name"` VARCHAR,
  `"branch_location"` VARCHAR,
  `"created_at"` timestampz DEFAULT 'now()',
  `"deleted_at"` timestampz
);

CREATE TABLE `"accounts"` (
  `"account_id"` bigserial PRIMARY KEY,
  `"customer_id"` int,
  `"balance"` bigint,
  `"account_status"` VARCHAR,
  `"account_type"` VARCHAR,
  `"currency"` VARCHAR,
  `"created_at"` timestampz DEFAULT 'now()',
  `"deleted_at"` timestampz
);

CREATE TABLE `"transactions"` (
  `"transaction_id"` bigserial PRIMARY KEY,
  `"transaction_type"` VARCHAR,
  `"from_account_id"` bigint,
  `"to_account_id"` bigint,
  `"date_issued"` date,
  `"amount"` bigint,
  `"transaction_medium"` VARCHAR,
  `"created_at"` timestampz DEFAULT 'now()',
  `"deleted_at"` timestampz
);

CREATE TABLE `"loans"` (
  `"loan_id"` bigserial PRIMARY KEY,
  `"customer_id"` int,
  `"branch_id"` int,
  `"loan_amount"` bigint,
  `"date_issued"` date,
  `"created_at"` timestampz DEFAULT 'now()',
  `"deleted_at"` timestampz
);

ALTER TABLE `"accounts"` ADD FOREIGN KEY (`"customer_id"`) REFERENCES `"customers"` (`"customer_id"`);

ALTER TABLE `"transactions"` ADD FOREIGN KEY (`"from_account_id"`) REFERENCES `"accounts"` (`"account_id"`);

ALTER TABLE `"transactions"` ADD FOREIGN KEY (`"to_account_id"`) REFERENCES `"accounts"` (`"account_id"`);

ALTER TABLE `"loans"` ADD FOREIGN KEY (`"customer_id"`) REFERENCES `"customers"` (`"customer_id"`);

ALTER TABLE `"loans"` ADD FOREIGN KEY (`"branch_id"`) REFERENCES `"branchs"` (`"branch_id"`);



**References:**
https://github.com/holistics/dbml

*Get the code here*
https://github.com/jinxankit/Bank-DataBase-Design



**THANK YOU!!!!!**



