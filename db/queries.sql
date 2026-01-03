-- ================================
-- GlobeTrotter Sample Queries
-- ================================

-- 1️⃣ Get all trips for a user
SELECT t.trip_id, t.name, t.start_date, t.end_date
FROM trips t
WHERE t.user_id = 'a352054d-1f66-4516-a6cb-d15d466ea996';

-- 2️⃣ Get stops (cities) for a trip
SELECT city_name, country, start_date, end_date
FROM stops
WHERE trip_id = 11
ORDER BY order_index;

-- 3️⃣ Get activities for a stop
SELECT name, category, cost, duration
FROM activities
WHERE stop_id = 27;

-- 4️⃣ Full itinerary for a trip
SELECT 
    t.name AS trip_name,
    s.city_name,
    a.name AS activity_name,
    a.category,
    a.cost
FROM trips t
JOIN stops s ON t.trip_id = s.trip_id
LEFT JOIN activities a ON s.stop_id = a.stop_id
WHERE t.trip_id = 11
ORDER BY s.order_index;

-- 5️⃣ Trip budget breakdown
SELECT 
    transport_cost,
    stay_cost,
    activity_cost,
    meals_cost,
    (transport_cost + stay_cost + activity_cost + meals_cost) AS total_cost
FROM trip_budget
WHERE trip_id = 11;

-- 6️⃣ Public trips
SELECT 
    t.name,
    s.public_url
FROM shared_trips s
JOIN trips t ON s.trip_id = t.trip_id
WHERE s.is_public = TRUE;
