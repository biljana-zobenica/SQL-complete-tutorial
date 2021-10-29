/* If the view doesn't have the following words:
-- DISTINCT
-- Aggregate Functions (MIN, MAX, SUM)
-- GROUP BY / HAVING
-- UNION
we consider it as an updateable view */

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;
-- this option doesn't allow the view to be updated in case the update change 
-- would exclude the row afterwards;

DELETE FROM invoices_with_balance
WHERE invoice_id = 1;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2;

-- check the check option
UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3;
-- 15:32:51	UPDATE invoices_with_balance SET payment_total = invoice_total WHERE invoice_id = 3	Error Code: 1369. CHECK OPTION failed 'sql_invoicing.invoices_with_balance'	0.000 sec

