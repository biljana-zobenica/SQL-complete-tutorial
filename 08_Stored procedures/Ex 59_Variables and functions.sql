-- > USER or session variables
/* MySQL provides a SET and SELECT statement to declare and initialize 
a variable. The user-defined variable name starts with @ symbol. The 
user-defined variables are not case-sensitive such as @name and @NAME; 
both are the same. A user-defined variable declares by one person cannot
 visible to another person.*/
 
SET @invoices_count = 0

-- > LOCAL variable
/* The scope of the local variable is in a stored program block in 
which it is declared. MySQL uses the DECLARE keyword to specify the 
local variable. The DECLARE statement also combines a DEFAULT clause 
to provide a default value to a variable.*/

DROP PROCEDURE IF EXISTS get_risk_factor;

DELIMITER $$

CREATE PROCEDURE get_risk_factor()
BEGIN
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total /  invoices_count * 5;
    
    SELECT risk_factor;
    
-- risk_factor = invoices_total / invoices_count * 5
END $$
DELIMITER ;

-- > USER-DEFINED FUNCTIONS
DROP FUNCTION IF EXISTS get_risk_factor_for_client;
DELIMITER $$

CREATE FUNCTION get_risk_factor_for_client 
(
	client_id INT
)
RETURNS INTEGER
-- Atributes:
-- DETERMINISTIC -- if you give this function the same input parameters, it always returns the same value;
-- MODIFIES SQL DATA
READS SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total /  invoices_count * 5;
    
	RETURN IFNULL(risk_factor, 0);
END $$
DELIMITER ;

SELECT 
	client_id,
    name,
    get_risk_factor_for_client(client_id) AS risk_factor
FROM clients; 


