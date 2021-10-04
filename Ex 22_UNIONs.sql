SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

SELECT name AS full_name
FROM shippers
UNION
SELECT first_name
FROM customers;

-- Define type of customers in three levels, based on points
SELECT 
	c.customer_id,
    c.first_name,
    c.points,
    'Bronze' AS type
FROM customers c
WHERE points < 2000
UNION
SELECT 
	c.customer_id,
    c.first_name,
    c.points,
    'Silver' AS type
FROM customers c
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
	c.customer_id,
    c.first_name,
    c.points,
    'Gold' AS type
FROM customers c
WHERE points > 3000
ORDER BY first_name;