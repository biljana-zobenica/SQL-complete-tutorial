-- Using comparison operators with joins

/* In the lessons so far, you've only joined tables by
 exactly matching values from both tables. However, you
 can enter any type of conditional statement into the ON
 clause. Here's an example using > to join only investments
 that occurred more than 5 years after each company's founding year: */
 
SELECT c.permalink,
       c.name,
       c.status,
       COUNT(ip1.investor_permalink) AS investors
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_investments_part1 ip1
	ON c.permalink = ip1.company_permalink
	AND ip1.funded_year > c.founded_year + 5 -- filter WITHIN the join relation
GROUP BY 1, 2, 3;

/* This technique is especially useful for creating date ranges as 
shown above. It's important to note that this produces a different
 result than the following query because it only joins rows that fit
 the ip1.funded_year > c.founded_year + 5 condition
 rather than joining all rows and then filtering: */
 
SELECT companies.permalink,
       companies.name,
       companies.status,
       COUNT(investments.investor_permalink) AS investors
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_investments_part1 investments
	ON companies.permalink = investments.company_permalink
WHERE investments.funded_year > companies.founded_year + 5 -- filter AFTER the join results
GROUP BY 1, 2, 3;

-- Joining on multiple keys

/* There are couple reasons you might want to join tables on multiple foreign keys. 
1. The first has to do with accuracy.
2. The second reason has to do with performance. 
SQL uses "indexes" (essentially pre-defined joins) to speed up queries. */

/* For example, the results of the following query will be the same with or
 without the last line. However, it is possible to optimize the database such
 that the query runs more quickly with the last line included: */

SELECT c.permalink,
       c.name,
       ip1.company_name,
       ip1.company_permalink
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_investments_part1 ip1
    ON c.permalink = ip1.company_permalink
	AND c.name = ip1.company_name;
    
-- It's worth noting that this will have relatively little effect on small datasets.

-- Self joining tables

/* wanted to identify companies that received an investment from Great Britain
 following an investment from Japan.*/

SELECT DISTINCT ji.company_name,
				ji.company_permalink
FROM tutorial.crunchbase_investments_part1 ji
JOIN tutorial.crunchbase_investments_part1 gbi
    ON ji.company_name = gbi.company_name
	AND gbi.investor_country_code = 'GBR'
	AND gbi.funded_at > ji.funded_at
 WHERE ji.investor_country_code = 'JPN'
 ORDER BY 1;





