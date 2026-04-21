INSERT INTO tennis_analytics.player
(player_id, first_name, last_name, birth_date, country, height_cm, handedness)
VALUES
(1, 'Carlos', 'Alcaraz', '2003-05-05', 'Spain', 183, 'R'),
(2, 'Jannik', 'Sinner', '2001-08-16', 'Italy', 191, 'R'),
(3, 'Novak', 'Djokovic', '1987-05-22', 'Serbia', 188, 'R'),
(4, 'Alexander', 'Zverev', '1997-04-20', 'Germany', 198, 'R'),
(5, 'Lorenzo', 'Musetti', '2002-03-03', 'Italy', 185, 'R'),
(6, 'Alex', 'de Minaur', '1999-02-17', 'Australia', 183, 'R'),
(7, 'Taylor', 'Fritz', '1997-10-28', 'USA', 196, 'R'),
(8, 'Felix', 'Auger-Aliassime', '2000-08-08', 'Canada', 193, 'R'),
(9, 'Ben', 'Shelton', '2002-10-09', 'USA', 193, 'L'),
(10, 'Daniil', 'Medvedev', '1996-02-11', 'Russia', 198, 'R'),
(11, 'Aryna', 'Sabalenka', '1998-05-05', 'Belarus', 182, 'R'),
(12, 'Elena', 'Rybakina', '1999-06-17', 'Kazakhstan', 184, 'R'),
(13, 'Iga', 'Swiatek', '2001-05-31', 'Poland', 176, 'R'),
(14, 'Coco', 'Gauff', '2004-03-13', 'USA', 175, 'R'),
(15, 'Jessica', 'Pegula', '1994-02-24', 'USA', 170, 'R'),
(16, 'Amanda', 'Anisimova', '2001-08-31', 'USA', 180, 'R'),
(17, 'Jasmine', 'Paolini', '1996-01-04', 'Italy', 163, 'R'),
(18, 'Elina', 'Svitolina', '1994-09-12', 'Ukraine', 174, 'R'),
(19, 'Victoria', 'Mboko', '2006-08-26', 'Canada', 176, 'R'),
(20, 'Mirra', 'Andreeva', '2007-04-29', 'Russia', 175, 'R');


INSERT INTO tennis_analytics.training_base
(base_id, base_name, country, city, surface_type, is_outdoor)
VALUES
(1, 'Ferrero Tennis Academy / Equelite', 'Spain', 'Villena', NULL, TRUE),
(2, 'Monte-Carlo Country Club', 'France', 'Roquebrune-Cap-Martin', 'Clay', TRUE),
(3, 'Rafa Nadal Academy by Movistar', 'Spain', 'Manacor', NULL, TRUE),
(4, 'Mouratoglou Tennis Academy', 'France', 'Biot', NULL, TRUE),
(5, 'Elite Tennis Center', 'France', 'Cannes', NULL, TRUE),
(6, 'Tennis Canada National Training Centre', 'Canada', 'Montreal', NULL, FALSE),
(7, 'National Tennis Academy', 'Belarus', 'Minsk', NULL, FALSE),
(8, 'Spartak Tennis Club', 'Russia', 'Moscow', NULL, FALSE),
(9, 'Mera Warsaw Tennis Club', 'Poland', 'Warsaw', NULL, TRUE),
(10, 'Tennis Club Italia', 'Italy', 'Forte dei Marmi', 'Clay', TRUE),
(11, 'USTA Training Center', 'USA', 'Carson', 'Hard', TRUE),
(12, 'ProWorld Tennis Academy', 'USA', 'Delray Beach', 'Hard', TRUE),
(13, 'Piatti Tennis Center', 'Italy', 'Bordighera', NULL, TRUE),
(14, '4Slam Tennis Academy', 'UAE', 'Dubai', NULL, FALSE),
(15, 'CF Tennis Academy', 'UAE', 'Dubai', NULL, FALSE),
(16, 'Saddlebrook Tennis Academy', 'USA', 'Wesley Chapel', NULL, TRUE),
(17, 'IMG Academy', 'USA', 'Bradenton', NULL, TRUE),
(18, 'Justine Henin Academy', 'Belgium', 'Limelette', NULL, FALSE),
(19, 'Murcia Performance Base', 'Spain', 'Murcia', NULL, TRUE),
(20, 'Alicante High Performance Base', 'Spain', 'Alicante', NULL, TRUE);



