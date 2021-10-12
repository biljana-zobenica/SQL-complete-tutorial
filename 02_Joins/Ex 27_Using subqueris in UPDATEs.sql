USE sql_invoices;

-- inputing where client_id is a single number
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date 
WHERE client_id =
			(SELECT client_id
            FROM clients
            WHERE name = 'Myworks');

-- inputing where client_id is multiple numbers
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date 
WHERE client_id IN
            (SELECT client_id
            FROM clients
            WHERE state IN ('CA','NY'));
            
-- find the gold customers and add comments for them

USE sql_store;

UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
			(SELECT DISTINCT c.customer_id
			FROM orders o
			JOIN customers c
				USING (customer_id)
			WHERE c.points > 3000);
            
UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
			(SELECT customer_id
			FROM customers
			WHERE points > 3000);
