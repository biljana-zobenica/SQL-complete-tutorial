
--> Types of JOINs

-- INNER JOIN
-- LEFT JOIN = symmetrical RIGHT JOIN
-- RIGHT JOIN = symmetrical LEFT JOIN
-- table A LEFT JOIN table B = table B RIGHT JOIN table A;
-- NULLs represent the absence of data;
-- FULL OUTER JOIN = INNER + LEFT + RIGHT JOINs

--> SQL JOINs Visualizer: https://sql-joins.leopard.in.ua/
-- To produce the set of records only in Table A, but not in Table B, it doesn't match with Table B records,
-- we perform LEFT (OUTER) JOIN, then exclude the records we don't want from the right side via a WHERE clause

SELECT
    *
FROM TableA A
    LEFT JOIN TableB B
    ON A.key = B.key
WHERE B.key IS NULL;

-- To produce the set of records unique to Table A and Table B, we perform the FULL OUTER JOIN,
-- then exclude the records we don't want from both sides via a WHERE clause

SELECT
    *
FROM TableA A
    LEFT JOIN TableB B
    ON A.key = B.key
WHERE A.key IS NULL OR B.key IS NULL;

--> ERD -> Entity Relationship Diagram
-- Use DBML to define your database structure
-- Official documentation link: https://docs.dbdiagram.io/dbml/