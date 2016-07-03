'use strict';

const express = require('express');
const router = express.Router();

//
//	RAM DB
//
let db = {
	ip: "",
	timeStamp: 0
}

//
//	Get
//
router.get('/', function(req, res, next) {

	//
	//	-> Respond with the data
	//
	return res.status(200).json(db);

});

//
//	Save
//
router.post('/', function(req, res, next) {

	//
	//	1. Save the remote IP
	//
	db.ip = req.connection.remoteAddress;

	//
	//	2. Save the time when the entry was created
	//
	db.timeStamp = Math.floor(Date.now() / 1000);

	//
	//	-> thank you for the ping :)
	//
	return res.status(200).send("OK");

});

module.exports = router;
