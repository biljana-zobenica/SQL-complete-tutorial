SELECT * 
FROM benn.college_football_players;

/* The CASE statement is SQL's way of handling if/then logic. 
The CASE statement is followed by at least one pair of WHEN 
and THEN statements—SQL's equivalent of IF/THEN in Excel.
Every CASE statement must end with the END statement. The ELSE
 statement is optional, and provides a way to capture values 
 not specified in the WHEN/THEN statements. */
 
SELECT 	player_name,
		year,
		CASE WHEN year = 'SR' THEN 'yes'
            ELSE NULL 
		END AS is_a_senior
FROM benn.college_football_players;

SELECT 	player_name,
		year,
		CASE WHEN year = 'SR' THEN 'yes'
            ELSE 'no' 
		END AS is_a_senior
FROM benn.college_football_players;

/* Write a query that includes a column that is flagged "yes" 
when a player is from California, and sort the results with 
those players first. */

SELECT  player_name, 
        state, 
        hometown,
    	  CASE WHEN state = 'CA' THEN 'yes'
            ELSE NULL 
      	END AS is_from_CA
FROM benn.college_football_players
ORDER BY is_from_CA; -- or column 4

-- Adding multiple conditions to a CASE statement

SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 THEN '201-250'
            WHEN weight > 175 THEN '176-200'
            ELSE '175 or under' 
		END AS weight_group
FROM benn.college_football_players;

/* While the above works, it's really best practice to create
 statements that don't overlap. WHEN weight > 250 and WHEN
 weight > 200 overlap for every value greater than 250, which
 is a little confusing. A better way to write the above would be: */
 
SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 AND weight <= 250 THEN '201-250'
            WHEN weight > 175 AND weight <= 200 THEN '176-200'
            ELSE '175 or under' 
		END AS weight_group
FROM benn.college_football_players;
  
  /* Write a query that includes players' names and a column that 
  classifies them into four categories based on height. Keep in 
  mind that the answer we provide is only one of many possible 
  answers, since you could divide players' heights in many ways. */
 
SELECT 	MIN(height),
		MAX(height),
		AVG(height)
FROM benn.college_football_players;
 
SELECT player_name,
       height,
       CASE WHEN height > 75 THEN 'over 75'
            WHEN height > 70 AND height <= 75 THEN '71-75'
            WHEN height > 65 AND height <= 70 THEN '66-70'
            ELSE '65 or under' 
		END AS height_group
FROM benn.college_football_players;

SELECT 	player_name,
		CASE WHEN year = 'FR' AND position = 'WR' THEN 'frosh_wr'
            ELSE NULL 
		END AS sample_case_statement
FROM benn.college_football_players;

/* Write a query that selects all columns from benn.college_football_players
 and adds an additional column that displays the player's name if that player
 is a junior or senior. */
 
SELECT 	*,
		CASE WHEN year IN ('JR', 'SR') THEN player_name 
			ELSE NULL
        END AS upperclass_player_name
FROM benn.college_football_players;

-- Using CASE with aggregate functions

/* CASE's slightly more complicated and substantially more useful
 functionality comes from pairing it with aggregate functions. For
 example, let's say you want to only count rows that fulfill a certain
 condition. Since COUNT ignores nulls, you could use a CASE statement
 to evaluate the condition and produce null or non-null values depending
 on the outcome: */
 
SELECT 		CASE WHEN year = 'FR' THEN 'FR'
				ELSE 'Not FR' 
			END AS year_group,
			COUNT(1) AS count
FROM benn.college_football_players
GROUP BY 	CASE WHEN year = 'FR' THEN 'FR'
            ELSE 'Not FR' 
			END;

-- by using WHERE filter clause
 
SELECT COUNT(1) AS fr_count
FROM benn.college_football_players
WHERE year = 'FR';

-- but, when counting a couple other conditions:

SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' 
            END AS year_group,
            COUNT(1) AS count
 FROM benn.college_football_players
 GROUP BY 1;
 
/* The above query is an excellent place to use numbers
 instead of columns in the GROUP BY clause because repeating
 the CASE statement in the GROUP BY clause would make the 
 query obnoxiously long. Alternatively, you can use the 
 column's alias in the GROUP BY clause like this: */
 
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' 
            END AS year_group,
            COUNT(1) AS count
FROM benn.college_football_players
GROUP BY year_group;

/* Note that if you do choose to repeat the entire CASE statement,
 you should remove the AS year_group column naming when you copy/paste
 into the GROUP BY clause: */
 
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' 
            END AS year_group,
            COUNT(1) AS count
FROM benn.college_football_players
GROUP BY CASE WHEN year = 'FR' THEN 'FR'
               WHEN year = 'SO' THEN 'SO'
               WHEN year = 'JR' THEN 'JR'
               WHEN year = 'SR' THEN 'SR'
               ELSE 'No Year Data' END; -- without AS year_group

/* Write a query that counts the number of 300lb+ players for 
each of the following regions: West Coast (CA, OR, WA), Texas,
 and Other (everywhere else). */
  
SELECT CASE WHEN state IN ('CA', 'OR', 'WA') THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'Other' 
            END AS state_group,
            COUNT(*) AS count_players
FROM benn.college_football_players
WHERE weight >= 300
GROUP BY 1;

/* Write a query that calculates the combined weight of all 
underclass players (FR/SO) in California as well as the combined
 weight of all upperclass players (JR/SR) in California. */

SELECT CASE WHEN year IN ('FR', 'SO') THEN 'underclass_players'
            WHEN year IN ('JR', 'SR') THEN 'upperclass_players'
            ELSE NULL 
            END AS class_group,
            SUM(weight) AS weight_sum_class
FROM benn.college_football_players
WHERE state = 'CA'
GROUP BY 1;

-- Using CASE inside of aggregate functions

/* In the previous examples, data was displayed vertically,
 but in some instances, you might want to show data horizontally.
 This is known as "pivoting" (like a pivot table in Excel).
 Let's take the following query: */
 
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
FROM benn.college_football_players
GROUP BY 1;

-- And re-orient it horizontally:

SELECT COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count
FROM benn.college_football_players;

/* Pay attention to the COUNT function moving from vertical to horizontal approach. */

/* Write a query that displays the number of players in each state,
 with FR, SO, JR, and SR players in separate columns and another 
 column for the total number of players. Order results such that 
 states with the most players come first. */

SELECT 	state,
		COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
		COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
		COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
		COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
		COUNT(*) AS total_players
FROM benn.college_football_players
GROUP BY 1
ORDER BY 2 DESC;

/* Write a query that shows the number of players at schools with
 names that start with A through M, and the number at schools with
 names starting with N - Z. */

SELECT CASE WHEN school_name < 'n' THEN 'A-M'
            WHEN school_name >= 'n' THEN 'N-Z'
            ELSE NULL 
            END AS school_name_group,
       COUNT(1) AS players
FROM benn.college_football_players
GROUP BY 1;

