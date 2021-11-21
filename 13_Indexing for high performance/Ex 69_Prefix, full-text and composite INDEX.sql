-- PREFIX Indexes
CREATE INDEX idx_lastname ON customers (last_name(20));

SELECT 
	COUNT(DISTINCT LEFT(last_name, 1)),
	COUNT(DISTINCT LEFT(last_name, 5)),
	COUNT(DISTINCT LEFT(last_name, 10))
FROM customers;

-- FULL-TEXT Indexes
CREATE FULLTEXT INDEX idx_title_body ON posts (title, body);
 -- in natural mode
SELECT *
FROM posts
WHERE MATCH (title, body) AGAINST('react redux');
 -- in boolean mode
SELECT *, MATCH (title, body) AGAINST('react redux') -- this is relevancy factor (from 0 to 1)
FROM posts
WHERE MATCH (title, body) AGAINST('react -redux +form' IN BOOLEAN MODE);

SELECT *, MATCH (title, body) AGAINST('react redux') -- this is relevancy factor (from 0 to 1)
FROM posts
WHERE MATCH (title, body) AGAINST('"handling a form"' IN BOOLEAN MODE);

-- COMPOSITE Indexes
USE sql_store;
SHOW INDEXES IN customers;

CREATE INDEX idx_state_points ON customers (state, points); 
-- put the most frequently used columns first
-- put the column with higer cardinality first

EXPLAIN SELECT customer_id 
FROM customers
WHERE state = 'CA' 
	AND points > 1000;
    
DROP INDEX idx_state ON customers;
DROP INDEX idx_points ON customers;

EXPLAIN SELECT customer_id
FROM customers
WHERE state = 'CA' AND last_name LIKE 'A%';

SELECT 
	COUNT(DISTINCT state),
    COUNT(DISTINCT last_name)
FROM customers;

CREATE INDEX idx_lastname_state ON customers (last_name, state); 


