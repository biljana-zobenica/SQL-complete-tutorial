/* Inner joins eliminate rows from both tables that do not 
satisfy the join condition set forth in the ON statement. 
In mathematical terms, an inner join is the intersection 
of the two tables. */

SELECT 	players.*,
		teams.*
FROM benn.college_football_players players
JOIN benn.college_football_teams teams
		ON teams.school_name = players.school_name;
        
/* Write a query that displays player names, school names 
and conferences for schools in the "FBS (Division I-A Teams)"
division. */
 
SELECT 	p.player_name,
		t.school_name,
        t.conference
FROM benn.college_football_players p
JOIN benn.college_football_teams t
		ON t.school_name = p.school_name
WHERE t.division = 'FBS (Division I-A Teams)';