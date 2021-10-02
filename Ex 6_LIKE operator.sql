SELECT *
FROM sql_store.customers
WHERE last_name LIKE 'b%';

-- % any number of characters
-- _ single character

-- Get the customers whose
-- addresses contain TRAIL or AVENUE
-- phone numbers ending with 9

SELECT *
FROM sql_store.customers
WHERE 	address LIKE '%trail%' OR 
		address LIKE '%avenue%';

SELECT *
FROM sql_store.customers
WHERE phone LIKE '%9';

