-- COUNT 		-> counts how many rows are in a particular column.
-- SUM 			-> adds together all the values in a particular column.
-- MIN and MAX 	-> return the lowest and highest values in a particular column, respectively.
-- AVG 			-> calculates the average of a group of selected values.

/* ARITHMETIC OPERATORS only perform operations across ROWS. 
AGGREGATE FUNCTIONS are used to perform operations across ENTIRE COLUMNS. 
(which could include millions of rows of data or more). */
 
-- COUNT
-- COUNT is a SQL aggregate function for counting the number of rows in a particular column.

SELECT COUNT(*)
FROM tutorial.aapl_historical_stock_price;

-- Counting individual columns
-- provide a count of all of rows in which the high column is not null.alter

SELECT COUNT(high)
FROM tutorial.aapl_historical_stock_price;

-- Write a query to count the number of non-null rows in the low column.

SELECT COUNT(low)
FROM tutorial.aapl_historical_stock_price;

-- Counting non-numerical columns

SELECT COUNT(date)
FROM tutorial.aapl_historical_stock_price;

/* COUNT simply counts the total number of non-null rows, NOT the distinct values. */

SELECT COUNT(date) AS count_of_date
FROM tutorial.aapl_historical_stock_price;
-- or
SELECT COUNT(date) AS "Count Of Date"
FROM tutorial.aapl_historical_stock_price;

/* Write a query that determines counts of every single column.
 Which column has the most null values? */
 
SELECT 	COUNT(year) AS year,
		COUNT(month) AS month,
        COUNT(open) AS open,
        COUNT(high) AS high,
        COUNT(low) AS low,
        COUNT(close) AS close,
        COUNT(volume) AS volume
FROM tutorial.aapl_historical_stock_price;

-- SUM

 /* SUM is a SQL aggregate function. that totals the values in
 a given column. Unlike COUNT, you can only use SUM on columns
 containing numerical values. */
 
SELECT SUM(volume)
FROM tutorial.aapl_historical_stock_price;

/* An important thing to remember: aggregators only aggregate vertically.
If you want to perform a calculation across rows, you would do this with 
simple arithmetic. You don't need to worry as much about the presence of
 nulls with SUM as you would with COUNT, as SUM treats nulls as 0. */
 
/* Write a query to calculate the average opening price (hint: you will 
need to use both COUNT and SUM, as well as some simple arithmetic.).*/

SELECT SUM(open) / COUNT(open) AS avg_open_price
FROM tutorial.aapl_historical_stock_price;

-- MIN and MAX
/* MIN and MAX are SQL aggregation functions that return the lowest 
and highest values in a particular column. They're similar to COUNT
 in that they can be used on non-numerical columns. */
 
SELECT MIN(volume) AS min_volume,
       MAX(volume) AS max_volume
FROM tutorial.aapl_historical_stock_price;

/* What was Apple's lowest stock price (at the time of this data collection)? */

SELECT MIN(low) AS lowest_price
FROM tutorial.aapl_historical_stock_price;

/* What was the highest single-day increase in Apple's share value? */

SELECT MAX(close - open) AS highest_single_day_increase
FROM tutorial.aapl_historical_stock_price;

-- AVG

/* AVG is a SQL aggregate function that calculates the average of a 
selected group of values. It's very useful, but has some limitations.
 First, it can only be used on numerical columns. Second, it ignores
 nulls completely. */
 
SELECT AVG(high)
FROM tutorial.aapl_historical_stock_price
WHERE high IS NOT NULL;
-- the same result
SELECT AVG(high)
FROM tutorial.aapl_historical_stock_price;

/* There are some cases in which you'll want to treat null values as 0.
 For these cases, you'll want to write a statement that changes the 
 nulls to 0 (use CASE, IFNULL or COALESCE). */
 
 /* Write a query that calculates the average daily trade volume for Apple stock. */
 
 SELECT AVG(volume) AS avg_volume
 FROM tutorial.aapl_historical_stock_price;
 
 
 


