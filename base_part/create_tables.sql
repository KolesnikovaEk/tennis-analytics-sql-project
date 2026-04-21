DROP SCHEMA IF EXISTS tennis_analytics CASCADE;
CREATE SCHEMA tennis_analytics;

CREATE TABLE tennis_analytics.player (
    player_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    country VARCHAR(100) NOT NULL,
    height_cm INT CHECK (height_cm BETWEEN 100 AND 250),
    handedness CHAR(1) NOT NULL CHECK (handedness IN ('L', 'R', 'B'))
);


CREATE TABLE tennis_analytics.training_base (
    base_id INT PRIMARY KEY,
    base_name VARCHAR(200) NOT NULL,
    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    surface_type VARCHAR(20),
    is_outdoor BOOLEAN NOT NULL
);


CREATE TABLE tennis_analytics.player_training_base (
    player_id INT NOT NULL,
    base_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_player_training_base
        PRIMARY KEY (player_id, base_id, start_date),
    CONSTRAINT fk_player_training_base_player
        FOREIGN KEY (player_id)
        REFERENCES tennis_analytics.player(player_id),
    CONSTRAINT fk_player_training_base_base
        FOREIGN KEY (base_id)
        REFERENCES tennis_analytics.training_base(base_id),
    CONSTRAINT chk_player_training_base_dates
        CHECK (end_date IS NULL OR end_date >= start_date)
);





CREATE TABLE tennis_analytics.tournament (
    tournament_id INT PRIMARY KEY,
    tournament_name VARCHAR(200) NOT NULL,
    location VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    surface VARCHAR(20) NOT NULL,
    prize_pool NUMERIC(15, 2) CHECK (prize_pool >= 0),
    CONSTRAINT chk_tournament_dates
        CHECK (end_date >= start_date)
);

CREATE TABLE tennis_analytics.personnel (
    personnel_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE tennis_analytics.sponsor (
    sponsor_id INT PRIMARY KEY,
    sponsor_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL
);

CREATE TABLE tennis_analytics.player_team (
    team_id INT PRIMARY KEY,
    player_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    CONSTRAINT fk_player_team_player
        FOREIGN KEY (player_id)
        REFERENCES tennis_analytics.player(player_id),
    CONSTRAINT chk_player_team_dates
        CHECK (end_date IS NULL OR end_date >= start_date)
);


CREATE TABLE tennis_analytics.player_team_personnel (
    team_id INT NOT NULL,
    personnel_id INT NOT NULL,
    start_date DATE NOT NULL,
    role VARCHAR(30) NOT NULL,
    end_date DATE,
    CONSTRAINT pk_player_team_personnel
        PRIMARY KEY (team_id, personnel_id, start_date),
    CONSTRAINT fk_player_team_personnel_team
        FOREIGN KEY (team_id)
        REFERENCES tennis_analytics.player_team(team_id),
    CONSTRAINT fk_player_team_personnel_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES tennis_analytics.personnel(personnel_id),
    CONSTRAINT chk_player_team_personnel_role
        CHECK (role IN ('head_coach', 'fitness_coach', 'physio', 'psychologist', 'manager')),
    CONSTRAINT chk_player_team_personnel_dates
        CHECK (end_date IS NULL OR end_date >= start_date)
);

CREATE TABLE tennis_analytics.player_sponsor (
    player_id INT NOT NULL,
    sponsor_id INT NOT NULL,
    contract_start DATE NOT NULL,
    contract_end DATE,
    contract_value NUMERIC(15, 2) CHECK (contract_value >= 0),
    CONSTRAINT pk_player_sponsor
        PRIMARY KEY (player_id, sponsor_id, contract_start),
    CONSTRAINT fk_player_sponsor_player
        FOREIGN KEY (player_id)
        REFERENCES tennis_analytics.player(player_id),
    CONSTRAINT fk_player_sponsor_sponsor
        FOREIGN KEY (sponsor_id)
        REFERENCES tennis_analytics.sponsor(sponsor_id),
    CONSTRAINT chk_player_sponsor_dates
        CHECK (contract_end IS NULL OR contract_end >= contract_start)
);

CREATE TABLE tennis_analytics.tennis_match (
    match_id INT PRIMARY KEY,
    tournament_id INT NOT NULL,
    match_date DATE NOT NULL,
    round VARCHAR(50) NOT NULL,
    winner_id INT NOT NULL,
    best_of_sets INT NOT NULL CHECK (best_of_sets IN (3, 5)),
    CONSTRAINT fk_tennis_match_tournament
        FOREIGN KEY (tournament_id)
        REFERENCES tennis_analytics.tournament(tournament_id),
    CONSTRAINT fk_tennis_match_winner
        FOREIGN KEY (winner_id)
        REFERENCES tennis_analytics.player(player_id)
);

CREATE TABLE tennis_analytics.match_player_stats (
    match_id INT NOT NULL,
    player_id INT NOT NULL,
    aces INT NOT NULL DEFAULT 0 CHECK (aces >= 0),
    double_faults INT NOT NULL DEFAULT 0 CHECK (double_faults >= 0),
    unforced_errors INT NOT NULL DEFAULT 0 CHECK (unforced_errors >= 0),
    winners INT NOT NULL DEFAULT 0 CHECK (winners >= 0),
    break_points_won INT NOT NULL DEFAULT 0 CHECK (break_points_won >= 0),
    break_points_total INT NOT NULL DEFAULT 0 CHECK (break_points_total >= break_points_won),
    CONSTRAINT pk_match_player_stats
        PRIMARY KEY (match_id, player_id),
    CONSTRAINT fk_match_player_stats_match
        FOREIGN KEY (match_id)
        REFERENCES tennis_analytics.tennis_match(match_id),
    CONSTRAINT fk_match_player_stats_player
        FOREIGN KEY (player_id)
        REFERENCES tennis_analytics.player(player_id)
);

CREATE TABLE tennis_analytics.match_set_score (
    match_id INT NOT NULL,
    player_id INT NOT NULL,
    set_number INT NOT NULL,
    games_won INT NOT NULL CHECK (games_won >= 0),
    tiebreak_points INT CHECK (tiebreak_points IS NULL OR tiebreak_points >= 0),
    CONSTRAINT pk_match_set_score
        PRIMARY KEY (match_id, player_id, set_number),
    CONSTRAINT fk_match_set_score_match_player
        FOREIGN KEY (match_id, player_id)
        REFERENCES tennis_analytics.match_player_stats(match_id, player_id),
    CONSTRAINT chk_match_set_score_set_number
        CHECK (set_number  > 0 AND set_number <= 5)
);

