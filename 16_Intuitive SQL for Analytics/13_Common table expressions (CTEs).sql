
--> Common table expressions (CTEs)

WITH characters_alive AS (
    SELECT
        *
    FROM `fantasy.characters`
    WHERE is_alive = TRUE
),

power_level_table AS (
    SELECT
        name,
        level,
            CASE
                WHEN class = 'Mage' THEN level * 0.5
                WHEN class IN ('Archer', 'Warrior') THEN level * 0.75
                ELSE level * 1.5
            END AS power_level
    FROM characters_alive
)

SELECT
    *
FROM power_level_table
WHERE power_level >= 15;

--> SUBQUERY vs. CTEs: every time you need to define new table in your code, you should use CTE.
--> Official dbt tutorial: https://www.getdbt.com/blog/getting-started-with-cte