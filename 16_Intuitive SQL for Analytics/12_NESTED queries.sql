
--> NESTED queries

-- Avoid using alias - impractical and not recommended to repeat code like this:

SELECT
    name,
    level,
    CASE
        WHEN class = 'Mage' THEN level * 0.5
        WHEN class IN ('Archer', 'Warrior') THEN level * 0.75
        ELSE level * 1.5
    END AS power_level
FROM `fantasy.characters`
-- WHERE power_level >= 15;
WHERE CASE
        WHEN class = 'Mage' THEN level * 0.5
        WHEN class IN ('Archer', 'Warrior') THEN level * 0.75
        ELSE level * 1.5
      END >= 15;

-- Using subquery in FROM clause:

-- OUTER query
SELECT
    *
FROM
-- INNER query
(SELECT
    name,
    level,
    CASE
        WHEN class = 'Mage' THEN level * 0.5
        WHEN class IN ('Archer', 'Warrior') THEN level * 0.75
        ELSE level * 1.5
    END AS power_level
FROM `fantasy.characters`)
WHERE power_level >= 15;

--> using ADDITIONAL subquery in FROM clause:

-- OUTER query
SELECT
    *
FROM
-- INNER query 1
(
SELECT
    name,
    level,
    CASE
        WHEN class = 'Mage' THEN level * 0.5
        WHEN class IN ('Archer', 'Warrior') THEN level * 0.75
        ELSE level * 1.5
    END AS power_level
FROM (
-- INNER query 2
    SELECT
        *
    FROM `fantasy.characters`
    WHERE is_alive = true
    )
)
WHERE power_level >= 15;