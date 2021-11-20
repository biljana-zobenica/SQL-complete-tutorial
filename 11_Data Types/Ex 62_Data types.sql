-- MySQL data types:

-- STRINGS
/*
CHAR(x)				fixed-length strings
VARCHAR(x)			variable-length strings -> 50 for short strings and 255 for medium-length strings
MEDIUMTEXT 			max 16MB
LONGTEXT 			max 4GB
TINYTEXT			max 255 bytes
TEXT				max 64KB
*/

-- NUMERIC
/*
INT 				whole number
TINYINT				1b 	[-128, 127]
UNSIGNED TINYINT 		[0, 255] -> particularly convenient for data that shouldn't be negative (ex. age)
SMALLINT			2b	[-32K, 32K]
MEDIUMINT 			3b	[-8M, 8M]
INT					4b	[-2B, 2B]
BIGINT 				8b	[-9Z, 9Z]

ZEROFILL:
INT(4) => 0001

DECIMAL(precision, scale) 	DECIMAL(9, 2) => 1234567.89
DEC
NUMERIC
FIXED
FLOAT		4b
DOUBLE 		8b
*/

-- BOOLEAN 
/*
BOOL
BOOLEAN
UPDATE posts
SET is_published = 1 		# or FALSE
*/

-- ENUM
/*
ENUM ('small', 'medium', 'large') => only these values are allowed to be entered;
SET(...) => set can store multiple values;
*/

-- DATE AND TIME
/*
DATE
TIME
DATETIME		8b
TIMESTAMP		4b (up to 2038) 	when a row was changed or updated;
YEAR
*/

-- BLOB => used to store large binary data such as images, videos, pdfs;
/*
TINYBLOB		255b
BLOB			65KB
MEDIUMBLOB 		16MB
LONGBLOB		4GB
*/

-- SPATIAL
-- JSON => lightwight format for storing and transferring data over the Internet.
