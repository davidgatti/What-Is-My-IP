'use strict';

const express = require('express');
const router = express.Router();

router.get('/', function(req, res, next) {

	//
	//	-> Render the page
	//
	res.render('welcome', {
			uuid: process.env.API_KEY,
			url: req.protocol + '://' + req.get('host'),
			visited: !!parseInt(process.env.VISITED)
	});

	process.env.VISITED = 1;

});

module.exports = router;
