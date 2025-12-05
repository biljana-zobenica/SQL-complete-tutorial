
--> CASE clause -> used for bucketing of the data.

-- It is used for conditional logic of creating new columns with values depending on the other column within the table.

SELECT
    name,
    level,
    -- level >= 20 AS level_at_least_20 -- basic level of bucketing by defining 2 buckets with true/false values
    -- up to lvl 15: low
    -- between 15 and 25: mid
    -- above 25: super
    CASE
        WHEN level < 15 THEN 'low'
        WHEN level < 25 THEN 'mid' -- can be omitted: level >= 15 AND
    ELSE 'super' -- can replace: WHEN level >= 25 THEN
    -- if we would delete ELSE clause, it would show null value in other cases then specified above;
    -- ELSE NULL is default behaviour, when it's not specified
    END AS level_bucket
FROM `fantasy.characters`
WHERE is_alive = TRUE;

-- example: level = 30
-- WHEN 30 < 15 THEN 'low' -- FALSE
-- WHEN 30 >= 15 AND 30 < 25 THEN 'mid' -- TRUE AND FALSE = FALSE
-- WHEN 30 >= 25 THEN 'super' -- TRUE

--> CASE clause can take numbers as well for creating buckets;
--> NOTE: it's not possible to mix data types within CASE clause (e.g. 'low', 2...)

SELECT
    name,
    level,
    CASE
        WHEN level < 15 THEN 1
        WHEN level < 25 THEN 2
    ELSE 3
    END AS level_bucket
FROM `fantasy.characters`
WHERE is_alive = TRUE;