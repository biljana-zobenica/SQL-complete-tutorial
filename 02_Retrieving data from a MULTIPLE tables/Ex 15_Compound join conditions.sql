-- Compound join conditions (use with composite primary keys)
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_Id
	AND oi.product_id = oin.product_id;
    
-- Regular inner join code
SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- Implicit join syntax
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;