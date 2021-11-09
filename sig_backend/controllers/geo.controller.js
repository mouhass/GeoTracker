const Geo = require('../models/geo.model');


// controllers/geo.controller.js

/* ADD */
exports.add = function (req, res, next) {
    var geo = new Geo(
        req.body
    );
        console.log(req.body);
    geo.save(function (err) {
        if (err) {
            return next(err);
        }

        res.send('Feature created successfully')
    })
};

//return geometry only
exports.export_data = function(req,res) {
    Geo.find({},{}, function(err, geo){
        if (err) return next(err);
        res.send(geo)
    });
};

exports.export_latest = function(req,res) {
    Geo.findOne({},{}, function(err, geo){
        if (err) return next(err);
        res.send(geo.coordinates[0]);
    });
};

