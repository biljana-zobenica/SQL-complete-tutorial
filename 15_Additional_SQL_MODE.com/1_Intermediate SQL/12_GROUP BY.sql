/* SQL aggregate function like COUNT, AVG, and SUM have something in common:
 they all aggregate across the entire table. But what if you want to aggregate
 only part of a table? For example, you might want to count the number of entries
 for each year. In situations like this, you'd need to use the GROUP BY clause. 
 GROUP BY allows you to separate data into groups, which can be aggregated 
 independently of one another. */
 
SELECT year,
	COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY year;

SELECT year,
       month,
       COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month;

/* Calculate the total number of shares traded each month. 
Order your results chronologically. */

SELECT 	year,
		month,
        SUM(volume) AS volume_total
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month;

-- GROUP BY column numbers
-- As with ORDER BY, you can substitute numbers for column names in the GROUP BY clause.

SELECT year,
       month,
       COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY 1, 2;

-- Using GROUP BY with ORDER BY

/* The order of column names in your GROUP BY clause doesn't matter—the results will be the
 same regardless. If you want to control how the aggregations are grouped together, use ORDER BY. */
 
SELECT year,
       month,
       COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY month, year;

SELECT year,
       month,
       COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month; -- reverse order gives different result;

-- Using GROUP BY with LIMIT

/* SQL evaluates the aggregations before the LIMIT clause. 
If you don't group by any columns, you'll get a 1-row result—no
 problem there. If you group by a column with enough unique values
 that it exceeds the LIMIT number, the aggregates will be calculated,
 and then some rows will simply be omitted from the results.*/
 
 /* Write a query to calculate the average daily price change in Apple
 stock, grouped by year. */
 
SELECT 	year,
		AVG(open - close) AS abs_avg_daily_price_change
FROM tutorial.aapl_historical_stock_price
GROUP BY 1
ORDER BY 1;
 
  /* Write a query that calculates the lowest and highest prices that 
  Apple stock achieved each month. */

SELECT 	year, 
		month, 
        MIN(low), 
        MAX(high)
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month;
 
 

