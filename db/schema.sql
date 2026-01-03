CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE
);

CREATE TABLE trips (
  trip_id SERIAL PRIMARY KEY,
  user_id INT,
  trip_name VARCHAR(100),
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE trip_stops (
  stop_id SERIAL PRIMARY KEY,
  trip_id INT,
  city VARCHAR(100),
  country VARCHAR(100),
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);

CREATE TABLE budgets (
  budget_id SERIAL PRIMARY KEY,
  trip_id INT,
  transport_cost DECIMAL(10,2),
  stay_cost DECIMAL(10,2),
  food_cost DECIMAL(10,2),
  activity_cost DECIMAL(10,2),
  FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);
