const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let UsersSchema = new Schema({
  name: "String",
  password: "String"
});

module.exports = mongoose.model('User', UsersSchema);