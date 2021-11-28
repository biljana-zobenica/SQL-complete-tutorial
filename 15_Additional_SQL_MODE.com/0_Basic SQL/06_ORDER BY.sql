-- Sorting data with SQL ORDER BY

SELECT *
FROM tutorial.billboard_top_100_year_end
ORDER BY artist;

/* the results are now ordered alphabetically
 from a to z based on the content in the artist
 column. This is referred to as ascending order,
 and it's SQL's default. If you order a numerical
 column in ascending order, it will start with smaller
 (or most negative) numbers, with each successive row
 having a higher numerical value than the previous.
 Here's an example using a numerical column: */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
ORDER BY year_rank DESC; -- in descending order

/* Write a query that returns all rows from 2012,
 ordered by song title from Z to A.*/
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012
ORDER BY song_name DESC;

-- Ordering data by multiple columns

/* This is particularly useful if your data falls into
 categories and you'd like to organize rows by date, for example,
 but keep all of the results within a given category together. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 3
ORDER BY year DESC, year_rank;

/* The results are sorted by the first column mentioned (year), 
then by year_rank afterward. Finally, you can substitute numbers
 for column names in the ORDER BY clause. The numbers will correspond
 to the order in which you list columns in the SELECT clause. */

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 3
ORDER BY 1 DESC, 2;

/* When using ORDER BY with a row limit (either through the check box on
 the query editor or by typing in LIMIT), the ordering clause is executed
 first. This means that the results are ordered before limiting to only a
 few rows, so if you were to order by year_rank, for example, you can be 
 sure that you are getting the lowest values of year_rank in the entire table,
 not just in the first 100 rows of the table. */
 
/* Write a query that returns all rows from 2010 ordered by rank, with artists
 ordered alphabetically for each song. */
 
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2010
ORDER BY year_rank, artist;

/* Write a query that shows all rows for which T-Pain was a group member, ordered
 by rank on the charts, from lowest to highest rank (from 100 to 1). */ 

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" LIKE '%T-Pain%'
ORDER BY year_rank DESC;

/* Write a query that returns songs that ranked between 10 and 20 (inclusive) in 
1993, 2003, or 2013. Order the results by year and rank, and leave a comment on 
each line of the WHERE clause to indicate what that line does */ 

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year IN (1993, 2003, 2013) 		-- select relevant years
	AND year_rank BETWEEN 10 AND 20 	-- limit the rank
ORDER BY year, year_rank;
