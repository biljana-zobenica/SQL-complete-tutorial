-- Select clients that have an invoice

SELECT *
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    	FROM invoices
);

SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    	FROM invoices
    	WHERE client_id = c.client_id
);

-- Find the products that have never been ordered

USE sql_store;

SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    	FROM order_items
    	WHERE product_id = p.product_id
);

-- when a subquery returns a lot of data, it
-- is more efficient to use EXISTS operator instead.
