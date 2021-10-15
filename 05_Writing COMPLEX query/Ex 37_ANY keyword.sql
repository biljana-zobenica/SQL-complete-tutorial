-- Select products that were sold by
-- the unit (quantity = 1)

USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
);

-- Select clients with at least two invoices

SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(*) >= 2
);

/* 
NOTE: the difference between ANY and ALL keyword:
ANY means that the condition will be satisfied if the 
operation is true for any of the values in the range. 
ALL means that the condition will be satisfied only if 
the operation is true for all values in the range. 
*/