USE sql_store;

SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.Last_name,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- In sql_invoicing database, join payment table with
-- clients and payment_methods table

USE sql_invoicing;

SELECT 
	c.client_id,
    c.name AS 'client name',
    p.invoice_id,
    p.date,
    p.amount,
    p.payment_method,
    pm.name AS 'payment type'
FROM payments p
JOIN clients c
	ON c.client_id = p.client_id
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method;