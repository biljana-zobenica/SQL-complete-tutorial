USE sql_store;

SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c;

-- With NATURAL JOINs, we let the database guess the natural 
-- connection between two tables. It is known to give an unexpected
-- results, so it's advised to be used carefully.