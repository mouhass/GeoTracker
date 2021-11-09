// routes/geo.route.js
const express = require('express');
const router = express.Router();
const geo_controller = require('../controllers/geo.controller');

// routes/geo.route.js...
router.post('/create', geo_controller.add);
router.get('/export',geo_controller.export_data) ;
router.get('/latest',geo_controller.export_latest) ;


module.exports = router;


