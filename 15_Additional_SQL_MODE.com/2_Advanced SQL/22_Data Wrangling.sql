/* Data wrangling (or munging) is the process of programmatically
 transforming data into a format that makes it easier to work with. */
 
 -- Using SQL String Functions to Clean Data
 -- Cleaning strings
 
 -- LEFT(string, number of characters), RIGHT does the same, but from the right side;
 -- The LENGTH function returns the length of a string.
 
SELECT incidnt_num,
       date,
       LEFT(date, 10) AS cleaned_date
FROM tutorial.sf_crime_incidents_2014_01;

SELECT incidnt_num,
       date,
       LEFT(date, 10) AS cleaned_date,
       RIGHT(date, 17) AS cleaned_time
FROM tutorial.sf_crime_incidents_2014_01;
-- or:
SELECT incidnt_num,
       date,
       LEFT(date, 10) AS cleaned_date,
       RIGHT(date, LENGTH(date) - 11) AS cleaned_time
FROM tutorial.sf_crime_incidents_2014_01;

/* When using functions within other functions, it's important to remember that the innermost
 functions will be evaluated first, followed by the functions that encapsulate them. */

-- TRIM function

-- The TRIM function is used to remove characters from the beginning and end of a string.
 
SELECT location,
       TRIM(both '()' FROM location)
FROM tutorial.sf_crime_incidents_2014_01;
 
 /* The TRIM function takes 3 arguments. First, you have to specify whether you want to
 remove characters from the beginning ('leading'), the end ('trailing'), or both ('both',
 as used above). Next you must specify all characters to be trimmed. Any characters included
 in the single quotes will be removed from both beginning, end, or both sides of the string.
 Finally, you must specify the text you want to trim using FROM. */
 
 -- POSITION and STRPOS
 
 /* POSITION allows you to specify a substring, then returns a numerical value equal to the
 character number (counting from left) where that substring first appears in the target string.
 It's case-sensitive: */
 
SELECT incidnt_num,
       descript,
       POSITION('A' IN descript) AS a_position
FROM tutorial.sf_crime_incidents_2014_01;
 -- or, by using STRPOS:
SELECT incidnt_num,
       descript,
       STRPOS(descript, 'A') AS a_position
FROM tutorial.sf_crime_incidents_2014_01;
 
 /* Importantly, both the POSITION and STRPOS functions are case-sensitive. If you want to look 
 for a character regardless of its case, you can make your entire string a single by using the
 UPPER or LOWER functions. */
 
 -- SUBSTR
 
 /* LEFT and RIGHT both create substrings of a specified length, but they only do so starting
 from the sides of an existing string. If you want to start in the middle of a string, you can
 use SUBSTR. The syntax is SUBSTR(*string*, *starting character position*, *# of characters*): */
 
SELECT incidnt_num,
       date,
       SUBSTR(date, 4, 2) AS day
FROM tutorial.sf_crime_incidents_2014_01;
 
 /* Write a query that separates the `location` field into separate fields for latitude and 
 longitude. You can compare your results against the actual `lat` and `lon` fields in the table. */
 
 SELECT location,
		LEFT(TRIM(both '()' FROM location), 8) AS lattitude,
        SUBSTR(TRIM(both '()' FROM location), 18, 9) AS longitude
 FROM tutorial.sf_crime_incidents_2014_01;
 -- or:
SELECT location,
		TRIM(leading '(' FROM LEFT(location, POSITION(',' IN location) -1)) 
			AS lattitude,
        TRIM(trailing ')' FROM RIGHT(location, LENGTH(location) - POSITION(',' IN location))) 
			AS longitude
FROM tutorial.sf_crime_incidents_2014_01;
 
 -- CONCAT 
 
 /* You can combine strings from several columns together (and with hard-coded values) using CONCAT.*/
 
SELECT incidnt_num,
       day_of_week,
       LEFT(date, 10) AS cleaned_date,
       CONCAT(day_of_week, ', ', LEFT(date, 10)) AS day_and_date
FROM tutorial.sf_crime_incidents_2014_01;

/* Concatenate the lat and lon fields to form a field that is equivalent to the location field. (Note 
that the answer will have a different decimal precision.) */


 
 
 