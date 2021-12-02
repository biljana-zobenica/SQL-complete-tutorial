/* A window function performs a calculation across a set of
 table rows that are somehow related to the current row. */
 
SELECT duration_seconds,
       SUM(duration_seconds) OVER (ORDER BY start_time) AS running_total
FROM tutorial.dc_bikeshare_q1_2012;

/* You can see that the above query creates an aggregation (running_total)
 without using GROUP BY. The first part of the above aggregation, SUM(duration_seconds),
 looks a lot like any other aggregation. Adding OVER designates it as a window function.
 You could read the above aggregation as "take the sum of duration_seconds over the 
 entire result set, in order by start_time." 
 
 If you'd like to narrow the window from the entire dataset to individual groups within the 
 dataset, you can use PARTITION BY to do so:*/

SELECT start_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER
         (PARTITION BY start_terminal ORDER BY start_time)
         AS running_total
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08';

/* The above query groups and orders the query by start_terminal. Within each value of 
start_terminal, it is ordered by start_time, and the running total sums across the current
 row and all previous rows of duration_seconds. Scroll down until the start_terminal value
 changes and you will notice that running_total starts over. That's what happens when you
 group using PARTITION BY.*/
 
 /* The ORDER and PARTITION define what is referred to as the "window"—the ordered subset
 of data over which calculations are made.
Note: You can't use window functions and standard aggregations in the same query. More 
specifically, you can't include window functions in a GROUP BY clause. */

/* Write a query that shows a running total of the duration of bike rides (similar to the
 last example), but grouped by end_terminal, and with ride duration sorted in descending order.*/
 
SELECT end_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER
         (PARTITION BY end_terminal ORDER BY duration_seconds DESC)
         AS running_total
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08';
 
 -- ROW_NUMBER() does just what it sounds like—displays the number of a given row.
 
SELECT start_terminal,
       start_time,
       duration_seconds,
       ROW_NUMBER() OVER (ORDER BY start_time)
                    AS row_number
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08';
 
 -- Using the PARTITION BY clause will allow you to begin counting 1 again in each partition.
 
SELECT start_terminal,
       start_time,
       duration_seconds,
       ROW_NUMBER() OVER (PARTITION BY start_terminal
                          ORDER BY start_time)
                    AS row_number
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08';

/* RANK() is slightly different from ROW_NUMBER(). If you order by start_time, for example,
 it might be the case that some terminals have rides with two identical start times. In this
 case, they are given the same rank, whereas ROW_NUMBER() gives them different numbers. */
 
SELECT start_terminal,
       duration_seconds,
       RANK() OVER (PARTITION BY start_terminal
                    ORDER BY start_time)
              AS rank
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08';

/* You can also use DENSE_RANK() instead of RANK() depending on your application. Imagine a 
situation in which three entries have the same value. Using either command, they will all get
 the same rank. For the sake of this example, let's say it's "2." Here's how the two commands
 would evaluate the next results differently:

-- RANK() would give the identical rows a rank of 2, then skip ranks 3 and 4, so the next result
 would be 5;
-- DENSE_RANK() would still give all the identical rows a rank of 2, but the following row would
 be 3—no ranks would be skipped.*/
 
 /* Write a query that shows the 5 longest rides from each starting terminal, ordered by terminal,
 and longest to shortest rides within each terminal. Limit to rides that occurred before Jan. 8, 2012.*/
 
SELECT *
FROM 
		(SELECT start_terminal,
					   start_time,
					   duration_seconds AS trip_time,
					   RANK() OVER (PARTITION BY start_terminal 
					   ORDER BY duration_seconds DESC) AS rank
		FROM tutorial.dc_bikeshare_q1_2012
		WHERE start_time < '2012-01-08') sub
WHERE sub.rank <= 5;

-- NTILE

/* You can use window functions to identify what percentile (or quartile, or any other subdivision)
 a given row falls into. The syntax is NTILE(*# of buckets*). In this case, ORDER BY determines which
 column to use to determine the quartiles (or whatever number of 'tiles you specify).*/
 
SELECT start_terminal,
       duration_seconds,
       NTILE(4) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds)
          AS quartile,
       NTILE(5) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds)
         AS quintile,
       NTILE(100) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds)
         AS percentile
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
ORDER BY start_terminal, duration_seconds;

-- LAG and LEAD

/* You can use LAG or LEAD to create columns that pull values from other
 rows—all you need to do is enter which column to pull from and how many
 rows away you'd like to do the pull. LAG pulls from previous rows and LEAD
 pulls from following rows: */
 
SELECT start_terminal,
       duration_seconds,
       LAG(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds) AS lag,
       LEAD(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds) AS lead
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
ORDER BY start_terminal, duration_seconds;

-- This is especially useful if you want to calculate differences between rows:

SELECT start_terminal,
       duration_seconds,
       duration_seconds -LAG(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds)
         AS difference
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
ORDER BY start_terminal, duration_seconds;

/* The first row of the difference column is null because there is no previous
 row from which to pull. Similarly, using LEAD will create nulls at the end of
 the dataset. If you'd like to make the results a bit cleaner, you can wrap it
 in an outer query to remove nulls:*/
 
SELECT *
FROM 
		(SELECT start_terminal,
				   duration_seconds,
				   duration_seconds -LAG(duration_seconds, 1) OVER
					 (PARTITION BY start_terminal ORDER BY duration_seconds)
					 AS difference
		FROM tutorial.dc_bikeshare_q1_2012
		WHERE start_time < '2012-01-08'
		ORDER BY start_terminal, duration_seconds) sub
WHERE sub.difference IS NOT NULL;

-- Defining a window alias

/* If you're planning to write several window functions in to the same query,
 using the same window, you can create an alias. Take the NTILE example above.
 It can be rewritten as: */

SELECT start_terminal,
       duration_seconds,
       NTILE(4) OVER ntile_window AS quartile,
       NTILE(5) OVER ntile_window AS quintile,
       NTILE(100) OVER ntile_window AS percentile
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
WINDOW ntile_window AS
         (PARTITION BY start_terminal ORDER BY duration_seconds)
ORDER BY start_terminal, duration_seconds;

-- The WINDOW clause, if included, should always come after the WHERE clause.