INSERT INTO tennis_analytics.player_training_base
(player_id, base_id, start_date, end_date, is_primary)
VALUES
(1, 1, '2018-01-01', NULL, TRUE),
(1, 19, '2018-01-01', '2019-12-31', FALSE),
(2, 13, '2014-01-01', '2022-02-28', TRUE),
(3, 2, '2023-01-01', NULL, TRUE),
(4, 16, '2013-01-01', '2018-12-31', TRUE),
(5, 10, '2024-01-01', NULL, TRUE),
(6, 20, '2017-01-01', NULL, TRUE),
(7, 11, '2013-01-01', '2015-12-31', TRUE),
(8, 2, '2024-01-01', NULL, TRUE),
(8, 3, '2023-02-01', '2023-02-28', FALSE),
(9, 4, '2024-01-01', NULL, TRUE),
(10, 5, '2014-01-01', '2021-12-31', TRUE),
(11, 7, '2014-01-01', '2017-12-31', TRUE),
(12, 8, '2010-01-01', '2018-12-31', TRUE),
(13, 9, '2016-01-01', '2018-12-31', TRUE),
(14, 4, '2014-01-01', '2018-12-31', TRUE),
(15, 12, '2025-01-01', NULL, TRUE),
(16, 12, '2025-01-01', NULL, TRUE),
(17, 10, '2024-01-01', NULL, TRUE),
(18, 15, '2024-01-01', NULL, TRUE),
(19, 6, '2021-01-01', NULL, TRUE),
(20, 5, '2022-01-01', NULL, TRUE);


INSERT INTO tennis_analytics.sponsor
(sponsor_id, sponsor_name, country, industry)
VALUES
(1, 'BMW', 'Germany', 'Cars'),
(2, 'Babolat', 'France', 'Sports Equipment'),
(3, 'Nike', 'USA', 'Sportswear'),
(4, 'Lacoste', 'France', 'Clothing'),
(5, 'Hublot', 'Switzerland', 'Luxury Watches'),
(6, 'adidas', 'Germany', 'Sportswear'),
(7, 'ASICS', 'Japan', 'Sportswear'),
(8, 'HEAD', 'Austria', 'Sports Equipment'),
(9, 'Wilson Sporting Goods', 'USA', 'Sports Equipment'),
(10, 'BOSS', 'Germany', 'Fashion'),
(11, 'Rolex', 'Switzerland', 'Luxury Watches'),
(12, 'On', 'Switzerland', 'Sportswear'),
(13, 'Emirates', 'UAE', 'Airline'),
(14, 'OAKBERRY', 'Brazil', 'Food & Beverage'),
(15, 'Yonex', 'Japan', 'Sports Equipment'),
(16, 'Lancome', 'France', 'Beauty'),
(17, 'New Balance', 'USA', 'Sportswear'),
(18, 'Ready', 'USA', 'Sports Nutrition'),
(19, 'Gatorade', 'USA', 'Sports Nutrition'),
(20, 'Alfa Romeo', 'Italy', 'Cars'),
(21, 'Amazfit', 'China', 'Smart Devices'),
(22, 'Diadem Sports', 'USA', 'Sports Equipment'),
(23, 'Porsche', 'Germany', 'Cars');



