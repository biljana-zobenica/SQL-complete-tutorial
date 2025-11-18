
--> DISTINCT clause - how does it work?

SELECT DISTINCT
    class,
    guild
FROM `fantasy.characters`
ORDER BY class, guild;

-- It looks at the columns which you have selected, and then it looks at all the rows, and two rows are duplicate
-- if they have the exact same values on every column that you have selected. Then, duplicate rows are removed
-- and only unique values are preserved. So, just like the WHERE clause/filter, the DISTINCT is a clause that
-- removes certain rows, but it is more strict and less flexible in a sense, it only does one job and that job
-- is to remove duplicate rows based on the selection of columns.