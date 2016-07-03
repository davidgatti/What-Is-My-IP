'use strict';

const express = require('express');
const router = express.Router();

//
//	RAM DB
//
let db = "";

//
//	Get
//
router.get('/', function(req, res, next) {

	//
	//	-> Respond with the data
	//
	return res.status(200).send(db);

});

//
//	Save
//
router.post('/', function(req, res, next) {

	//
	//	1. Save the remote IP
	//
	db = req.ip + "\n" + Math.floor(Date.now() / 1000)

	//
	//	-> thank you for the ping :)
	//
	return res.status(200).send("OK");

});

module.exports = router;