INSERT INTO tennis_analytics.player_sponsor
(player_id, sponsor_id, contract_start, contract_end, contract_value)
VALUES
(1, 1, '2025-09-17', NULL, NULL),
(1, 2, '2023-08-25', NULL, NULL),
(2, 3, '2026-02-09', NULL, NULL),
(3, 4, '2017-05-22', NULL, NULL),
(3, 5, '2024-11-20', NULL, NULL),
(4, 6, '2016-02-01', NULL, NULL),
(5, 7, '2025-01-02', NULL, NULL),
(5, 8, '2025-10-16', NULL, NULL),
(6, 9, '2026-01-16', NULL, NULL),
(7, 10, '2024-03-06', NULL, NULL),
(8, 6, '2021-01-19', NULL, NULL),
(9, 11, '2024-01-14', NULL, NULL),
(9, 12, '2023-08-30', NULL, NULL),
(10, 4, '2023-01-16', NULL, NULL),
(11, 13, '2026-01-15', NULL, NULL),
(11, 14, '2024-01-11', NULL, NULL),
(12, 15, '2025-05-21', NULL, NULL),
(13, 16, '2024-04-16', NULL, NULL),
(13, 23, '2023-06-26', NULL, NULL),
(14, 17, '2025-04-23', NULL, NULL),
(15, 18, '2022-08-31', NULL, NULL),
(16, 19, '2020-01-24', NULL, NULL),
(17, 20, '2025-05-08', NULL, NULL),
(17, 21, '2025-02-18', NULL, NULL),
(18, 22, '2025-06-24', NULL, NULL),
(19, 9, '2026-01-16', NULL, NULL),
(20, 11, '2025-01-28', NULL, NULL);



INSERT INTO tennis_analytics.tournament
(tournament_id, tournament_name, location, category, start_date, end_date, surface, prize_pool)
VALUES
(1, 'Australian Open 2026', 'Melbourne, Australia', 'Grand Slam', '2026-01-18', '2026-02-01', 'Hard', NULL),
(2, 'BNP Paribas Open 2026 WTA', 'Indian Wells, USA', 'WTA 1000', '2026-03-04', '2026-03-15', 'Hard', NULL),
(3, 'Miami Open 2026 WTA', 'Miami, USA', 'WTA 1000', '2026-03-18', '2026-03-31', 'Hard', NULL),
(4, 'BNP Paribas Open 2026 ATP', 'Indian Wells, USA', 'ATP Masters 1000', '2026-03-04', '2026-03-15', 'Hard', NULL),
(5, 'ATP Finals 2025', 'Turin, Italy', 'ATP Finals', '2025-11-09', '2025-11-16', 'Hard (Indoor)', NULL),
(6, 'Paris Masters 2025', 'Paris, France', 'ATP Masters 1000', '2025-10-27', '2025-11-02', 'Hard (Indoor)', NULL),
(7, 'Dubai Tennis Championships 2026 ATP', 'Dubai, UAE',  'ATP 500',  '2026-02-23', '2026-02-28', 'Hard', NULL),
(8, 'Ningbo Open 2025 WTA', 'Ningbo, China', 'WTA 500', '2025-10-13', '2025-10-19', 'Hard', NULL),
(9, 'Wuhan Open 2025 WTA', 'Wuhan, China', 'WTA 1000', '2025-10-06', '2025-10-12', 'Hard', NULL),
(10, 'Dubai Tennis Championships 2026 WTA', 'Dubai, UAE', 'WTA 1000', '2026-02-16', '2026-02-22', 'Hard', NULL),
(11, 'Rolex Monte-Carlo Masters 2025', 'Monte Carlo, Monaco', 'ATP Masters 1000', '2025-04-06', '2025-04-13', 'Clay', NULL),
(12, 'Mutua Madrid Open 2025 ATP', 'Madrid, Spain', 'ATP Masters 1000', '2025-04-23', '2025-05-04', 'Clay', NULL),
(13, 'Mutua Madrid Open 2025 WTA', 'Madrid, Spain', 'WTA 1000', '2025-04-22', '2025-05-04', 'Clay', NULL),
(14, 'Internazionali BNL d''Italia 2025 ATP', 'Rome, Italy', 'ATP Masters 1000', '2025-05-07', '2025-05-18', 'Clay', NULL),
(15, 'Internazionali BNL d''Italia 2025 WTA', 'Rome, Italy', 'WTA 1000', '2025-05-06', '2025-05-18', 'Clay', NULL),
(16, 'Cincinnati Open 2025 ATP', 'Cincinnati, USA', 'ATP Masters 1000', '2025-08-07', '2025-08-18', 'Hard', NULL),
(17, 'Cincinnati Open 2025 WTA', 'Cincinnati, USA', 'WTA 1000', '2025-08-07', '2025-08-18', 'Hard', NULL),
(18, 'US Open 2025', 'New York, USA', 'Grand Slam', '2025-08-25', '2025-09-07', 'Hard', NULL),
(19, 'Wimbledon 2025', 'London, Great Britain', 'Grand Slam', '2025-06-30', '2025-07-13', 'Grass', NULL),
(20, 'Roland Garros 2025', 'Paris, France', 'Grand Slam', '2025-05-25', '2025-06-08', 'Clay', NULL);


