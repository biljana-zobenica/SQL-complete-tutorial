USE sql_invoicing;

-- create a view
CREATE OR REPLACE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

-- use a view in SQL syntax
SELECT * 
FROM sales_by_client
ORDER BY total_sales DESC;

SELECT * 
FROM sales_by_client
WHERE total_sales > 500;

SELECT * 
FROM sales_by_client
JOIN clients USING (client_id);

-- Create a view to see the balance
-- for each client.
--
-- clients_balance
-- client_id
-- name
-- balance

CREATE VIEW clients_balance AS
SELECT 
	c.client_id,
	c.name,
    SUM(invoice_total - payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

SELECT * FROM clients_balance;