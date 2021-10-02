SELECT DISTINCT state FROM sql_store.customers;

-- Return all the products
-- name
-- unit price
-- new price (unit price * 1,1)

SELECT 
	name, 
    unit_price AS 'unit price',
    unit_price * 1.1 AS 'new price'
FROM sql_store.products;