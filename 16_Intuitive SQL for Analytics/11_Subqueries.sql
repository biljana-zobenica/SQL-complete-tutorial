
--> SUBQUERIES

-- Find characters whose experience is between MIN and MAX;
-- More experience than the least experienced character, less than the most experienced character

SELECT
    name,
    experience
FROM `fantasy.characters`
WHERE experience > MIN(experience);

--> UNCORRELATED subquery

SELECT
    name,
    experience
FROM `fantasy.characters`
WHERE experience > (
  -- 2100
  SELECT MIN(experience)
  FROM `fantasy.characters`
)
AND experience < (
  -- 15000
  SELECT MAX(experience)
  FROM `fantasy.characters`
);

-- Find the difference between a character's experience and their mentor's;

--> CORRELATED subquery

SELECT
  id AS mentee_id,
  mentor_id,
  experience AS mentee_experience,
  (
    SELECT
        experience
    FROM `fantasy.characters` AS mentor_table
    WHERE id = mentee_table.mentor_id
  ) AS mentor_experience
FROM `fantasy.characters` AS mentee_table
WHERE mentor_id IS NOT NULL;
-- final query solution:
SELECT
  id AS mentee_id,
  mentor_id,
  (
    SELECT
        experience
    FROM `fantasy.characters` AS mentor_table
    WHERE id = mentee_table.mentor_id
  ) - experience AS experience_difference
FROM `fantasy.characters` AS mentee_table
WHERE mentor_id IS NOT NULL;