--1)проверка счета сета
CREATE  OR REPLACE FUNCTION tennis_analytics.check_set_score()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
	DECLARE	
	v_max_games INTEGER;
	v_min_games INTEGER;
	v_is_tiebreak BOOLEAN;
BEGIN 
	IF (SELECT COUNT(DISTINCT player_id) 
		FROM tennis_analytics.match_set_score 
		WHERE match_id = NEW.match_id
		AND set_number = NEW.set_number
	) > 2 THEN
        RAISE EXCEPTION 'В одном сете не может быть >2 игроков';
    END IF;
	IF (SELECT COUNT(DISTINCT player_id) 
	    FROM tennis_analytics.match_set_score 
	    WHERE match_id = NEW.match_id
	      AND set_number = NEW.set_number
	) < 2 THEN
	    RETURN NEW;
	END IF;
	SELECT 
        MAX(games_won),
        MIN(games_won)
    INTO
        v_max_games,
        v_min_games
    FROM tennis_analytics.match_set_score
    WHERE match_id = NEW.match_id
      AND set_number = NEW.set_number;
	IF v_max_games < 6 OR v_max_games > 7 THEN
        RAISE EXCEPTION 'Победитель сета должен иметь 6 или 7 геймов';
    END IF;
	IF v_max_games = 6 AND v_min_games > 4 THEN
        RAISE EXCEPTION 'Некорректный счет сета';
    END IF;
	IF v_max_games = 7 AND v_min_games NOT IN (5, 6) THEN
        RAISE EXCEPTION 'Некорректный счет сета';
    END IF;
	SELECT BOOL_OR(tiebreak_points IS NOT NULL AND tiebreak_points > 0)
    INTO v_is_tiebreak
    FROM tennis_analytics.match_set_score
    WHERE match_id = NEW.match_id
      AND set_number = NEW.set_number;
    IF v_max_games = 7 AND v_min_games = 6 AND NOT v_is_tiebreak THEN
        RAISE EXCEPTION 'При счете 7:6 должен быть тай-брейк';
    END IF;
    IF NOT (v_max_games = 7 AND v_min_games = 6) AND v_is_tiebreak THEN
        RAISE EXCEPTION 'Тай-брейк может быть только при счете 7:6';
    END IF;
	RETURN NEW;
END;
$$;


--2)проверка счета матча 
CREATE OR REPLACE FUNCTION tennis_analytics.check_match_score()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN 
	IF (SELECT COUNT(DISTINCT player_id)
	    FROM tennis_analytics.match_set_score
	    WHERE match_id = NEW.match_id
	) > 2 THEN
	    RAISE EXCEPTION 'В матче не может быть больше 2 игроков';
	END IF;
	IF (SELECT COUNT(DISTINCT player_id)
	    FROM tennis_analytics.match_set_score
	    WHERE match_id = NEW.match_id
	) < 2 THEN
	    RETURN NEW;
	END IF;
	IF EXISTS (
	    SELECT 1
	    FROM tennis_analytics.match_set_score
	    WHERE match_id = NEW.match_id
	    GROUP BY set_number
	    HAVING COUNT(*) > 2
	) THEN
		RAISE EXCEPTION 'В одном сете не может быть >2 записей';
	END IF;
	IF EXISTS (
	    SELECT 1
	    FROM tennis_analytics.match_set_score
	    WHERE match_id = NEW.match_id
	    GROUP BY set_number
	    HAVING COUNT(*) < 2
	) THEN
	    RETURN NEW;
	END IF;
	IF (SELECT MAX(set_number) FROM tennis_analytics.match_set_score
		WHERE match_id = NEW.match_id
	) > (
		SELECT best_of_sets
		FROM tennis_analytics.tennis_match
		WHERE match_id = NEW.match_id
	) THEN
		RAISE EXCEPTION 'Номер сета не должен превышать best_of_sets';
	END IF;
	IF (SELECT winner_id
	    FROM tennis_analytics.tennis_match
	    WHERE match_id = NEW.match_id) NOT IN (
	    SELECT player_id
	    FROM tennis_analytics.match_set_score
	    WHERE match_id = NEW.match_id
	) THEN
	    RAISE EXCEPTION 'winner_id должен быть одним из игроков матча';
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER trg_check_set_score
AFTER INSERT OR UPDATE
ON tennis_analytics.match_set_score
FOR EACH ROW
EXECUTE FUNCTION tennis_analytics.check_set_score();

CREATE TRIGGER trg_check_match_score
AFTER INSERT OR UPDATE
ON tennis_analytics.match_set_score
FOR EACH ROW
EXECUTE FUNCTION tennis_analytics.check_match_score();
