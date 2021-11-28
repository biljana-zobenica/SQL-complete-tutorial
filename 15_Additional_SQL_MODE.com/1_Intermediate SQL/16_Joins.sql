-- The anatomy of a join

SELECT teams.conference AS conference,
	AVG(players.weight) AS average_weight
FROM benn.college_football_players players
	JOIN benn.college_football_teams teams
	ON teams.school_name = players.school_name 	-- These relationships are sometimes called "mappings."
												-- The two columns that map to one another, are referred 
                                                -- to as "foreign keys" or "join keys."
GROUP BY teams.conference
ORDER BY AVG(players.weight) DESC;

/* Write a query that selects the school name, player name,
 position, and weight for every player in Georgia, ordered
 by weight (heaviest to lightest). Be sure to make an alias
 for the table, and to reference all column names in relation
 to the alias. */
 
SELECT 	p.school_name, 
		p.player_name,
        p.position,
        p.weight
FROM benn.college_football_players p
WHERE p.state = 'GA'
ORDER BY p.weight DESC;

