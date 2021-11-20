-- TRIGGER 
-- A block of SQL code that automatically gets executed
-- before or after an INSERT, UPDATE or DELETE statement.

DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_insert;

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices 
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
END $$

DELIMITER ;

INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1);

-- Create a trigger that gets fired when we
-- delete a payment.
DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_delete;

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices 
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
	INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, OLD.amount, 'Delete', NOW());
END $$

DELIMITER ;

DELETE FROM payments
WHERE payment_id = 9;

SHOW TRIGGERS LIKE 'payments%';
-- Naming convention for triggers:
-- table_before or after_insert or update or delete

USE sql_invoicing;

CREATE TABLE payments_audit
(
	client_id 	INT				NOT NULL,
    date		DATE			NOT NULL,
    amount		DECIMAL(9, 2)	NOT NULL,
    action_type	VARCHAR(50)		NOT NULL,
    action_date	DATETIME		NOT NULL
);

INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1);
DELETE FROM payments
WHERE payment_id = 10;