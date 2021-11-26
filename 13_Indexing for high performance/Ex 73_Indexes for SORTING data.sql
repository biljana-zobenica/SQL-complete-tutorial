-- Using indexes for sorting data

EXPLAIN SELECT customer_id FROM customers 
ORDER BY first_name;
/* 
When we sort by the column which is not included in our index,
we increase the complexity of the background processes of that index.
*/

-- Show MySQL server variables:
SHOW STATUS;
-- Show MySQL server variables associated to a query cost:
SHOW STATUS LIKE 'last_query_cost';

/* If we have an index on these columns a and b, 
here are the options for sorting which won't be 
expensive in terms of background search processes:
-- a
-- a, b
-- a DESC, b DESC
*/