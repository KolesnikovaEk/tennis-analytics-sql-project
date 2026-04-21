--1)победитель и проигравший для каждого матча
CREATE VIEW tennis_analytics.match_players AS
WITH players_of_the_match AS (
	SELECT 
		match_id, MIN(player_id) AS player_1,
		MAX(player_id) AS player_2
	FROM tennis_analytics.match_player_stats
	GROUP BY match_id
),
match_data AS (
	SELECT 
		t.match_id, t.winner_id,
		CASE 
			WHEN t.winner_id = p.player_1 THEN p.player_2
			ELSE p.player_1
		END AS loser_id
	FROM tennis_analytics.tennis_match t 
	JOIN players_of_the_match p ON p.match_id = t.match_id
),
players_of_the_match_names AS (
	SELECT md.match_id, md.winner_id, md.loser_id, w.first_name AS winner_first_name, w.last_name AS winner_last_name,
	l.first_name AS loser_first_name, l.last_name AS loser_last_name
	FROM match_data md 
	JOIN tennis_analytics.player w ON md.winner_id = w.player_id
	JOIN tennis_analytics.player l ON md.loser_id = l.player_id
)
SELECT 
    potmn.match_id,
    potmn.winner_id,
    potmn.loser_id,
    potmn.winner_first_name,
    potmn.winner_last_name,
    potmn.loser_first_name,
    potmn.loser_last_name
FROM players_of_the_match_names potmn;


--2)количество побед, поражений, процент побед для каждого игрока
CREATE VIEW tennis_analytics.win_lose_stat AS
WITH wins AS (
SELECT winner_id AS player_id, COUNT(*) AS count_win
FROM tennis_analytics.match_players GROUP BY winner_id
),
loses AS (
SELECT loser_id AS player_id, COUNT(*) AS count_lose
FROM tennis_analytics.match_players GROUP BY loser_id
)
SELECT p.player_id, p.first_name, p.last_name,
COALESCE(w.count_win, 0) AS count_win, COALESCE(l.count_lose, 0) AS count_lose,
ROUND(100.0 * COALESCE(w.count_win, 0) /  NULLIF(COALESCE(w.count_win, 0) + COALESCE(l.count_lose, 0), 0)) AS win_percent
FROM tennis_analytics.player p 
LEFT JOIN wins w ON p.player_id = w.player_id 
LEFT JOIN loses l ON p.player_id = l.player_id;
