-- OUTER joins
/* When performing an inner join, rows from either table
 that are unmatched in the other table are not returned.
 In an outer join, unmatched rows in one or both tables 
 can be returned. There are a few types of outer joins: */
 
 -- LEFT JOIN 	-> returns only unmatched rows from the left table,
 -- RIGHT JOIN 	-> returns only unmatched rows from the right table,
 -- FULL OUTER JOIN -> returns unmatched rows from both tables.
 
SELECT *
FROM tutorial.crunchbase_companies;

SELECT *
FROM tutorial.crunchbase_acquisitions;

-- LEFT join

SELECT c.permalink AS companies_permalink,
       c.name AS companies_name,
       a.company_permalink AS acquisitions_permalink,
       a.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies c
JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink;
    
SELECT c.permalink AS companies_permalink,
       c.name AS companies_name,
       a.company_permalink AS acquisitions_permalink,
       a.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink;
    
/* Write a query that performs an inner join between the
 tutorial.crunchbase_acquisitions table and the tutorial.
 crunchbase_companies table, but instead of listing individual
 rows, count the number of non-null rows in each table. */

SELECT 	COUNT(c.permalink) AS companies_rowcount,
		COUNT(a.company_permalink) AS acquisitions_rowcount
FROM tutorial.crunchbase_companies c
JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink;

/* Modify the query above to be a LEFT JOIN. Note the 
difference in results. */

SELECT 	COUNT(c.permalink) AS companies_rowcount,
		COUNT(a.company_permalink) AS acquisitions_rowcount
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink;

/* Count the number of unique companies (don't double-count
 companies) and unique acquired companies by state. Do not
 include results for which there is no state data, and order
 by the number of acquired companies from highest to lowest. */
 
SELECT 	c.state_code,
		COUNT(DISTINCT c.permalink) AS unique_companies,
		COUNT(DISTINCT a.company_permalink) AS unique_companies_acquired
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink
WHERE c.state_code IS NOT NULL
GROUP BY 1
ORDER BY 3 DESC;

-- RIGHT join

/* RIGHT JOIN is rarely used because you can achieve the results of a 
RIGHT JOIN by simply switching the two joined table names in a LEFT JOIN. */

/* Rewrite the previous practice query in which you counted total and 
acquired companies by state, but with a RIGHT JOIN instead of a LEFT 
JOIN. The goal is to produce the exact same results. */

SELECT 	c.state_code,
		COUNT(DISTINCT c.permalink) AS unique_companies,
		COUNT(DISTINCT a.company_permalink) AS unique_companies_acquired
FROM tutorial.crunchbase_acquisitions a
RIGHT JOIN tutorial.crunchbase_companies c
    ON c.permalink = a.company_permalink
WHERE c.state_code IS NOT NULL
GROUP BY 1
ORDER BY 3 DESC;

-- Filtering in the ON clause

SELECT c.permalink AS companies_permalink,
       c.name AS companies_name,
       a.company_permalink AS acquisitions_permalink,
       a.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink
ORDER BY 1;

/* Compare the following query to the previous one and you will
 see that everything in the tutorial.crunchbase_acquisitions table
 was joined on except for the row for which company_permalink is
 '/company/1000memories': */
 
SELECT c.permalink AS companies_permalink,
       c.name AS companies_name,
       a.company_permalink AS acquisitions_permalink,
       a.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink
AND a.company_permalink != '/company/1000memories' -- happens BEFORE the join occurs
ORDER BY 1;
 
 /* What's happening above is that the conditional statement AND...
 is evaluated BEFORE the join occurs. You can think of it as a WHERE
 clause that only applies to one of the tables. You can tell that this
 is only happening in one of the tables because the 1000memories permalink
 is still displayed in the column that pulls from the other table; */
 
-- Filtering in the WHERE clause

/* If you move the same filter to the WHERE clause, you will notice 
that the filter happens after the tables are joined. The result is 
that the 1000memories row is joined onto the original table, but then
 it is filtered out entirely (in both tables) in the WHERE clause 
 before displaying results. Also note that filtering in the WHERE 
 clause can also filter null values, so we added an extra line to 
 make sure to include the nulls.*/
 
 SELECT c.permalink AS companies_permalink,
       c.name AS companies_name,
       a.company_permalink AS acquisitions_permalink,
       a.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink
WHERE  a.company_permalink != '/company/1000memories' -- happens AFTER the join occurs
	OR a.company_permalink IS NULL
ORDER BY 1;

/* Write a query that shows a company's name, "status" (found in the Companies table),
 and the number of unique investors in that company. Order by the number of investors
 from most to fewest. Limit to only companies in the state of New York. */

SELECT 	c.name AS company_name,
        c.status AS company_status,
		COUNT(DISTINCT i.investor_name) AS unique_investors
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_investments i
    ON c.permalink = i.company_permalink
WHERE  c.state_code = 'NY'
GROUP BY 1, 2
ORDER BY 3 DESC;

/* Write a query that lists investors based on the number of companies in which they
 are invested. Include a row for companies with no investor, and order from most
 companies to least. */

SELECT 	CASE WHEN i.investor_name IS NULL THEN 'No Investors'
		ELSE i.investor_name END AS investor,
        COUNT(DISTINCT c.permalink) AS companies_invested_in
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_investments i
    ON c.permalink = i.company_permalink
GROUP BY 1
ORDER BY 2 DESC;
 
 
 