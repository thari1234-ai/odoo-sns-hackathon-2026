// ===============================
// GlobeTrotter Backend
// ===============================

const express = require("express");
const app = express();

app.use(express.json());

const PORT = 5000;

// Temporary data
let trips = [];
let activities = [];

// Home route
app.get("/", (req, res) => {
  res.send("GlobeTrotter Backend is running 🚀");
});

// Create trip
app.post("/api/trips", (req, res) => {
  const { name, start_date, end_date, description } = req.body;

  if (!name || !start_date || !end_date) {
    return res.status(400).json({ message: "Missing fields" });
  }

  const trip = {
    id: trips.length + 1,
    name,
    start_date,
    end_date,
    description
  };

  trips.push(trip);
  res.json({ success: true, trip });
});

// Get all trips
app.get("/api/trips", (req, res) => {
  res.json({ success: true, trips });
});

// Add city
app.post("/api/trips/:id/stops", (req, res) => {
  const { city, start_date, end_date } = req.body;

  if (!city || !start_date || !end_date) {
    return res.status(400).json({ message: "Missing city details" });
  }

  res.json({ success: true, stop: { city, start_date, end_date } });
});

// Add activity
app.post("/api/activities", (req, res) => {
  const { name, cost, category } = req.body;

  if (!name || !cost) {
    return res.status(400).json({ message: "Missing activity data" });
  }

  const activity = { name, cost, category };
  activities.push(activity);

  res.json({ success: true, activity });
});

// Budget API
app.get("/api/trips/:id/budget", (req, res) => {
  res.json({
    success: true,
    total_cost: 15000,
    per_day: 2500,
    breakdown: {
      stay: 7000,
      activities: 5000,
      food: 3000
    }
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