INSERT INTO tennis_analytics.tennis_match
(match_id, tournament_id, match_date, round, winner_id, best_of_sets)
VALUES
(1, 1, '2026-02-01', 'Final', 1, 5),  -- Alcaraz / Djokovic
(2, 1, '2026-01-30', 'Semifinal', 1, 5),  -- Alcaraz / Zverev
(3, 1, '2026-01-30', 'Semifinal', 3, 5),  -- Djokovic / Sinner
(4, 1, '2026-01-28', 'Quarterfinal', 2, 5),  -- Sinner / Shelton
(5, 1, '2026-01-31', 'Final', 12, 3),  -- Rybakina / Sabalenka
(6, 1, '2026-01-29', 'Semifinal', 12, 3),  -- Pegula / Rybakina
(7, 1, '2026-01-25', 'Round of 16', 11, 3),  -- Sabalenka / Mboko
(8, 2, '2026-03-15', 'Final', 11, 3),  -- Sabalenka / Rybakina
(9, 3, '2026-03-23', 'Round of 16', 19, 3),  -- Andreeva / Mboko
(10, 4, '2026-03-15', 'Semifinal', 10, 3),  -- Alcaraz / Medvedev
(11, 5, '2025-11-16', 'Final', 2, 3),  -- Alcaraz / Sinner
(12, 5, '2025-11-11', 'Group Stage', 1, 3),  -- Alcaraz / Fritz
(13, 4, '2026-03-14', 'Semifinal', 2, 3),  -- Zverev / Sinner
(14, 5, '2025-11-14', 'Semifinal', 2, 3),  -- Sinner / Shelton
(15, 6, '2025-11-02', 'Final', 2, 3),  -- Auger-Aliassime  Sinner
(16, 10, '2026-02-19', 'Quarterfinal', 16, 3),
(17, 8, '2025-10-18', 'Semifinal', 12, 3),  -- Rybakina / Paolini
(18, 9, '2025-10-11', 'Semifinal', 14, 3),  -- Gauff / Paolini
(19, 9, '2025-10-11', 'Semifinal', 15, 3),  -- Sabalenka / Pegula
(20, 2, '2026-03-11', 'Round of 16', 19, 3);  -- Mboko / Anisimova



