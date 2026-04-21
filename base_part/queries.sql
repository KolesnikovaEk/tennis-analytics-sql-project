--1) описание матча (турнир, раунд, дата, победитель, проигравший)
WITH players_of_the_match AS (
	SELECT 
		match_id, MIN(player_id) AS player_1,
		MAX(player_id) AS player_2
	FROM tennis_analytics.match_player_stats
	GROUP BY match_id
),
match_data AS (
	SELECT 
		t.match_id,
		t.tournament_id,
		t.winner_id,
		t.round,
		t.match_date,
		CASE 
			WHEN t.winner_id = p.player_1 THEN p.player_2
			ELSE p.player_1
		END AS loser_id
	FROM tennis_analytics.tennis_match t 
	JOIN players_of_the_match p ON p.match_id = t.match_id
),
players_of_the_match_names AS (
	SELECT md.match_id, w.first_name AS winner_first_name, w.last_name AS winner_last_name,
	l.first_name AS loser_first_name, l.last_name AS loser_last_name
	FROM match_data md 
	JOIN tennis_analytics.player w ON md.winner_id = w.player_id
	JOIN tennis_analytics.player l ON md.loser_id = l.player_id
)
SELECT md.match_id, t.tournament_name, md.round, md.match_date, potmn.winner_first_name,
potmn.winner_last_name, potmn.loser_first_name, potmn.loser_last_name
FROM match_data md JOIN tennis_analytics.tournament t ON md.tournament_id = t.tournament_id
JOIN players_of_the_match_names potmn ON potmn.match_id = md.match_id;




--2) итоговый счет матча
WITH players_of_the_match AS (
	SELECT 
		match_id, MIN(player_id) AS player_1,
		MAX(player_id) AS player_2
	FROM tennis_analytics.match_player_stats
	GROUP BY match_id
),
match_data AS (
	SELECT 
		t.match_id,
		t.tournament_id,
		t.winner_id,
		t.round,
		t.match_date,
		CASE 
			WHEN t.winner_id = p.player_1 THEN p.player_2
			ELSE p.player_1
		END AS loser_id
	FROM tennis_analytics.tennis_match t 
	JOIN players_of_the_match p ON p.match_id = t.match_id
)
SELECT 
	md.match_id,
	STRING_AGG (ws.games_won || ':' || ls.games_won ||
	CASE 
		WHEN ws.tiebreak_points IS NOT NULL AND ls.tiebreak_points IS NOT NULL
		THEN '(' || ls.tiebreak_points || ')'
		ELSE ''
	END, ', ' ORDER BY ws.set_number)
FROM match_data md
JOIN tennis_analytics.match_set_score ws ON ws.match_id = md.match_id AND ws.player_id = md.winner_id
JOIN tennis_analytics.match_set_score ls ON ls.match_id = md.match_id AND ls.player_id = md.loser_id
AND ls.set_number = ws.set_number
GROUP BY md.match_id;



--3) рейтинг игроков по среднему числу эйсов за матч
SELECT 
	ms.player_id,
	p.first_name,
	p.last_name,
	AVG(ms.aces) AS avg_aces
FROM tennis_analytics.match_player_stats ms
JOIN tennis_analytics.player p ON p.player_id = ms.player_id
GROUP BY ms.player_id, p.first_name, p.last_name ORDER BY avg_aces DESC;


--4) текущая команда каждого игрока
WITH count_personnel AS (
SELECT pt.player_id, count(ptp.personnel_id) AS count_pers
FROM tennis_analytics.player_team_personnel ptp 
JOIN tennis_analytics.player_team pt ON pt.team_id = ptp.team_id
GROUP BY pt.player_id
)
SELECT 
	p.first_name, p.last_name,
	MAX(CASE WHEN ptp.ROLE = 'head_coach' THEN pers.first_name || ' ' || pers.last_name
		END) AS head_coach,
	MAX(CASE WHEN ptp.ROLE = 'fitness_coach' THEN pers.first_name || ' ' || pers.last_name
		END) AS fitness_coach,
	MAX(CASE WHEN ptp.ROLE = 'physio' THEN pers.first_name || ' ' || pers.last_name
		END) AS physio,
	MAX(CASE WHEN ptp.ROLE = 'psychologist' THEN pers.first_name || ' ' || pers.last_name
		END) AS psychologist,
	MAX(CASE WHEN ptp.ROLE = 'manager' THEN pers.first_name || ' ' || pers.last_name
		END) AS manager
FROM tennis_analytics.player_team_personnel ptp 
JOIN tennis_analytics.player_team pt ON pt.team_id = ptp.team_id
JOIN tennis_analytics.personnel pers ON pers.personnel_id = ptp.personnel_id
JOIN count_personnel cp ON pt.player_id = cp.player_id 
JOIN tennis_analytics.player p ON p.player_id = pt.player_id
WHERE pt.start_date <= CURRENT_DATE
  AND (pt.end_date >= CURRENT_DATE OR pt.end_date IS NULL)
  AND ptp.start_date <= CURRENT_DATE
  AND (ptp.end_date >= CURRENT_DATE OR ptp.end_date IS NULL)
GROUP BY p.first_name, p.last_name ORDER BY COUNT(cp.count_pers) DESC;


