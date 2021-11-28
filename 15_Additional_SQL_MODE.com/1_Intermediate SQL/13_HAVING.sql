/* The GROUP BY clause is used to aggregate stats from the Apple
 stock prices dataset by month and year. But, how about you want
 to find every month during which AAPL stock worked its way over
 $400/share. The WHERE clause won't work for this because it 
 doesn't allow you to filter on aggregate columns—that's where
 the HAVING clause comes in: */
 
SELECT year,
       month,
       MAX(high) AS month_high
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
HAVING MAX(high) > 400
ORDER BY year, month;

/* Note: HAVING is the "clean" way to filter a query that has been 
aggregated, but this is also commonly done using a subquery. */

-- Query clause order

-- 1. SELECT
-- 2. FROM
-- 3. WHERE
-- 4. GROUP BY
-- 5. HAVING
-- 6. ORDER BY





