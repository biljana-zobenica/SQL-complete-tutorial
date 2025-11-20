
--> SELF JOIN

-- What is the name of a character's mentor?

SELECT
    chars.name AS character_name,
    mentors.name AS mentor_name
FROM `fantasy.characters` chars
    JOIN `fantasy.characters` mentors
    ON chars.mentor_id = mentors.id

-- A character can use any item for which the power level is equal or
-- greater than the character's experience divided by 100

-- Create a list of all characters and the items that they can use

SELECT
    c.name,
    c.experience / 100,
    i.name,
    i.power
FROM `fantasy.characters` c
    JOIN `fantasy.items` i -- implicit INNER JOIN
    -- using defined condition to join two tables, it will match when ON clause is TRUE
    ON c.experience / 100 >= i.power
    -- optional:
    OR c.class = 'Mage'
ORDER BY c.name;