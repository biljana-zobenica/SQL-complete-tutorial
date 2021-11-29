/* SQL joins allow you to combine two datasets side-by-side, 
but UNION allows you to stack one dataset on top of the other.
Put differently, UNION allows you to write two separate SELECT 
statements, and to have the results of one statement display 
in the same table as the results from the other statement. */

SELECT *
FROM tutorial.crunchbase_investments_part1
UNION -- or UNION ALL (to append all the values from the 2nd table and NOT drop duplicates)
SELECT *
FROM tutorial.crunchbase_investments_part2;

/* Note that UNION only appends distinct values. More specifically, 
when you use UNION, the dataset is appended, and any rows in the 
appended table that are exactly identical to rows in the first table
 are dropped. If you'd like to append all the values from the second
 table, use UNION ALL. */
 
 /* SQL has strict rules for appending data:

1. Both tables must have the same number of columns
2. The columns must have the same data types in the same
 order as the first table. 
 
 While the column names don't necessarily have to be the same,
 you will find that they typically are. */
 
 /* Write a query that appends the two crunchbase_investments 
 datasets above (including duplicate values). Filter the first 
 dataset to only companies with names that start with the letter
 "T", and filter the second to companies with names starting with
 "M" (both not case-sensitive). Only include the company_permalink,
 company_name, and investor_name columns. */
 
SELECT  company_permalink,
		company_name,
        investor_name
FROM tutorial.crunchbase_investments_part1 
WHERE company_name LIKE 'T%'
UNION ALL 
SELECT  company_permalink,
		company_name,
        investor_name
FROM tutorial.crunchbase_investments_part2
WHERE company_name LIKE 'M%';
 
 /* Write a query that shows 3 columns. The first indicates which 
 dataset (part 1 or 2) the data comes from, the second shows company
 status, and the third is a count of the number of investors.

 Hint: you will have to use the tutorial.crunchbase_companies table as
 well as the investments tables. And you'll want to group by status 
 and dataset. */

SELECT  'investments_part1' AS dataset_name,
		c.status,
        COUNT(DISTINCT ip1.investor_permalink) AS num_of_investors
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_investments_part1 ip1
	ON c.permalink = ip1.company_permalink
GROUP BY 1, 2
UNION ALL 
SELECT  'investments_part2' AS dataset_name,
		c.status,
        COUNT(DISTINCT ip2.investor_permalink) AS num_of_investors
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_investments_part2 ip2
	ON c.permalink = ip2.company_permalink
GROUP BY 1, 2;
