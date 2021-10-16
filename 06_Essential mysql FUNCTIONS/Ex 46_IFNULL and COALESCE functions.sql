USE sql_store;
SELECT 
	order_id,
    IFNULL(shipper_id,'Not assigned') AS shipper
FROM orders;

SELECT 
	order_id,
    COALESCE(shipper_id, comments, 'Not assigned') AS shipper
FROM orders;

SELECT 
	CONCAT(first_name, ' ', last_name) AS customer,
    IFNULL(phone, 'Unknown') AS phone
FROM customers;