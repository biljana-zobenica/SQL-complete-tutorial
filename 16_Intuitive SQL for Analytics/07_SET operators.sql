
--> SET operators:

-- UNION -> stack tables. The name is UNION since it comes from sets mathematical theory, the idea is that a table is a set of rows.
-- UNION ALL -> unions two datasets, on top of each other, regardless of whether there are duplicates or not. Intersection between two datasets is counted twice.
-- UNION DISTINCT -> unions two datasets, keeping only UNIQUE records, dropping duplicates, intersection is used only uniquely (not twice).
-- INTERSECT DISTINCT -> only the UNIQUE rows that are shared between two tables.
-- EXCEPT DISTINCT -> all rows in A except the rows that are shared with B table.
-- Unlike UNION and INTERSECT, EXCEPT is asymmetric, so the order of A/B table is important.

-- Official documentation link: https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#set_operators

SELECT
    *
FROM `fantasy.characters_alive`
UNION ALL
SELECT
    *
FROM `fantasy.characters_dead`;