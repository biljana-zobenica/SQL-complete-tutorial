
--> AGGREGATION -> SUM, AVG, MIN, MAX, COUNT -> STRING_AGG is used on top of text data types
--> Official documentation link: https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions

SELECT
    -- using AGGREGATION functions on top of NUMERIC data types
    SUM(level),
    AVG(level),
    MIN(level),
    MAX(level) AS max_level,
    COUNT(level),
    MAX(experience * level) / 2 AS max_experience,
    -- using AGGREGATION functions on top of STRING data types
    COUNT(class),
    MIN(class),
    MAX(class),
    STRING_AGG(class, ",")
FROM `fantasy.characters`;

--> Common error is lacking GROUP BY in the query after applying AGGREGATION functions,
-- since SQL can not handle mismatch of different number of rows between columns within 1 table.
-- The reason behind is, as a rule, every SQL query needs to return a table. A table is a series
-- of columns where each column has the same number of values. This can be solved with WINDOW functions.

SELECT
    name,
    level,
    AVG(level)
FROM `fantasy.characters`;

--> COUNT(*) counts the number of rows that table has.

SELECT
    COUNT(*)
FROM `fantasy.characters`
WHERE is_alive = TRUE;