INSERT INTO tennis_analytics.match_player_stats
(match_id, player_id, aces, double_faults, unforced_errors, winners, break_points_won, break_points_total)
VALUES
(1, 1, 9, 2, 27, 36, 5, 16),
(1, 3, 4, 2, 46, 32, 2,  6),
(2, 1, 12, 5, 58, 78, 4, 14),
(2, 4, 17, 4, 55, 56, 2,  7),
(3, 3, 12, 3, 42, 46, 3,  8),
(3, 2, 26, 2, 42, 72, 2, 18),
(4, 9, 8, 3, 0, 31, 0,  4),
(4, 2, 5, 2, 0, 33, 3, 12),
(5, 11, 5, 2, 25, 35, 2,  8),
(5, 12, 6, 3, 24, 28, 3,  6),
(6, 15, 2, 0, 19, 14, 3,  4),
(6, 12, 6, 0, 29, 31, 4, 10),
(7, 11, 6, 3, 24, 31, 4, 5),
(7, 19, 3, 3, 20, 19, 2, 6),
(11, 1, 5, 0, 26, 28, 1, 3),
(11, 2, 8, 5, 24, 25, 2, 2),
(12, 1, 9, 2, 38, 47, 3, 11),
(12, 7, 14, 2, 39, 37, 1, 9),
(14, 2, 11, 0, 14, 27, 2, 4),
(14, 9, 6, 2, 14, 22, 0, 1),
(15, 8, 8, 2, 13, 20, 0, 0),
(15, 2, 6, 2, 8, 22, 1, 6),
(16, 20, 6, 7, 0, 0, 9, 16),
(16, 16, 0, 8, 0, 0, 8, 15),
(17, 12, 10, 4, 0, 0, 3, 10),
(17, 17, 0, 2, 0, 0, 0, 7),
(18, 14, 1, 7, 0, 0, 7, 9),
(18, 17, 0, 0, 0, 0, 5, 6),
(19, 11, 10, 3, 0, 0, 8, 17),
(19, 15, 5, 4, 0, 0, 7, 12),
(20, 19, 0, 0, 0, 0, 0, 0),
(20, 16, 0, 0, 0, 0, 0, 0);


INSERT INTO tennis_analytics.match_player_stats
(match_id, player_id, aces, double_faults)
VALUES
(8, 11, 10, 3),
(8, 12, 12, 2),
(9, 20, 6,  4),
(9, 19, 8, 10),
(10, 1, 2, 2),
(10, 10, 4, 0),
(13, 4, 4, 3),
(13, 2, 8, 2);



