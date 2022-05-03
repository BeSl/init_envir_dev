const express = require("express");
const router = express.Router();
// const { pingservice , parameter} = require("../controllers/pingserv");

router.get("/", (req, res) => (
    res.send('pong')
));

module.exports = router;