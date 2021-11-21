EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA';

CREATE INDEX idx_state ON customers (state);

-- Write a query to find customers with more than
-- 1000 points.

EXPLAIN SELECT customer_id
FROM customers
WHERE points > 1000;

CREATE INDEX idx_points ON customers (points);