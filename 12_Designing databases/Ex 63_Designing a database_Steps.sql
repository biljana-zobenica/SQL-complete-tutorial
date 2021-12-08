-- Designing a database:
-- 1. understand the requirements
-- 2. build a conceptual model
-- 3. build a logical model
-- 4. build a physical model

-- CONCEPTUAL MODEL 	-> represents the entities and their relationships.
-- LOGICAL MODEL 		-> creating relationships between entities; more details than the conceptual model.
-- PHYSICAL MODEL		-> the implementation of logical model in mySQL.courses 


-- create a databse

CREATE DATABASE IF NOT EXISTS sql_store2;
DROP DATABASE IF EXISTS sql_store2;

-- create a table

CREATE DATABASE IF NOT EXISTS sql_store2;
USE sql_store2;
DROP TABLE IF EXISTS orders; -- because we cannot delete customers table first, since it is dependent on the relationship with orders table;
DROP TABLE IF EXISTS customers; -- or CREATE TABLE IF NOT EXISTS customers

CREATE TABLE customers
	(
		customer_id 	INT PRIMARY KEY AUTO_INCREMENT,
		first_name 		VARCHAR(50) CHARACTER SET latin1 NOT NULL,
        points			INT NOT NULL DEFAULT 0,
        email			VARCHAR(255) NOT NULL UNIQUE
	);
    
-- alter a table

ALTER TABLE customers
	ADD last_name 	VARCHAR(50) NOT NULL AFTER first_name,
    ADD city 		VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(55) DEFAULT '',
    DROP points;
    
-- create relationships
-- DROP TABLE IF EXISTS orders; -- or CREATE TABLE IF NOT EXISTS customers
CREATE TABLE orders
	(
		order_id 		INT PRIMARY KEY,
		customer_id		INT NOT NULL,
        FOREIGN KEY fk_orders_customers (customer_id) -- fk_childTable_customersTable
			REFERENCES customers (customer_id)
            ON UPDATE CASCADE -- or SET NULL, NO ACTION
            ON DELETE NO ACTION
	);
    
-- create and drop relationships between table that already exists

ALTER TABLE orders
	ADD PRIMARY KEY (order_id),
    DROP PRIMARY KEY, -- when dropping primary key, we don't need to specify name of the columns
	DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY fk_orders_customers (customers_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

-- CHARACTER SETS AND COLLATIONS

SHOW CHARSET;
CHAR(10) -> 10 X 3 = 30 BITES X 1000000 = 30M

CREATE DATABASE db_name
	CHARACTER SET latin1;

ALTER DATABASE db_name
	CHARACTER SET latin1;

-- the same goes to tables

CREATE TABLE table1
CHARACTER SET latin1;

ALTER TABLE table1
CHARACTER SET latin1;

    
    
    