INSERT INTO tennis_analytics.match_set_score
(match_id, player_id, set_number, games_won, tiebreak_points)
VALUES
(1, 1, 1, 2, NULL),
(1, 3, 1, 6, NULL),
(1, 1, 2, 6, NULL),
(1, 3, 2, 2, NULL),
(1, 1, 3, 6, NULL),
(1, 3, 3, 3, NULL),
(1, 1, 4, 7, NULL),
(1, 3, 4, 5, NULL),
(2, 1, 1, 6, NULL),
(2, 4, 1, 4, NULL),
(2, 1, 2, 7, 7),
(2, 4, 2, 6, 5),
(2, 1, 3, 6, 3),
(2, 4, 3, 7, 7),
(2, 1, 4, 6, 4),
(2, 4, 4, 7, 7),
(2, 1, 5, 7, NULL),
(2, 4, 5, 5, NULL),
(3, 3, 1, 3, NULL),
(3, 2, 1, 6, NULL),
(3, 3, 2, 6, NULL),
(3, 2, 2, 3, NULL),
(3, 3, 3, 4, NULL),
(3, 2, 3, 6, NULL),
(3, 3, 4, 6, NULL),
(3, 2, 4, 4, NULL),
(3, 3, 5, 6, NULL),
(3, 2, 5, 4, NULL),
(4, 9, 1, 3, NULL),
(4, 2, 1, 6, NULL),
(4, 9, 2, 4, NULL),
(4, 2, 2, 6, NULL),
(4, 9, 3, 4, NULL),
(4, 2, 3, 6, NULL),
(5, 11, 1, 4, NULL),
(5, 12, 1, 6, NULL),
(5, 11, 2, 6, NULL),
(5, 12, 2, 4, NULL),
(5, 11, 3, 4, NULL),
(5, 12, 3, 6, NULL),
(6, 15, 1, 3, NULL),
(6, 12, 1, 6, NULL),
(6, 15, 2, 6, 7),
(6, 12, 2, 7, 9),
(7, 11, 1, 6, NULL),
(7, 19, 1, 1, NULL),
(7, 11, 2, 7, 7),
(7, 19, 2, 6, 1),
(8, 11, 1, 3, NULL),
(8, 12, 1, 6, NULL),
(8, 11, 2, 6, NULL),
(8, 12, 2, 3, NULL),
(8, 11, 3, 7, 8),
(8, 12, 3, 6, 6),
(9, 20, 1, 6, 4),
(9, 19, 1, 7, 7),
(9, 20, 2, 6, NULL),
(9, 19, 2, 4, NULL),
(9, 20, 3, 0, NULL),
(9, 19, 3, 6, NULL),
(10, 1, 1, 3, NULL),
(10, 10, 1, 6, NULL),
(10, 1, 2, 6, 3),
(10, 10, 2, 7, 7),
(11, 1, 1, 6, 4),
(11, 2, 1, 7, 7),
(11, 1, 2, 5, NULL),
(11, 2, 2, 7, NULL),
(12, 1, 1, 6, 2),
(12, 7, 1, 7, 7),
(12, 1, 2, 7, NULL),
(12, 7, 2, 5, NULL),
(12, 1, 3, 6, NULL),
(12, 7, 3, 3, NULL),
(13, 4, 1, 2, NULL),
(13, 2, 1, 6, NULL),
(13, 4, 2, 4, NULL),
(13, 2, 2, 6, NULL),
(14, 2, 1, 6, NULL),
(14, 9, 1, 3, NULL),
(14, 2, 2, 7, 7),
(14, 9, 2, 6, 3),
(15, 8, 1, 4, NULL),
(15, 2, 1, 6, NULL),
(15, 8, 2, 6, 4),
(15, 2, 2, 7, 7),
(16, 20, 1, 6, NULL),
(16, 16, 1, 2, NULL),
(16, 20, 2, 5, NULL),
(16, 16, 2, 7, NULL),
(16, 20, 3, 6, 4),
(16, 16, 3, 7, 7),
(17, 12, 1, 6, NULL),
(17, 17, 1, 3, NULL),
(17, 12, 2, 6, NULL),
(17, 17, 2, 2, NULL),
(18, 14, 1, 6, NULL),
(18, 17, 1, 4, NULL),
(18, 14, 2, 6, NULL),
(18, 17, 2, 3, NULL),
(19, 11, 1, 6, NULL),
(19, 15, 1, 2, NULL),
(19, 11, 2, 4, NULL),
(19, 15, 2, 6, NULL),
(19, 11, 3, 6, 2),
(19, 15, 3, 7, 7),
(20, 19, 1, 6, NULL),
(20, 16, 1, 4, NULL),
(20, 19, 2, 6, NULL),
(20, 16, 2, 1, NULL);


INSERT INTO tennis_analytics.personnel
(personnel_id, first_name, last_name, birth_date, country)
VALUES
(1, 'Juan Carlos', 'Ferrero', '1980-02-12', 'Spain'),
(2, 'Samuel', 'Lopez', '1970-02-01', 'Spain'),
(3, 'Simone', 'Vagnozzi', '1983-05-30', 'Italy'),
(4, 'Dusan', 'Vemic', '1976-06-17', 'Serbia'),
(5, 'Alexander', 'Zverev Sr.', '1960-01-22', 'Germany'),
(6, 'Simone', 'Tartarini', '1968-11-30', 'Italy'),
(7, 'Matt', 'Reid', '1990-07-17', 'Australia'),
(8, 'Michael', 'Russell', '1978-05-01', 'USA'),
(9, 'Frederic', 'Fontang', '1970-03-18', 'France'),
(10, 'Bryan', 'Shelton', '1965-12-22', 'USA'),
(11, 'Gilles', 'Cervara', '1981-01-02', 'France'),
(12, 'Anton', 'Dubrov', '1995-06-18', 'Belarus'),
(13, 'Goran', 'Ivanisevic', '1971-09-13', 'Croatia'),
(14, 'Wim', 'Fissette', '1980-03-22', 'Belgium'),
(15, 'Jean-Christophe', 'Faurel', '1981-03-06', 'France'),
(16, 'Mark', 'Merklein', '1972-06-28', 'Bahamas'),
(17, 'Hendrik', 'Vleeshouwers', '1985-09-27', 'Netherlands'),
(18, 'Sara', 'Errani', '1987-04-29', 'Italy'),
(19, 'Andrew', 'Bettles', '1993-01-18', 'Great Britain'),
(20, 'Nathalie', 'Tauziat', '1967-10-17', 'France'),
(21, 'Conchita', 'Martinez', '1972-04-16', 'Spain'),
(22, 'Daria', 'Abramowicz', '1987-10-10', 'Poland'),
(23, 'Maciej', 'Ryszczuk', '1986-05-27', 'Poland'),
(24, 'Dieter', 'Kindlmann', '1982-06-03', 'Germany');



