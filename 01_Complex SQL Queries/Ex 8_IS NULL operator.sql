SELECT *
FROM sql_store.customers
WHERE phone IS NULL;

SELECT *
FROM sql_store.customers
WHERE phone IS NOT NULL;

-- Get the orders that are not shipped yet

SELECT *
FROM sql_store.orders
WHERE shipped_date IS NULL;