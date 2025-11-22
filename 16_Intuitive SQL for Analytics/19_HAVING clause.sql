
--> HAVING clause -> FILTER after GROUP BY is applied

SELECT
    class,
    AVG(experience) AS avg_experience
FROM `fantasy.characters`
-- WHERE avg_experience >= 7000   -- not working: unrecognized name: avg_experience
-- WHERE AVG(experience) >= 7000  -- not working: aggregate function is not allowed in WHERE clause
-- WHERE clause doesn't know about the aggregations that happen later in the logical order of SQL operations
GROUP BY class
HAVING AVG(experience) >= 7000;   -- BigQuery can use avg_experience too! However, not other SQL agents.
-- HAVING AVG(level) >= 20;       -- it can be filtered on the column that is not in SELECT statement, but exists in the table.
-- HAVING clause works on aggregations since it comes after a GROUP BY and aggregations, but still before ALIASes in the logical
-- order of SQL operations;