--5)рейтинг баз по количеству игроков
SELECT 
	tb.base_name, COUNT(DISTINCT player_id) count_players
FROM tennis_analytics.player_training_base ptb
JOIN tennis_analytics.training_base tb ON tb.base_id = ptb.base_id
GROUP BY tb.base_name
ORDER BY count_players DESC;


--6)рейтинг игроков по игре против более высоких соперников
WITH players_of_the_match AS (
	SELECT 
		match_id, MIN(player_id) AS player_1,
		MAX(player_id) AS player_2
	FROM tennis_analytics.match_player_stats
	GROUP BY match_id
),
players_heights AS (
	SELECT 
		potm.match_id,
		potm.player_1,
        potm.player_2,
		first.height_cm AS player_1_height,
		second.height_cm AS player_2_height
	FROM players_of_the_match potm
	JOIN tennis_analytics.player first ON potm.player_1 = first.player_id
	JOIN tennis_analytics.player second ON potm.player_2 = second.player_id
),
player1_vs_player2 AS (
	 SELECT 
		 match_id, 
		 player_1 AS player_id, 
		 player_2 AS opponent_id, 
		 player_1_height AS player_height, 
		 player_2_height AS opponent_height
	FROM players_heights
	UNION ALL
	 SELECT 
		 match_id, 
		 player_2 AS player_id, 
		 player_1 AS opponent_id, 
		 player_2_height AS player_height, 
		 player_1_height AS opponent_height
	FROM players_heights
),
matches_vs_taller AS (
	SELECT 
		pp.match_id, pp.player_id, pp.opponent_id,
		CASE 
			WHEN tm.winner_id = pp.player_id THEN 1
			ELSE 0
		END AS is_win
	FROM player1_vs_player2 pp
	JOIN tennis_analytics.tennis_match tm ON pp.match_id = tm.match_id
	WHERE pp.player_height <= pp.opponent_height 
)
SELECT 
	p.last_name, SUM(mvt.is_win), COUNT(*), ROUND(100.0 * SUM(mvt.is_win) / COUNT(*), 2) win_percent
FROM matches_vs_taller mvt  
JOIN tennis_analytics.player p ON mvt.player_id = p.player_id 
GROUP BY p.last_name ORDER BY win_percent DESC;


--7)игроки, у которых победы после проигранного первого сета и этот процент
WITH all_wins AS (
	SELECT mps.player_id, COUNT(*) wins
	FROM tennis_analytics.match_player_stats mps
	JOIN tennis_analytics.tennis_match tm ON tm.match_id = mps.match_id 
	WHERE tm.winner_id = mps.player_id
	GROUP BY mps.player_id
),
wins_with_comeback AS (
	SELECT mps.player_id, COUNT(*) AS comeback_wins 
	FROM tennis_analytics.match_player_stats mps
	JOIN tennis_analytics.tennis_match tm ON tm.match_id = mps.match_id 
	JOIN tennis_analytics.match_set_score mss ON mss.match_id = mps.match_id
	AND mss.player_id = mps.player_id 
	WHERE tm.winner_id = mps.player_id AND mss.set_number = 1
	AND (mss.games_won <= 5 OR (mss.games_won = 6 AND mss.tiebreak_points IS NOT NULL))
	GROUP BY mps.player_id	
)
SELECT
	p.last_name, wwc.comeback_wins, aw.wins, ROUND(100.0 * wwc.comeback_wins / aw.wins, 2) AS percent
FROM all_wins aw JOIN wins_with_comeback wwc ON wwc.player_id = aw.player_id
JOIN tennis_analytics.player p ON p.player_id = aw.player_id
ORDER BY percent DESC;


--8)сколько игроков у каждого спонсора
SELECT 
	s.sponsor_name,
	COUNT(ps.player_id) count_players
FROM tennis_analytics.player_sponsor ps 
JOIN tennis_analytics.sponsor s ON ps.sponsor_id = s.sponsor_id
GROUP BY s.sponsor_name
ORDER BY count_players DESC;


--9)рейтинг "чистоты" игроков 
WITH winners_to_unforced AS (
	SELECT player_id, SUM(winners - unforced_errors) AS win_vs_err
	FROM tennis_analytics.match_player_stats
	GROUP BY player_id
)
SELECT 
	p.last_name,
	wu.win_vs_err,
	RANK() OVER (
		ORDER BY wu.win_vs_err DESC
	) AS rank
FROM winners_to_unforced wu
JOIN tennis_analytics.player p ON p.player_id = wu.player_id;


--10)рейтинг игроков по количеству финалов
WITH finals_stat AS (
	SELECT 
		mps.player_id,
		COUNT(*) AS total_finals,
		SUM(CASE
				WHEN tm.winner_id = mps.player_id THEN 1
				ELSE 0 
			END) AS win_finals
	FROM tennis_analytics.tennis_match tm 
	JOIN tennis_analytics.match_player_stats mps ON tm.match_id = mps.match_id
	WHERE tm.round = 'Final'
	GROUP BY mps.player_id
)
SELECT 
	p.last_name,
	f.total_finals,
	f.win_finals,
	100 * f.win_finals / f.total_finals AS win_percent
FROM finals_stat f
JOIN tennis_analytics.player p ON p.player_id = f.player_id
ORDER BY ROUND(100.0 * f.win_finals / f.total_finals, 2) DESC;



