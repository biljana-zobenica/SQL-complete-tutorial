-- When indexes are ignored

EXPLAIN SELECT customer_id FROM customers
WHERE state = 'CA' OR points > 1000;

-- to speed up this index, we use UNION and 
-- create an index on the customers' column points;
CREATE INDEX idx_points ON customers (points);
	EXPLAIN 
		SELECT customer_id FROM customers
		WHERE state = 'CA' 
		UNION 
		SELECT customer_id FROM customers
		WHERE points > 1000;
        
EXPLAIN SELECT customer_id FROM customers
WHERE points + 10 > 2010;

-- to speed up the index for this query, we isolate our columns like this:
EXPLAIN SELECT customer_id FROM customers
WHERE points > 2000;