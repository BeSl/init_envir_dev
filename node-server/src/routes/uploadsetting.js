require("dotenv").config();
const express = require("express");
const router = express.Router();
const fs = require('fs'); 
const path = require('path');

router.post("/", (req, res) =>{
    try {
        dbName = req.headers.base;
        fileName = process.env.BASE_PATH_JSON + dbName + ".json";
        postBody = req.body;
        textForFile = JSON.stringify(postBody.config);
        
        createOrUpdateFile(path.join(__dirname, fileName), textForFile, res);
        return res.status(200).send('ok');          
    } catch (error) {
        console.log(error);
    }
    res.status(400).send('not ok');  
}
);

function createOrUpdateFile(fileName, textForFile, res){
       
     fs.writeFile(fileName, textForFile, (err) => {
         if(err) throw err;
         console.log('Data has been replaced!');
     });    

     res.status(200).send('ok');
}

module.exports = router;