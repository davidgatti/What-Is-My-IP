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
	//	1. Create an empty variable where we are going to store
	//	   the remote IP.
	//
    let ip = req.headers['x-forwarded-for'];

    //
    //	3. Save the time stamp so we can tell how fresh is the IP
    //
    let timeStamp = Math.floor(Date.now() / 1000);

	//
	//	4. Combine everything in to a string.
	//
	db = ip + "\n" + timeStamp

	//
	//	-> thank you for the ping :)
	//
	return res.status(200).send("OK");

});

module.exports = router;
