// ===============================
// GlobeTrotter Backend (Supabase)
// ===============================

const express = require("express");
require("dotenv").config();
const supabase = require("./supabase");
console.log("🔥🔥 THIS INDEX.JS FILE IS RUNNING 🔥🔥");

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 5000;

// -------------------------------
// HOME
// -------------------------------
app.get("/", (req, res) => {
  res.send("GlobeTrotter Backend with Supabase 🚀");
});

// -------------------------------
// DB TEST (IMPORTANT)
// -------------------------------
app.get("/api/db-test", async (req, res) => {
  const { data, error } = await supabase
    .from("trips")
    .select("*")
    .limit(1);

  if (error) {
    return res.status(500).json({
      success: false,
      error: error.message
    });
  }

  res.json({
    success: true,
    message: "Supabase connected successfully 🎉",
    data
  });
});

// -------------------------------
// CREATE TRIP
// -------------------------------
app.post("/api/trips", async (req, res) => {
  const { name, start_date, end_date, description, user_id } = req.body;

  if (!name || !start_date || !end_date || !user_id) {
    return res.status(400).json({ message: "Missing fields" });
  }

  const { data, error } = await supabase
    .from("trips")
    .insert([
      { name, start_date, end_date, description, user_id }
    ])
    .select();

  if (error) {
    return res.status(500).json({ error: error.message });
  }

  res.json({ success: true, trip: data[0] });
});

// -------------------------------
// GET ALL TRIPS
// -------------------------------
app.get("/api/trips", async (req, res) => {
  const { data, error } = await supabase
    .from("trips")
    .select("*");

  if (error) {
    return res.status(500).json({ error: error.message });
  }

  res.json({ success: true, trips: data });
});
// -------------------------------
// ADD STOP (CITY) TO A TRIP
// -------------------------------
app.post("/api/trips/:tripId/stops", async (req, res) => {
  const { tripId } = req.params;
  const { city_name, country, start_date, end_date, order_index } = req.body;

  if (!city_name || !country || !start_date || !end_date || order_index === undefined) {
    return res.status(400).json({ message: "Missing stop fields" });
  }

  const { data, error } = await supabase
    .from("stops")
    .insert([
      {
        trip_id: tripId,
        city_name,
        country,
        start_date,
        end_date,
        order_index
      }
    ])
    .select();

  if (error) {
    return res.status(500).json({ error: error.message });
  }

  res.json({
    success: true,
    stop: data[0]
  });
});
// -------------------------------
// ADD ACTIVITY
// -------------------------------
app.post("/api/stops/:stopId/activities", async (req, res) => {
  const { stopId } = req.params;
  const { name, category, cost, duration, description } = req.body;

  if (!name || !stopId) {
    return res.status(400).json({
      message: "Missing activity name or stopId"
    });
  }

  const { data, error } = await supabase
    .from("activities")
    .insert([
      {
        stop_id: stopId,
        name,
        category,
        cost,
        duration,
        description
      }
    ])
    .select();

  if (error) {
    return res.status(500).json({
      success: false,
      error: error.message
    });
  }

  res.json({
    success: true,
    activity: data[0]
  });
});

// -------------------------------
// START SERVER (MUST BE LAST)
// -------------------------------
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
