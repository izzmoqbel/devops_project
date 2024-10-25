// server.js
const express = require("express");
const axios = require("axios");

const app = express();

// Root endpoint
app.get("/", (req, res) => {
  res.send("Hello, World!");
});

// Health check endpoint
app.get("/health", (req, res) => {
  res.sendStatus(200);
});

// Goodbye endpoint
app.get("/bye", (req, res) => {
  res.send("Bye, World!");
});

// Weather endpoint
app.get("/weather", async (req, res) => {
  try {
    const response = await axios.get("https://wttr.in");
    res.set("Content-Type", "text/html");
    res.send(response.data);
  } catch (err) {
    res.status(500).send(err.message);
  }
});

// Start server
const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
