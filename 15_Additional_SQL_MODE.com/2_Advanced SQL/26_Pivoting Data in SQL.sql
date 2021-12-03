-- Pivoting rows to columns

SELECT teams.conference AS conference,
       players.year,
       COUNT(1) AS players
FROM benn.college_football_players players
JOIN benn.college_football_teams teams
	ON teams.school_name = players.school_name
GROUP BY 1, 2
ORDER BY 1, 2;

-- recreating this code with subquery:

SELECT *
FROM 
		(SELECT teams.conference AS conference,
					   players.year,
					   COUNT(1) AS players
		FROM benn.college_football_players players
		JOIN benn.college_football_teams teams
			ON teams.school_name = players.school_name
		GROUP BY 1,2);

-- Each item in the SELECT statement creates a column, so you'll have to create a separate column for each year:      

SELECT conference,
       SUM(players) AS total_players,
       SUM(CASE WHEN year = 'FR' THEN players ELSE NULL END) AS fr,
       SUM(CASE WHEN year = 'SO' THEN players ELSE NULL END) AS so,
       SUM(CASE WHEN year = 'JR' THEN players ELSE NULL END) AS jr,
       SUM(CASE WHEN year = 'SR' THEN players ELSE NULL END) AS sr
FROM 
		(SELECT teams.conference AS conference,
					   players.year,
					   COUNT(1) AS players
		FROM benn.college_football_players players
		JOIN benn.college_football_teams teams
			ON teams.school_name = players.school_name
		GROUP BY 1, 2)
GROUP BY 1
ORDER BY 2 DESC;





