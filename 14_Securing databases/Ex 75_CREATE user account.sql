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