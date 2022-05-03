require("dotenv").config();
const express = require("express");
const cors = require('cors');

const devset = require("./routes/devsettings");
const pingservice = require("./routes/pingserv");
const uploadsetting = require("./routes/uploadsetting");

const PORT_DEFAULT = 8000;
const app = express();
app.use(express.json());
app.use(cors());
//app.use(bodyParser.json({ type: 'application/*+json' }));

//v1

app.use("/api/v1/devset", devset);
app.use("/api/v1/ping", pingservice);
app.use("/api/v1/upld", uploadsetting);

const PORT = process.env.DEFAULT_PORT || 4001;
app.listen(PORT, console.log(`Server started at http://localhost:${PORT}`));

