
-- ORDER BY -> order the results. It's not done by default since optimization of querying is priority.

-- LIMIT -> return top N rows. It will look at the final results and limit it to defined number of rows.

-- LIMIT vs. WHERE? -> LIMIT doesn't affect the query computation, it only shows limited results.
-- If we want to query less data, we should focus and use WHERE filter (which drops or eliminate rows
-- in the first steps of query computation). LIMIT is executed the last.

SELECT
    name,
    class,
    level
FROM `fantasy.characters`
WHERE is_alive = TRUE
ORDER BY level
LIMIT 5;