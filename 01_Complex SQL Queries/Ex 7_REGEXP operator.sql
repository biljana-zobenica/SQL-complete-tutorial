SELECT *
FROM customers
-- WHERE last_name LIKE '%field';
WHERE last_name REGEXP 'field';
-- ^ beginning
-- $ end
-- | logical or
-- [abcd] to make optional characters
-- [a-f] array

-- Get the customers whose
-- first names are ELKA or AMBUR
SELECT *
FROM customers
WHERE 	first_name REGEXP 'elka|ambur';

-- last names end with EY or ON
SELECT *
FROM customers
WHERE 	last_name REGEXP 'EY$|ON$';

-- last names start with MY or contains SE
SELECT *
FROM customers
WHERE 	last_name REGEXP '^MY|SE';

-- last names contain B followed by R or U
SELECT *
FROM customers
WHERE 	last_name REGEXP 'b[ru]';

