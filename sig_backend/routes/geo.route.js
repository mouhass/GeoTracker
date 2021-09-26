// routes/geo.route.js
const express = require('express');
const router = express.Router();

// Require the controllers
const geo_controller = require('../controllers/geo.controller');

// test url.
router.get('/test', geo_controller.test);


// routes/geo.route.js...
router.get('/read_allgeo', geo_controller.geo_list);
// localhost:1234/geo/read_allgeo

router.get('/read_name/:name', geo_controller.geo_name);
// localhost:1234/geo/read_name/CREATETEST

router.get('/read_id/:id', geo_controller.geo_id);
// localhost:1234/geo/read_id/<id>

router.get('/read_allnames', geo_controller.geo_allnames);
// localhost:1234/geo/read_allnames

router.get('/read_all', geo_controller.geo_all);
// localhost:1234/geo/read_all

/* UPDATE */
router.put('/update/:id', geo_controller.feature_update);
//localhost:1234/features/update/<featureid>
//BODY {"geometry":{"coordinates":[[-34.44379,-70.65775],[-34.199626,-71.106262],[-34.04576,-71.61748]]}}


/* DELETE */
router.delete('/delete/:id', geo_controller.geo_delete);
//localhost:1234/geo/delete/<featureid>


module.exports = router;


