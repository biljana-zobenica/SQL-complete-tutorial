SELECT LENGTH('sky');
SELECT UPPER('sky');
SELECT LOWER('sky');
SELECT LTRIM('    sky');
SELECT RTRIM('sky    ');
SELECT TRIM('sky'   );
SELECT LEFT('Kindergarten', 4);
SELECT RIGHT('Kindergarten', 6);
SELECT SUBSTRING('Kindergarten', 3, 5);
SELECT SUBSTRING('Kindergarten', 3);
SELECT LOCATE('N', 'Kindergarten');
SELECT LOCATE('q', 'Kindergarten');
SELECT LOCATE('garten', 'Kindergarten');
SELECT REPLACE('Kindergarten', 'garten', 'garden');
SELECT CONCAT('first', 'last');

USE sql_store;
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;