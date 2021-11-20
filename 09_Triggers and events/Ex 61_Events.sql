-- EVENTS
-- A task (or block of SQL code) that gets executed according to a schedule;
-- We use events to automate db maintenance tasks;

DELIMITER $$

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;

CREATE EVENT yearly_delete_tale_audit_rows
ON SCHEDULE 
	-- AT '2019-05-01' -> this is when an event is done only once;
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
    
    -- DATEADD (NOW(), INTERVAL -1 YEAR) or:
    -- DATESUB (NOW(), INTERVAL 1 YEAR)
END $$

DELIMITER ;

SHOW EVENTS LIKE 'yearly%';
ALTER EVENT yearly_delete_tale_audit_rows DISABLE; -- afterwards, we can set ENABLE status;
