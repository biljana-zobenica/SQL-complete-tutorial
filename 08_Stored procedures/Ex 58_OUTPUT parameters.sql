DROP PROCEDURE IF EXISTS get_upaid_invoices_for_client;

DELIMITER $$

CREATE PROCEDURE get_upaid_invoices_for_client
(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9, 2)
    -- by default these parameters are input parameters; when we
    -- add OUT it represents output parameters;
)
BEGIN
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id
		AND payment_total = 0;
END $$
DELIMITER ;