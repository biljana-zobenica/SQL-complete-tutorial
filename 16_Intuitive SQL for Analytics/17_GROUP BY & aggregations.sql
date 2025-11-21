
--> GROUP BY and Aggregations

-- grouping field = dimensions
-- aggregate field = measures

-- Maximum value of level per each class?
-- GROUP BY level by class:

SELECT
    class,
    MAX(level) AS max_level,
    MIN(level) AS min_level,
    COUNT(*) AS n_values,
    AVG(level) AS avg_level,
    MAX(health) AS max_health,
    MIN(experience) AS min_experience,
    AVG(LENGTH(name)) AS avg_name_length
FROM `fantasy.characters`
GROUP BY class;

-- level on top of the table:

SELECT
    MAX(level)
FROM `fantasy.characters`;

--> Using multiple grouping fields
-- Average power by item type and rarity combination?

SELECT
    item_type,
    AVG(`power`) AS avg_power -- POWER is a SQL function, using `` says it's the name of the table;
FROM `fantasy.items`
GROUP BY item_type;

-- Within each item_type, average power grows with the level of rarity;

-- Include name level too, but keep the level of aggregation?

SELECT
    ARRAY_AGG(name) AS names, -- aggregation of STRINGs
    MIN(name) AS first_name,  -- gives the first name in alphabetical order
    MAX(name) AS last_name,   -- gives the last name in alphabetical order
    item_type,
    AVG(`power`) AS avg_power_by_type -- POWER is a SQL function, using `` says it's the name of the table;
FROM `fantasy.items`
GROUP BY item_type;

--> LAW OF GROUPING

-- After a GROUP BY I can only select:
-- 1 - Grouping fields (columns that I listed in GROUP BY)
-- 2 - Aggregations of other fields