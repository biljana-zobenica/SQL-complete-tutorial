
--> Order of SQL Clauses

--> Lexical Order: Order in which clauses are written.
--> Logical Order: Order in which the clauses are executed logically.
--> Effective Order: True order of execution after the engine's optimizations.

SELECT
  name,
  guild,
  --> aliasing:
  level AS character_level,
  --> constants:
  1 AS version,
  experience,
  --> calculations:
  experience / 100,
  experience + 100 / level * 2,
  --> functions:
  SQRT(16),
  SQRT(level),
  UPPER(guild)
FROM `fantasy.characters`;

SELECT 'hello', 1, FALSE;