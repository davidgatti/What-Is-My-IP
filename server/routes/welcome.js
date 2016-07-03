'use strict';

const uuid = require('uuid');
const express = require('express');
const router = express.Router();

router.get('/', function(req, res, next) {

	//
	//	-> Render the page
	//
	res.render('welcome',
		{
			uuid: uuid.v4()
		}
	);

});

module.exports = router;
