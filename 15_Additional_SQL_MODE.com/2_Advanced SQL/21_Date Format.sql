-- Why dates are formatted year-first

/* MM-DD-YYYY or DD-MM-YYYY -> The problem with both of these formats is 
that when they are stored as strings, they don't sort in chronological order.
For example, here's a date field stored as a string. Because the month is listed
 first, the ORDER BY statement doesn't produce a chronological list: */
 
SELECT permalink,
       founded_at
FROM tutorial.crunchbase_companies_clean_date
ORDER BY founded_at;

/* You might think that converting these values from string to date might solve 
the problem, but it's actually not quite so simple. Mode (and most relational 
databases) format dates as YYYY-MM-DD, a format that makes a lot of sense because
 it will sort in the same order whether it's stored as a date or as a string. */
 
SELECT permalink,
       founded_at,
       founded_at_clean
FROM tutorial.crunchbase_companies_clean_date
ORDER BY founded_at_clean;

-- Crazy rules for dates and times

/* When you perform arithmetic on dates (such as subtracting one date from another), 
the results are often stored as the interval data type—a series of integers that 
represent a period of time. The following query uses date subtraction to determine 
how long it took companies to be acquired (unacquired companies and those without 
dates entered were filtered out). Note that because the companies.founded_at_clean
 column is stored as a string, it must be cast as a timestamp before it can be 
 subtracted from another timestamp. */
 
SELECT 	c.permalink,
		c.founded_at_clean,
		a.acquired_at_cleaned,
		a.acquired_at_cleaned -
		c.founded_at_clean::timestamp AS time_to_acquisition
FROM tutorial.crunchbase_companies_clean_date c
JOIN tutorial.crunchbase_acquisitions_clean_date a
    ON a.company_permalink = c.permalink
WHERE founded_at_clean IS NOT NULL;

-- You can introduce intervals using the INTERVAL function as well:

SELECT 	c.permalink,
		c.founded_at_clean,
		c.founded_at_clean::timestamp +
		INTERVAL '1 week' AS plus_one_week
FROM tutorial.crunchbase_companies_clean_date c
WHERE founded_at_clean IS NOT NULL;

/* You can add the current time (at the time you run the query) into 
your code using the NOW()function: */

SELECT companies.permalink,
       companies.founded_at_clean,
       NOW() - companies.founded_at_clean::timestamp AS founded_time_ago
FROM tutorial.crunchbase_companies_clean_date companies
WHERE founded_at_clean IS NOT NULL;

/* Write a query that counts the number of companies acquired within 
3 years, 5 years, and 10 years of being founded (in 3 separate columns).
 Include a column for total companies acquired as well. Group by category
 and limit to only rows with a founding date. */
 
SELECT c.category_code,
       COUNT(CASE WHEN a.acquired_at_cleaned <= c.founded_at_clean::timestamp + INTERVAL '3 years'
			THEN 1 ELSE NULL END) AS acquired_3_yrs,
       COUNT(CASE WHEN a.acquired_at_cleaned <= c.founded_at_clean::timestamp + INTERVAL '5 years'
			THEN 1 ELSE NULL END) AS acquired_5_yrs,
       COUNT(CASE WHEN a.acquired_at_cleaned <= c.founded_at_clean::timestamp + INTERVAL '10 years'
			THEN 1 ELSE NULL END) AS acquired_10_yrs,
       COUNT(1) AS total
FROM tutorial.crunchbase_companies_clean_date c
JOIN tutorial.crunchbase_acquisitions_clean_date a
    ON a.company_permalink = c.permalink
WHERE founded_at_clean IS NOT NULL
GROUP BY 1
ORDER BY 5 DESC;




 