const express = require("express");
const routes = require("./routes/index");

const server = express();

server.listen(3000, () => {
  console.log("Server is listening on port 3000.");
});

server.use("/api", routes);

server.use((req, res) => {
  res.status(404).send("Not found!");
});

server.get("/", (req, res) => {
  res.send("Connected from express");
});
