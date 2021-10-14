SELECT *
FROM sql_store.customers
WHERE state = 'VA';

SELECT *
FROM sql_store.customers
WHERE state != 'VA';

SELECT *
FROM sql_store.customers
WHERE birth_date > '1990-01-01';

-- Get the orders placed this year orders

SELECT * 
FROM sql_store.orders
WHERE order_date >= '2019-01-01';

SELECT *
FROM sql_store.customers
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';

SELECT * 
FROM sql_store.customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);