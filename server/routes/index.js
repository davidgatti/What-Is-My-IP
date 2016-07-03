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
    let ip = '';

    //
    //	2. Get the remote IP, and to make sure we get the actual user IP.
    //
    //	   We have to over all this hoops. Otherwise we are going to get
    //	   the load balancer IP and any other service that sits between
    //	   the user and our app.
    //
    if(req.headers['x-forwarded-for'])
    {
        var ipList = req.headers['x-forwarded-for'].split(",");
        ip = ipList[ipList.length - 1];
    }
    else if(req.connection && req.connection.remoteAddress)
    {
        ip = req.connection.remoteAddress;
    }
    else
    {
        ip = req.ip;
    }

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
