const express = require("express");
const apiController = require("../controllers/index");

const router = express.Router();

router.get("/version", apiController.version);

module.exports = router;
