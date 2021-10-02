SELECT *
FROM sql_store.customers
LIMIT 3;

-- page 1: 1-3
-- page 2: 4-6
-- page 3: 7-9

-- Get the top three loyal customers (the highest points)
SELECT *
FROM sql_store.customers
ORDER BY points DESC
LIMIT 3;