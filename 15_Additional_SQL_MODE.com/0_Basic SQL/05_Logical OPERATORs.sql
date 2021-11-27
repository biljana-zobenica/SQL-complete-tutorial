/* Here's a quick preview of LOGICAL operators:

* LIKE 		-> allows you to match similar values, instead of exact values.
* IN 		-> allows you to specify a list of values you'd like to include.
* BETWEEN 	-> allows you to select only rows within a certain range.
* IS NULL 	-> allows you to select rows that contain no data in a given column.
* AND 		-> allows you to select only rows that satisfy two conditions.
* OR 		-> allows you to select rows that satisfy either of two conditions.
* NOT 		-> allows you to select rows that do not match a certain condition.
*/

-- LIKE

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" LIKE 'Snoop%';

/* Note: "group" appears in quotations above because GROUP is actually the name
 of a function in SQL. The double quotes (as opposed to single: ') are a way of
 indicating that you are referring to the column name "group", not the SQL function.
 In general, putting double quotes around a word or phrase will indicate that you 
 are referring to that column name. */
 
 /* The % used above represents any character or set of characters. In this case,
 % is referred to as a "wildcard." LIKE is case-sensitive, meaning that the above
 query will only capture matches that start with a capital "S" and lower-case "noop."
 To ignore case when you're matching values, you can use the ILIKE command. In MySQL, 
 we use LOWERCASE of the column before comparison, since ILIKE doesn't exist. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE LOWER("group") LIKE 'snoop%';
 
/* You can also use _ (a single underscore) to substitute for an individual character. */
 
/* Write a query that returns all rows for which Ludacris was a member of the group. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE LOWER(artist) LIKE '%ludacris%'; 

/* Write a query that returns all rows for which the first artist listed in the group 
has a name that begins with "DJ". */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" LIKE 'DJ%'; 

-- IN

/* As with comparison operators, you can use non-numerical values, but they need to go
 inside single quotes. Regardless of the data type, the values in the list must be 
 separated by commas. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist IN ('Taylor Swift', 'Usher', 'Ludacris');

/* Write a query that shows all of the entries for Elvis and M.C.Hammer.

 Hint: M.C. Hammer is actually on the list under multiple names, so you may
 need to first write a query to figure out exactly how M.C. Hammer is listed.
 You're likely to face similar problems that require some exploration in many
 real-life scenarios. */
 
SELECT DISTINCT "group"
FROM tutorial.billboard_top_100_year_end
WHERE LOWER("group") LIKE '%hammer%';

SELECT DISTINCT "group"
FROM tutorial.billboard_top_100_year_end
WHERE LOWER("group") LIKE '%elvis%';
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" IN ('Elvis Presley', 'M.C. Hammer', 'Hammer');

-- BETWEEN

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank BETWEEN 5 AND 10;
-- the same result:
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank >= 5 AND year_rank <= 10;

/* Write a query that shows all top 100 songs 
from January 1, 1985 through December 31, 1990. */

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year >= 1985 AND year <= 1990;
-- the same result:
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year BETWEEN 1985 AND 1990;

-- IS NULL

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist IS NULL;

/* WHERE artist = NULL will not work—you can't perform arithmetic on null values. */

/* Write a query that shows all of the rows for which song_name is null. */

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name IS NULL;

-- AND

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012 AND year_rank <= 10;

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012
   AND year_rank <= 10
   AND "group" LIKE '%feat%';

/* Write a query that surfaces all rows for top-10
 hits for which Ludacris is part of the Group. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" LIKE '%ludacris%'
	AND year_rank <= 10;
 
/* Write a query that surfaces the top-ranked records
 in 1990, 2000, and 2010. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year IN (1990, 2000, 2010)
	AND year_rank = 1;
 
/* Write a query that lists all songs from the 1960s 
with "love" in the title. */

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year BETWEEN 1960 AND 1969
	AND song_name LIKE '%love%';

-- OR

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank = 5 OR artist = 'Gotye';

SELECT *
FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND ("group" LIKE '%macklemore%' OR "group" LIKE '%timberlake%');

/* Write a query that returns all rows for top-10 songs
 that featured either Katy Perry or Bon Jovi. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
 WHERE year_rank <= 10
   AND ("group" LIKE '%katy perry%' OR "group" LIKE '%bon jovi%');

/* Write a query that returns all songs with titles that
 contain the word "California" in either the 1970s or 1990s. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
 WHERE song_name LIKE '%california%'
        AND (year BETWEEN 1970 AND 1979 OR year BETWEEN 1990 AND 1999);
 
/* Write a query that lists all top-100 recordings that feature
 Dr. Dre before 2001 or after 2009. */

SELECT *
FROM tutorial.billboard_top_100_year_end
 WHERE artist LIKE '%dr.dre%'
	AND (year <= 2001 OR year >= 2009);
    
-- NOT

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
	AND year_rank NOT BETWEEN 2 AND 3;
    
/* Using NOT with < and > usually doesn't make sense because
 you can simply use the opposite comparative operator instead. 
 NOT is commonly used with LIKE. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
	AND "group" NOT LIKE '%macklemore%';
    
/* NOT is also frequently used to identify non-null rows, but the 
syntax is somewhat special—you need to include IS beforehand. */

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
	AND artist IS NOT NULL;
    
/* Write a query that returns all rows for songs that were on the 
charts in 2013 and do not contain the letter "a". */

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
	AND song_name NOT LIKE '%a%';

 