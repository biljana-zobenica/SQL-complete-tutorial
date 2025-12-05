
--> Generate 2 new tables from the characters table:

--> if the table already exists, it won't be recreated:

CREATE TABLE IF NOT EXISTS `fantasy.characters_alive` AS (
  SELECT
    *
  FROM `fantasy.characters`
  WHERE is_alive = TRUE
);

--> removes the table and creates a new one:

CREATE OR REPLACE TABLE `fantasy.characters_dead` AS (
  SELECT
    *
  FROM `fantasy.characters`
  WHERE is_alive = FALSE
);