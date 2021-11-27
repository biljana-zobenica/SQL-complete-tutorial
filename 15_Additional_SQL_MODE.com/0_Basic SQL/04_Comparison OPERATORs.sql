-- Comparison operators on NUMERICAL data

/* For example, let's use > to return only the 
rows where the West Region produced more than 
30,000 housing units. */

SELECT *
FROM tutorial.us_housing_units
WHERE west > 30;
 
/* Did the West Region ever produce more than
 50,000 housing units in one month? */
 
SELECT *
FROM tutorial.us_housing_units
WHERE west > 50;
 
/* Did the South Region ever produce 20,000 or 
fewer housing units in one month? */

SELECT *
FROM tutorial.us_housing_units
WHERE south < 20;

-- Comparison operators on NON-NUMERICAL data

SELECT *
FROM tutorial.us_housing_units
WHERE month_name != 'January';
 
 /* There are some important rules when using 
 these operators, though. If you're using an 
 operator with values that are non-numeric, you
 need to put the value in single quotes: 'value'. 
 Note: SQL uses single quotes to reference column values. */
 
SELECT *
FROM tutorial.us_housing_units
WHERE month_name > 'J';
 
/* Write a query that only shows rows for which the month name is February. */

SELECT *
FROM tutorial.us_housing_units
WHERE month_name = 'February';
 
/* Write a query that only shows rows for which
 the month_name starts with the letter "N" or 
 an earlier letter in the alphabet.*/
 
SELECT *
FROM tutorial.us_housing_units
WHERE month_name < 'N';

-- Arithmetic in SQL

SELECT year,
       month,
       west,
       south,
       west + south AS south_plus_west
  FROM tutorial.us_housing_units;
  
  SELECT year,
       month,
       west,
       south,
       west + south - 4 * year AS nonsense_column
  FROM tutorial.us_housing_units;
  
  /* The columns that contain the arithmetic functions
  are called "derived columns" because they are generated
  by modifying the information that exists in the underlying data.*/
  
/*  Write a query that calculates the sum of all four regions in a separate column. */

SELECT year,
       month,
       west,
       south,
       midwest,
       northeast,
       west + south + northeast + midwest AS USA_total
  FROM tutorial.us_housing_units;
  
  SELECT year,
       month,
       west,
       south,
       (west + south)/2 AS south_west_avg
  FROM tutorial.us_housing_units;
  
  /* Write a query that returns all rows for which more units
  were produced in the West region than in the Midwest and Northeast combined. */
  
  SELECT *
  FROM tutorial.us_housing_units
  WHERE west > (midwest + northeast);
  
  /* Write a query that calculates the percentage of all houses
  completed in the United States represented by each region. 
  Only return results from the year 2000 and later.

Hint: There should be four columns of percentages. */
  
  SELECT 
	west / (west + south + northeast + midwest)*100 AS "% of west",
    south / (west + south + northeast + midwest)*100 AS "% of south",
    midwest / (west + south + northeast + midwest)*100 AS "% of midwest",
    northeast / (west + south + northeast + midwest)*100 AS "% of northeast"
  FROM tutorial.us_housing_units
  WHERE year >= 2000;

 
 