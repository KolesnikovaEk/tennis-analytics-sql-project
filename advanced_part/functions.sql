--1)полная сводка по матчу
CREATE OR REPLACE FUNCTION tennis_analytics.get_match_summary (
	p_match_id INTEGER
)
RETURNS TABLE (
	match_id INTEGER,
	tournament_id INTEGER,
	round VARCHAR(50),
	match_date DATE,
	winner_id INTEGER,
	loser_id INTEGER,
	score TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	WITH players_of_the_match AS (
		SELECT 
			mps.match_id, MIN(mps.player_id) AS player_1,
			MAX(mps.player_id) AS player_2
		FROM tennis_analytics.match_player_stats mps
		GROUP BY mps.match_id
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
	SELECT md.match_id, md.tournament_id, md.round, md.match_date, md.winner_id, md.loser_id,
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
	WHERE md.match_id = p_match_id
	GROUP BY md.match_id, md.tournament_id, md.round, md.match_date, md.winner_id, md.loser_id;
END
$$;



--2)статистика личных встреч двух игроков
CREATE OR REPLACE FUNCTION tennis_analytics.get_head_to_head(
	p_player1_id INTEGER,
	p_player2_id INTEGER
)
RETURNS TABLE (
	player1_id INTEGER,
    player2_id INTEGER,
	total_matches BIGINT,
    player1_wins  BIGINT,
    player2_wins  BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN 
	RETURN QUERY
	SELECT
        p_player1_id,
        p_player2_id,
        COUNT(mp.match_id) AS total_matches,
        SUM(CASE WHEN mp.winner_id = p_player1_id THEN 1 ELSE 0 END) AS player1_wins,
        SUM(CASE WHEN mp.winner_id = p_player2_id THEN 1 ELSE 0 END) AS player2_wins
    FROM tennis_analytics.match_players mp
    WHERE (mp.winner_id = p_player1_id AND mp.loser_id = p_player2_id)
       OR (mp.winner_id = p_player2_id AND mp.loser_id = p_player1_id);
END
$$;



--3)вставка матча
CREATE OR REPLACE PROCEDURE tennis_analytics.insert_match(
	p_match_id INTEGER,
    p_tournament_id INTEGER,
    p_round TEXT,
    p_match_date DATE,
    p_player1_id INTEGER,
    p_player2_id INTEGER,
    p_winner_id INTEGER,
    p_best_of_sets INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    start_date DATE;
    end_date DATE;
BEGIN
	SELECT t.start_date, t.end_date INTO start_date, end_date
	FROM tennis_analytics.tournament t
    WHERE t.tournament_id = p_tournament_id;
	
	IF (p_match_date BETWEEN start_date AND end_date)
		AND (p_player1_id <> p_player2_id)
		AND EXISTS (SELECT 1 FROM tennis_analytics.player p WHERE p.player_id = p_player1_id)
        AND EXISTS (SELECT 1 FROM tennis_analytics.player p  WHERE p.player_id = p_player2_id)
		AND (p_winner_id IN (p_player1_id, p_player2_id))
		AND NOT EXISTS (SELECT 1 FROM tennis_analytics.tennis_match tm WHERE tm.match_id = p_match_id)
		AND (p_best_of_sets IN (3, 5))
	THEN
		INSERT INTO tennis_analytics.tennis_match (
            match_id,
            tournament_id,
            round,
            match_date,
            winner_id,
			best_of_sets
        )
        VALUES (
            p_match_id,
            p_tournament_id,
            p_round,
            p_match_date,
            p_winner_id,
			p_best_of_sets
        );
	END IF;
END
$$;
