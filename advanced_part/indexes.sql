
CREATE INDEX idx_match_player_stats_player_id
ON tennis_analytics.match_player_stats(player_id);

CREATE INDEX idx_player_team_player_id
ON tennis_analytics.player_team(player_id);

CREATE INDEX idx_tennis_match_round
ON tennis_analytics.tennis_match(round);
