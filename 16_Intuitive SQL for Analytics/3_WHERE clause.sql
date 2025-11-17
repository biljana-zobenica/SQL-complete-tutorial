
--> WHERE clause = horizontal selection of certain slices of the table

SELECT
    *
FROM `fantasy.characters`
WHERE is_alive = TRUE;

SELECT
    *
FROM `fantasy.characters`
WHERE health > 50
    AND is_alive = TRUE;

SELECT
    name,
    level,
    level / 10 AS level_scaled
FROM `fantasy.characters`
WHERE level / 10 > 3;

SELECT
    name,
    level,
    is_alive,
    mentor_id,
    class
FROM `fantasy.characters`
WHERE (level > 20 AND is_alive = TRUE OR mentor_id IS NOT NULL)
    AND NOT(class IN ('Mage', 'Archer'));

-- level = 12; is_alive = FALSE; mentor_id = 1; class = 'Hobbit'
-- (level > 20 AND is_alive = TRUE OR mentor_id IS NOT NULL) AND NOT(class IN ('Mage', 'Archer')
-- (FALSE AND FALSE OR TRUE) AND NOT(FALSE)
-- (FALSE OR TRUE) AND TRUE
-- TRUE AND TRUE --> TRUE