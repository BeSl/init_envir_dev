require("dotenv").config();
const express = require("express");
const router = express.Router();
const fs = require('fs'); 
const path = require('path');


router.get("/", (req, res) => (
    res.status(400).send('not router base')
));

router.post("/uploadsettings", (req, res) =>{
    
    dbName = "myFile";
    
    fileName = process.env.BASE_PATH_JSON + dbName + ".json";
    textForFile = "test";
    res.status(200).send('ok')  
  //  createOrUpdateFile(path.join(__dirname, fileName), textForFile, res);
}
);

router.get("/*", (req, res) => {
    try {
         readFile(req._parsedUrl._raw, res)
    } catch (error) {
        res.status(400).send('not fount setting this base')   
    }
});

//function createOrUpdateFile(fileName, textForFile, res){
    
    // fs.open(fileName, 'w', (err) => {
    //     if(err) throw err;
    //     console.log('File created');
    // });
    
    // fs.writeFile(fileName, textForFile, (err) => {
    //     if(err) throw err;
    //     console.log('Data has been replaced!');
    // });    

    // res.status(200).send('ok');
//}


async function  readFile(fileName, res)
{
    fullPath = process.env.BASE_PATH_JSON + fileName + '.json';
    var usersFilePath = path.join(__dirname, fullPath);
    await fs.access(usersFilePath, fs.F_OK, (err) => {
        if (err) {
            console.error(err)
            res.status(400).send('File not found');
        }

        try {
            var readable = fs.createReadStream(usersFilePath);
            readable.pipe(res);              
        } catch(err) {
            console.error(err)
          }    
    })
}

module.exports = router;