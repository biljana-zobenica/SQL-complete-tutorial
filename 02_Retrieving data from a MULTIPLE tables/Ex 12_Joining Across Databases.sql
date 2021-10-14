-- joining across databases
-- depending on the current database in use, 
-- we need to add "dbo.table" to specify where
-- the table actually is.

USE sql_inventory;

SELECT *
FROM sql_store.order_items oi
JOIN products p
	ON oi.product_id = p.product_id;