SELECT order_id, o.customer_id, first_name, last_name
FROM orders AS o
JOIN customers AS c
	ON o.customer_id = c.customer_id;
    
-- Return order_items table with product_id and product_name columns

SELECT o.order_id, o.product_id, p.name, o.quantity, o.unit_price
FROM sql_store.order_items AS o
JOIN sql_store.products AS p
	ON o.product_id = p.product_id;