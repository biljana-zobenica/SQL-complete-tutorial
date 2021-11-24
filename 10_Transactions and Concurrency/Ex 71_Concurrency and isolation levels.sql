/* 
Database concurrency is the ability of a database to allow multiple 
users to affect multiple transactions. This is one of the main properties
that separates a database from other forms of data storage, like spreadsheets.

Concurrency problems:
1. lost updates
2. dirty reads
3. non-repeating reads
4. phantom reads
*/

SHOW VARIABLES LIKE 'transaction_isolation';
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- only for the current session;
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- set it globally;

-- ISOLATION LEVELS --
-- 1. READ UNCOMMITTED - the lowest isolation level with all concurrency problems;
-- 2. READ COMMITTED - here we don't have dirty reads, but do have unrepeatable or inconsistent reads.
-- 3. REPEATABLE READ - this is the DEFAULT isolation level in mysql, which solves most of the concurrency problems (not phantom reads);
-- 4. SERIALIZABLE - solves all concurrency problems, but has more locks, recourses which can hurt performances and reliability.
