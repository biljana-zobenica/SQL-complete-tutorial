/* Subqueries (also known as inner queries or nested queries) are
 a tool for performing operations in multiple steps. */
 
 /* Write a query that selects all Warrant Arrests from the 
 tutorial.sf_crime_incidents_2014_01 dataset, then wrap it 
 in an outer query that only displays unresolved incidents. */
 
SELECT sub.*
FROM 
	(SELECT *
	 FROM tutorial.sf_crime_incidents_2014_01
	 WHERE descript = 'WARRANT ARREST')
WHERE sub.resolution = 'NONE';

-- Using subqueries to aggregate in multiple stages

/* What if you wanted to figure out how many incidents get reported
 on each day of the week? Better yet, what if you wanted to know how
 many incidents happen, on average, on a Friday in December? In January?
 There are two steps to this process: counting the number of incidents
 each day (inner query), then determining the monthly average (outer query):*/
 
SELECT LEFT(sub.date, 2) AS cleaned_month,
       sub.day_of_week,
       AVG(sub.incidents) AS average_incidents
FROM 
		(SELECT day_of_week,
				date,
				COUNT(incidnt_num) AS incidents
		FROM tutorial.sf_crime_incidents_2014_01
		GROUP BY 1, 2)
GROUP BY 1, 2
ORDER BY 1, 2;

/* Write a query that displays the average number of monthly incidents for
 each category. Hint: use tutorial.sf_crime_incidents_cleandate to make your
 life a little easier. */
 
 SELECT sub.category,
       AVG(sub.incidents) AS avg_incidents_per_month
  FROM 
	  (SELECT EXTRACT('month' FROM cleaned_date) AS month,
				   category,
				   COUNT(1) AS incidents
				FROM tutorial.sf_crime_incidents_cleandate
				GROUP BY 1,2)
 GROUP BY 1;
 
 -- Subqueries in conditional logic
 
SELECT *
FROM tutorial.sf_crime_incidents_2014_01
WHERE Date = 
			(SELECT MIN(date)
			FROM tutorial.sf_crime_incidents_2014_01);

/* Most conditional logic will work with subqueries containing
 one-cell results. However, IN is the only type of conditional
 logic that will work when the inner query contains multiple results: */

SELECT *
FROM tutorial.sf_crime_incidents_2014_01
WHERE Date IN
			(SELECT date
			FROM tutorial.sf_crime_incidents_2014_01
			ORDER BY date
			LIMIT 5);
 
-- Joining subqueries
 
SELECT *
FROM tutorial.sf_crime_incidents_2014_01 incidents
JOIN 
		(SELECT date
		FROM tutorial.sf_crime_incidents_2014_01
		ORDER BY date
		LIMIT 5)
ON incidents.date = sub.date;

SELECT incidents.*,
       sub.incidents AS incidents_that_day
FROM tutorial.sf_crime_incidents_2014_01 incidents
JOIN 
		(SELECT date,
		COUNT(incidnt_num) AS incidents
		FROM tutorial.sf_crime_incidents_2014_01
		GROUP BY 1)
ON incidents.date = sub.date
ORDER BY sub.incidents DESC, time;

/* Write a query that displays all rows from the three categories
 with the fewest incidents reported. */
 
SELECT incidents.*,
       sub.count AS total_incidents_in_category
FROM tutorial.sf_crime_incidents_2014_01 incidents
JOIN 
		(SELECT category,
				COUNT(*) AS count
		FROM tutorial.sf_crime_incidents_2014_01
		GROUP BY 1
		ORDER BY 2
		LIMIT 3)
ON sub.category = incidents.category;

/* Write a query that counts the number of companies founded and acquired
 by quarter starting in Q1 2012. Create the aggregations in two separate 
 queries, then join them.*/
 
SELECT COALESCE(c.quarter, a.quarter) AS quarter,
           c.companies_founded,
           a.companies_acquired
FROM 
			(SELECT founded_quarter AS quarter,
					COUNT(permalink) AS companies_founded
			FROM tutorial.crunchbase_companies
			WHERE founded_year >= 2012
			GROUP BY 1) c
LEFT JOIN 
			(SELECT acquired_quarter AS quarter,
					COUNT(DISTINCT company_permalink) AS companies_acquired
			FROM tutorial.crunchbase_acquisitions
			WHERE acquired_year >= 2012
			GROUP BY 1) a
ON c.quarter = a.quarter
ORDER BY 1;

-- Subqueries and UNIONs

SELECT *
FROM tutorial.crunchbase_investments_part1
UNION ALL
SELECT *
FROM tutorial.crunchbase_investments_part2;


SELECT COUNT(*) AS total_rows
FROM 
		(SELECT *
		FROM tutorial.crunchbase_investments_part1
		UNION ALL
		SELECT *
		FROM tutorial.crunchbase_investments_part2);
	
 /* Write a query that ranks investors from the combined
 dataset above by the total number of investments they have made.*/
 
SELECT 	investor_name, 
		COUNT(*) AS investments
FROM 
		(SELECT *
		FROM tutorial.crunchbase_investments_part1
		UNION ALL
		SELECT *
		FROM tutorial.crunchbase_investments_part2)
GROUP BY 1
ORDER BY 2 DESC;
 
 /* Write a query that does the same thing as in the previous problem,
 except only for companies that are still operating. Hint: operating 
 status is in tutorial.crunchbase_companies.*/
 
SELECT 	i.investor_name, 
		COUNT(i.*) AS investments
FROM tutorial.crunchbase_companies c
JOIN
		(SELECT *
		FROM tutorial.crunchbase_investments_part1
		UNION ALL
		SELECT *
		FROM tutorial.crunchbase_investments_part2) i
ON i.company_permalink = c.permalink
WHERE c.status = 'operating'
GROUP BY 1
ORDER BY 2 DESC;
 
 
 