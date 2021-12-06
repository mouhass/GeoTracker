const User = require('../models/users.model');
exports.add = function (req, res, next) {
    var user = new User(
        req.body
    );
        console.log(req.body);
        user.save(function (err) {
        if (err) {
            return next(err);
        }

        res.send('Feature created successfully')
    })
};

//return geometry only
exports.export_data = function(req,res) {
    User.find({},{}, function(err, users){
        if (err) return next(err);
        res.send(users)
    });
};