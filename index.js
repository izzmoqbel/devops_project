const express = require("express");
const axios = require("axios");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello, World!");
});

app.get("/health", (req, res) => {
  res.sendStatus(200);
});

app.get("/bye", (req, res) => {
  res.send("Bye, World!");
});

app.get("/weather", async (req, res) => {
  try {
    const response = await axios.get("https://wttr.in");
    res.set("Content-Type", "text/html");
    res.send(response.data);
  } catch (err) {
    res.status(500).send(err.message);
  }
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
