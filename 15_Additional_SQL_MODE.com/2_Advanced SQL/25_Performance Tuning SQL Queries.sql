-- The theory behind query run time
-- things that will affect querys runtime:
/* 	1. table size,
	2. joins,
    3. aggregations,
    4. other users running queries, db software and optimization;
    
-- Reducing table size: */

SELECT *
FROM benn.sample_event_table
WHERE event_date >= '2014-03-01'
AND event_date <  '2014-04-01';

/* So if you're aggregating into one row as below, LIMIT 100 
will do nothing to speed up your query: */

SELECT COUNT(*)
FROM benn.sample_event_table
LIMIT 100;

/* If you want to limit the dataset before performing the count 
(to speed things up), try doing it in a subquery: */

SELECT COUNT(*)
FROM 
	(SELECT *
	FROM benn.sample_event_table
	LIMIT 100);
    
/* Note: Using LIMIT this will dramatically alter your results, 
so you should use it to test query logic, but not to get actual results.*/

-- Making joins less complicated

/* It's better to reduce table sizes before joining them. */

SELECT t.conference AS conference,
       p.school_name,
       COUNT(1) AS players
FROM benn.college_football_players p
JOIN benn.college_football_teams t
	ON t.school_name = p.school_name
GROUP BY 1, 2;

-- better solution:

SELECT t.conference,
       sub.*
FROM 
		(SELECT p.school_name,
				COUNT(*) AS players
		FROM benn.college_football_players p
		GROUP BY 1) sub
JOIN benn.college_football_teams t
	ON t.school_name = sub.school_name;

-- EXPLAIN 

/* You can add EXPLAIN at the beginning of any (working) query
 to get a sense of how long it will take. It's not perfectly
 accurate, but it's a useful tool. */
 
EXPLAIN SELECT *
FROM benn.sample_event_table
WHERE event_date >= '2014-03-01'
   AND event_date < '2014-04-01'
LIMIT 100;

/* The result is called the Query Plan, and it shows the order in which your query will be executed. */


