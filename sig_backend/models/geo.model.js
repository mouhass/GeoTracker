// models/geo.model.js
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let GeoSchema = new Schema({
  date: "String",
  coordinates: [],
});

module.exports = mongoose.model('Geo', GeoSchema);