CREATE TABLE orders_archived AS
SELECT * FROM orders;

TRUNCATE TABLE orders_archived;

-- use a subquery in insert into statement to fill in the table
INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01';

-- use a JOIN subquery in insert into statement to fill in the table
USE sql_invoicing;
DROP TABLE invoices_archived;

CREATE TABLE invoices_archived AS
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date
FROM invoices i 
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;