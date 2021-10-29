CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payments`()
BEGIN
	SELECT * FROM payments;
END

-- MySQL Workbench deals with the delimiter change;