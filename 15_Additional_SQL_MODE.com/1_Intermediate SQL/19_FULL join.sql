/* LEFT JOIN and RIGHT JOIN each return unmatched rows from one of the
 tables—FULL JOIN returns unmatched rows from both tables. It is commonly
 used in conjunction with aggregations to understand the amount of overlap
 between two tables. */
 
SELECT COUNT(CASE WHEN c.permalink IS NOT NULL AND a.company_permalink IS NULL
                  THEN c.permalink ELSE NULL END) AS companies_only,
       COUNT(CASE WHEN c.permalink IS NOT NULL AND a.company_permalink IS NOT NULL
                  THEN c.permalink ELSE NULL END) AS both_tables,
       COUNT(CASE WHEN c.permalink IS NULL AND a.company_permalink IS NOT NULL
                  THEN a.company_permalink ELSE NULL END) AS acquisitions_only -- *look at the note below
FROM tutorial.crunchbase_companies c,
FULL JOIN tutorial.crunchbase_acquisitions a
    ON c.permalink = a.company_permalink;
    
/* One important thing to keep in mind is that you must count from the 
crunchbase_acquisitions table in order to get unmatched rows in that 
table—if you were to count companies.permalink as in the first two columns,
 you would get a result of 0 in the third column because it would be 
 counting up a bunch of null values. */
 
 /* Write a query that joins tutorial.crunchbase_companies and 
 tutorial.crunchbase_investments_part1 using a FULL JOIN. 
 Count up the number of rows that are matched/unmatched as 
 in the example above. */
 
 SELECT COUNT(CASE WHEN c.permalink IS NOT NULL AND ip1.company_permalink IS NULL
					THEN c.permalink ELSE NULL END) AS companies_only,
		COUNT(CASE WHEN c.permalink IS NOT NULL AND ip1.company_permalink IS NOT NULL
					THEN c.permalink ELSE NULL END) AS both_tables,
		COUNT(CASE WHEN c.permalink IS NULL AND ip1.company_permalink IS NOT NULL
					THEN ip1.company_permalink ELSE NULL END) AS investments_only 
 FROM tutorial.crunchbase_companies c
 FULL JOIN tutorial.crunchbase_investments_part1 ip1
	ON c.permalink = ip1.company_permalink;
 
 
 
 
 
 