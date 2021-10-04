USE sql_store;

SELECT 
	o.order_id,
    c.first_name
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id;
    -- when id columns are named in the same way, we can make the code
    -- shorter and cleaner by using the USING clause
    USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id);
    
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	-- ON oi.order_id = oin.order_Id AND
	-- oi.product_id = oin.product_id;
	USING (order_id, product_id);
    
-- By using the sql_payments database, select the payments and retrieve the following
-- columns: date, client, amount and name

USE sql_invoicing;

SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS 'payment method'
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method;