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

USE sql_store2;
DROP TABLE IF EXISTS customers; -- or CREATE TABLE IF NOT EXISTS customers
CREATE TABLE customers
	(
		customer_id 	INT PRIMARY KEY AUTO_INCREMENT,
		first_name 		VARCHAR(50) NOT NULL,
        points			INT NOT NULL DEFAULT 0,
        email			VARCHAR(255) NOT NULL UNIQUE
	);
    
-- alter a table

ALTER TABLE customers
	ADD last_name 	VARCHAR(50) NOT NULL AFTER first_name,
    ADD city 		VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(55) DEFAULT '',
    DROP points;
    
    
    
    
    
    