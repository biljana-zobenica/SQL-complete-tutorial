-- Create a user account
CREATE USER biljana@127.0.0.1 -- with IP
CREATE USER biljana@localhost -- with host
CREATE USER biljana@biljana-zobenica.github.io -- with domain
CREATE USER biljana@'%.biljana-zobenica.github.io' -- with any subdomains

CREATE USER biljana IDENTIFIED BY '1234';

-- View a list of user
SELECT * FROM mysql.user;

-- Dropping users
CREATE USER bob@localhost IDENTIFIED BY '1234';
DROP USER bob@localhost;

-- Change a user password
SET PASSWORD FOR biljana = '1234'; -- or:
SET PASSWORD = '1234'; -- set the password of currently logged user;

-- Granting privileges
-- 1: web/desktop application
CREATE USER bika_app IDENTIFIED BY '1234';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON sql_store.* -- or specify a table name instead of all by *;
TO bika_app;

-- 2: admin
GRANT ALL
ON *.* -- (all tables in all databases)
TO biljana;

-- View privileges
SHOW GRANTS FOR biljana;
SHOW GRANTS; -- for current user

-- Revoke privileges
GRANT CREATE VIEW 
ON sql_store.*
TO bika_app;

REVOKE CREATE VIEW 
ON sql_store.*
FROM bika_app;