INSERT INTO tennis_analytics.player_team
(team_id, player_id, start_date, end_date)
VALUES
(1, 1, '2018-01-01', '2025-12-17'),
(2, 1, '2026-01-01', NULL),
(3, 2, '2022-02-01', NULL),
(4, 3, '2025-05-20', NULL),
(5, 4, '2026-01-01', NULL),
(6, 5, '2026-01-01', NULL),
(7, 6, '2026-01-01', NULL),
(8, 7, '2021-01-01', NULL),
(9, 8, '2017-01-01', NULL),
(10, 9, '2023-01-01', NULL),
(11, 10, '2017-01-01', '2025-08-31'),
(12, 11, '2020-09-01', NULL),
(13, 12, '2025-01-01', NULL),
(14, 13, '2024-10-17', '2026-03-23'),
(15, 14, '2019-03-01', NULL),
(16, 15, '2024-02-01', NULL),
(17, 16, '2023-07-01', NULL),
(18, 17, '2025-12-09', NULL),
(19, 18, '2026-01-01', NULL),
(20, 19, '2026-01-01', NULL),
(21, 20, '2024-04-01', NULL),
(22, 11, '2020-08-01', '2020-08-31'),
(23, 16, '2020-01-01', '2020-12-31'),
(24, 4, '2017-08-01', '2018-02-28');


INSERT INTO tennis_analytics.player_team_personnel
(team_id, personnel_id, start_date, role, end_date)
VALUES
(1, 1, '2018-01-01', 'head_coach', '2025-12-17'),
(2, 2, '2026-01-01', 'head_coach', NULL),
(3, 3, '2022-02-01', 'head_coach', NULL),
(4, 4, '2025-05-20', 'head_coach', NULL),
(5, 5, '2026-01-01', 'head_coach', NULL),
(6, 6, '2026-01-01', 'head_coach', NULL),
(7, 7, '2026-01-01', 'head_coach', NULL),
(8, 8, '2021-01-01', 'head_coach', NULL),
(9, 9, '2017-01-01', 'head_coach', NULL),
(10, 10, '2023-01-01', 'head_coach', NULL),
(11, 11, '2017-01-01', 'head_coach', '2025-08-31'),
(12, 12, '2020-09-01', 'head_coach', NULL),
(13, 13, '2025-01-01', 'head_coach', NULL),
(14, 14, '2024-10-17', 'head_coach', '2026-03-23'),
(14, 22, '2024-10-17', 'psychologist', '2026-03-23'),
(14, 23, '2024-10-17', 'fitness_coach', '2026-03-23'),
(15, 15, '2019-03-01', 'head_coach', NULL),
(16, 16, '2024-02-01', 'head_coach', NULL),
(17, 17, '2023-07-01', 'head_coach', NULL),
(18, 18, '2025-12-09', 'head_coach', NULL),
(19, 19, '2026-01-01', 'head_coach', NULL),
(20, 20, '2026-01-01', 'head_coach', NULL),
(21, 21, '2024-04-01', 'head_coach', NULL),
(22, 24, '2020-08-01', 'head_coach', '2020-08-31'),
(23, 24, '2020-01-01', 'head_coach', '2020-12-31'),
(24, 1, '2017-08-01', 'head_coach', '2018-02-28');





