USE sql_store;

SELECT 	COUNT(customers.first_name) AS 'number of customers', 
		SUM(points) AS 'total points', 
        state
FROM customers
GROUP BY state;

-- use GROUP BY within the code of joined tables + subquery

SELECT 
	COUNT(c.customer_id),
    c.state
FROM customers c
JOIN orders o
	USING (customer_id)
WHERE o.status = (
		SELECT order_status_id
        FROM order_statuses
        WHERE name = 'Processed'
)
GROUP BY c.state;