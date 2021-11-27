-- The LIMIT restricts how many rows the SQL query returns.

SELECT *
  FROM tutorial.us_housing_units
 LIMIT 100;
 
 /* Write a query that uses the LIMIT command to restrict
 the result set to only 15 rows. */
 
 SELECT year
 FROM tutorial.us_housing_units
 LIMIT 15;