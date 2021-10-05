USE sql_store;

SELECT 	COUNT(customers.first_name) AS 'number of customers', 
		SUM(points) AS total_points, 
        state
FROM customers
GROUP BY state
HAVING total_points > 3000;