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
-- or by using || instead of CONCAT function:
SELECT incidnt_num,
       day_of_week,
       LEFT(date, 10) AS cleaned_date,
       day_of_week || ', ' || LEFT(date, 10) AS day_and_date
  FROM tutorial.sf_crime_incidents_2014_01;

/* Concatenate the lat and lon fields to form a field that is equivalent to the location field. (Note 
that the answer will have a different decimal precision.) */

SELECT CONCAT('(', lat,', ', lon, ')') AS concat_location,
		location
FROM tutorial.sf_crime_incidents_2014_01;

/* Create the same concatenated location field, but using the || syntax instead of CONCAT. */

SELECT ('(' || lat || ', ' || lon || ')') AS concat_location,
		location
FROM tutorial.sf_crime_incidents_2014_01;

/* Write a query that creates a date column formatted YYYY-MM-DD.*/

SELECT  incidnt_num,
		date,
		SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2) AS cleaned_date
FROM tutorial.sf_crime_incidents_2014_01;

-- Changing case with UPPER and LOWER

SELECT incidnt_num,
       address,
       UPPER(address) AS address_upper,
       LOWER(address) AS address_lower
FROM tutorial.sf_crime_incidents_2014_01;

/* Write a query that returns the `category` field, but with the
 first letter capitalized and the rest of the letters in lower-case.*/
 
SELECT 	incidnt_num,
		category,
		CONCAT (UPPER(LEFT(category, 1)), 
				LOWER(SUBSTR(category, 2))) -- third argument is left empty, so it will go till the end;
                AS capitalized_category
FROM tutorial.sf_crime_incidents_2014_01;
-- or:
SELECT incidnt_num,
       category,
       UPPER(LEFT(category, 1)) || 
       LOWER(RIGHT(category, LENGTH(category) - 1)) 
       AS category_cleaned
FROM tutorial.sf_crime_incidents_2014_01;

-- Turning strings into dates

SELECT incidnt_num,
       date,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2))::date AS cleaned_date
FROM tutorial.sf_crime_incidents_2014_01;

/* Write a query that creates an accurate timestamp using 
the date and time columns in tutorial.sf_crime_incidents_2014_01.
 Include a field that is exactly 1 week later as well. */
 
SELECT incidnt_num,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2) || ' ' || time || ':00')::timestamp AS timestamp,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2) || ' ' || time || ':00')::timestamp
        + INTERVAL '1 week' AS timestamp_plus_interval
FROM tutorial.sf_crime_incidents_2014_01;
 
 -- Turning dates into more useful dates
 
SELECT *
FROM tutorial.sf_crime_incidents_cleandate;

/* You've learned how to construct a date field, but what if you want to deconstruct one?
 You can use EXTRACT to pull the pieces apart one-by-one: */
 
 SELECT cleaned_date,
		EXTRACT('year'   FROM cleaned_date) AS year,
		EXTRACT('month'  FROM cleaned_date) AS month,
		EXTRACT('day'    FROM cleaned_date) AS day,
		EXTRACT('hour'   FROM cleaned_date) AS hour,
		EXTRACT('minute' FROM cleaned_date) AS minute,
		EXTRACT('second' FROM cleaned_date) AS second,
		EXTRACT('decade' FROM cleaned_date) AS decade,
		EXTRACT('dow'    FROM cleaned_date) AS day_of_week
 FROM tutorial.sf_crime_incidents_cleandate;
 
 







 
 
 