// server.js
const express = require('express');
const bodyParser = require('body-parser');
const config = require('config');
const mongoose = require('mongoose');
const geo = require('./routes/geo.route'); // Imports routes for the features



// initialize the express app
const app = express();



// Set up mongoose connection

//importing the database
const db = config.get('mongoURI');

//connect to the database 
mongoose
  .connect(db, { useNewUrlParser: true})
  .then(() => console.log('MongoDB Connected...'))
  .catch(err => console.log(err));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use('/geo', geo);



let port = 1234;

app.listen(port, () => {
    console.log('The server is running on port number ' + port);
});