DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state(state(CHAR(2))
BEGIN
	SELECT * FROM clients;
END $$
DELIMITER ;