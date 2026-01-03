-- ================================
-- GlobeTrotter Database Schema
-- ================================

-- 1️⃣ User Profiles
CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    name VARCHAR(100),
    profile_pic VARCHAR(255),
    language_pref VARCHAR(20)
);

-- 2️⃣ Trips
CREATE TABLE IF NOT EXISTS trips (
    trip_id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    description TEXT,
    cover_photo VARCHAR(255)
);

-- 3️⃣ Stops (Cities in a Trip)
CREATE TABLE IF NOT EXISTS stops (
    stop_id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES trips(trip_id) ON DELETE CASCADE,
    city_name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    order_index INT NOT NULL
);

-- 4️⃣ Activities
CREATE TABLE IF NOT EXISTS activities (
    activity_id SERIAL PRIMARY KEY,
    stop_id INT REFERENCES stops(stop_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    cost NUMERIC,
    duration INTERVAL,
    description TEXT
);

-- 5️⃣ Trip Budget
CREATE TABLE IF NOT EXISTS trip_budget (
    budget_id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES trips(trip_id) ON DELETE CASCADE,
    transport_cost NUMERIC DEFAULT 0,
    stay_cost NUMERIC DEFAULT 0,
    activity_cost NUMERIC DEFAULT 0,
    meals_cost NUMERIC DEFAULT 0
);

-- 6️⃣ Shared Trips
CREATE TABLE IF NOT EXISTS shared_trips (
    shared_id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES trips(trip_id) ON DELETE CASCADE,
    public_url VARCHAR(255),
    is_public BOOLEAN DEFAULT FALSE
);
