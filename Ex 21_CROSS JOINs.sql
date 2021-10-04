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

-- Do a cross join between shippers and products
-- using the implicit syntax
-- and then using the explicit syntax

-- implicit syntax of CROSS JOIN
SELECT 
	sh.name AS shippers,
    p.name AS products
FROM shippers sh, products p
ORDER BY sh.name;

-- explicit syntax of CROSS JOIN
SELECT 
	sh.name AS shippers,
    p.name AS products
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name;