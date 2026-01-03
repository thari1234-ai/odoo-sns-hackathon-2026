INSERT INTO users VALUES (1, 'Demo User', 'demo@mail.com');

INSERT INTO trips VALUES
(1, 1, 'Europe Trip', '2026-01-10', '2026-01-20');

INSERT INTO trip_stops VALUES
(1, 1, 'Paris', 'France', '2026-01-10', '2026-01-13'),
(2, 1, 'Rome', 'Italy', '2026-01-14', '2026-01-17');

INSERT INTO budgets VALUES
(1, 1, 500, 800, 300, 200);

SELECT city, country FROM trip_stops WHERE trip_id = 1;
