UPDATE invoices
SET payment_total = 10, payment_date = '2019-01-03'
WHERE invoice_id = 1;

-- restore the data
UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
WHERE invoice_id = 1;

-- update the 3rd id
UPDATE invoices
SET payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE invoice_id = 3;