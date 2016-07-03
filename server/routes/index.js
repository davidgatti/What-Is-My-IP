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

    var ip = '';

    if (req.headers['x-forwarded-for'])
    {
        var ipList = req.headers['x-forwarded-for'].split(",");
        ip = ipList[ipList.length - 1];
    }
    else if (req.connection && req.connection.remoteAddress)
    {
        ip = req.connection.remoteAddress;
    }
    else
    {
        ip = req.ip;
    }

	//
	//	1. Save the remote IP
	//
	db = ip + "\n" + Math.floor(Date.now() / 1000)

	//
	//	-> thank you for the ping :)
	//
	return res.status(200).send("OK");

});

module.exports = router;
