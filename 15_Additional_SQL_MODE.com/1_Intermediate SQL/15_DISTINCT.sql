-- Using SQL DISTINCT for viewing unique values

SELECT DISTINCT month
FROM tutorial.aapl_historical_stock_price;

/* If you include two (or more) columns in
 a SELECT DISTINCT clause, your results will
 contain all of the unique pairs of those two columns: */

SELECT DISTINCT year, month
FROM tutorial.aapl_historical_stock_price;

/* Write a query that returns the unique values
 in the year column, in chronological order. */
 
SELECT DISTINCT year
FROM tutorial.aapl_historical_stock_price
ORDER BY year;
  
-- Using DISTINCT in aggregations

/* You can use DISTINCT when performing an aggregation.
 You'll probably use it most commonly with the COUNT function. */
 
SELECT COUNT(DISTINCT month) AS unique_months
FROM tutorial.aapl_historical_stock_price;

SELECT month,
       AVG(volume) AS avg_trade_volume
FROM tutorial.aapl_historical_stock_price
GROUP BY month
ORDER BY 2 DESC;

-- DISTINCT performance

/* It's worth noting that using DISTINCT, particularly
 in aggregations, can slow your queries down quite a bit.*/
 
 /* Write a query that counts the number of unique values 
 in the month column for each year. */
 
SELECT 	year, 
		COUNT(DISTINCT month) AS month_count
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year;
 
 /* Write a query that separately counts the number of unique
 values in the month column and the number of unique values in
 the `year` column. */

SELECT 	COUNT(DISTINCT month) AS month_count,
		COUNT(DISTINCT year) AS year_count
FROM tutorial.aapl_historical_stock_price;
