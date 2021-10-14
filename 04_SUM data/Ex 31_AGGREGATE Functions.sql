SELECT 
	MAX(invoice_total) AS highest,
	MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total*1.1) AS total,
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(DISTINCT client_id) AS total_records -- COUNT UNIQUE or DISTINCT values;
	-- COUNT(payment_date) AS count_of_payments,
    -- COUNT(*) AS total_records
FROM invoices
WHERE invoice_date > '2019-07-01';

-- NOTE: aggregate functions only work on non-null values;

-- write a query which will show the total sales and payments for S1 and S2 of 2019,
-- as well as, the total figures;

SELECT 
	'First half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date 
	BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT 
	'Total' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices;