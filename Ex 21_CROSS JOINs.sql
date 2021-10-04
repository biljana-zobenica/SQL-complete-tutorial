USE sql_store;

SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p -- this is the explicit syntax for a cross join
ORDER BY c.first_name;

SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c, products p -- this is the equivalent to the explicit syntax's result
ORDER BY c.first_name;