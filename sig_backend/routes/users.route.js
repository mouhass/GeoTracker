const express = require('express');
const router = express.Router();
const user_controller = require('../controllers/users.controller');

// routes/geo.route.js...
router.post('/create', user_controller.add);
router.get('/export',user_controller.export_data) ;


module.exports = router;


