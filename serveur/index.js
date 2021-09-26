const express = require('express')
const app = express()
const port = 5000
const mongoose = require('mongoose');


//connect to the mongodb data base
mongoose.connect('mongodb+srv://mounir:mongodbatlas123@cluster0.pbnov.mongodb.net/geotracker?retryWrites=true&w=majority',()=>{console.log('connected to db!!')})
//Routes
app.get('/', (req, res) => {
  res.send('Hello World!');
  console.log(req.body);
})

//how do we listen to the server

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})