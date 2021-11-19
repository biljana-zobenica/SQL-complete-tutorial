DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	/* IF state IS NULL THEN
		SELECT * FROM clients;
	ELSE 
		SELECT * FROM clients c
		WHERE c.state = state;
		-- SET state = 'CA';
	END IF; */
    -- cleaner code:
    SELECT * FROM clients c
    WHERE c.state = IFNULL(state, c.state);
    
END $$
DELIMITER ;

-- Write a stored procedure to return invoices
-- for a given client
-- 
-- get_invoices_by_client

DROP PROCEDURE IF EXISTS get_invoices_by_client;

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client
(
	client_id INT
)
BEGIN
	SELECT * FROM invoices i
    WHERE i.client_id = client_id;
END $$
DELIMITER ;

-- Write a stored procedure called get_payments
-- with two parameters
--
-- client_id => INT
-- payment_method_id => TINYINT

DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments
(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN
	SELECT * FROM payments p
    WHERE p.client_id = IFNULL(client_id, p.client_id) AND
		p.payment_method = IFNULL(payment_method_id, p.payment_method);
END $$
DELIMITER ;
