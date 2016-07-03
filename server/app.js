'use strict';

var express = require('express');
var path = require('path');
var logger = require('morgan');
var bodyParser = require('body-parser');

var app = express();

// view engine setup
app.set('view engine', 'hjs');

//
//	Settings - Development
//
if (app.get('env') != 'master')
{
	app.use(logger('dev'));
}

//
//	Settings
//
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//
//	Public Route
//
app.use('/welcome', require('./routes/welcome'));

//
//	Security check
//
app.use(function(req, res, next) {

	//
	//	1. Check if the APIKey is present
	//
    if(!req.headers.authorization)
    {
        return res.status(400).json(
            {
                message: "Missing APIKey.",
                description: "Unable to find the APIKey"
            }
        );
    }

    //
    // 	2. Remove Basic from the beginning of the string
    //
    let noBasic = req.headers.authorization.replace('Basic ', '');

    //
    //	3. Convert from base64 to string
    //
    let b64toString = new Buffer(noBasic, 'base64').toString("utf8");

    //
    // 	4. Remove the colon from the end of the string
    //
    let userAPIKey = b64toString.replace(':', '');

    //
    //	5. Check if the APIKey matches the one on the server side.
    //
    if(userAPIKey != process.env.API_KEY)
    {
		return res.status(400).json(
            {
                message: "APIKey don't match",
                description: "Make sure what you are sending is what is in your server."
            }
        );
    }

    //
    //	-> Go to the next stage
    //
	next()

});

//
//	Private Route
//
app.use('/', require('./routes/index'));

//
//  If no route matched, then: catch 404,
//  and forward to error handler
//
app.use(function(req, res, next)
	{
		var err = new Error('Not Found');
		err.status = 404;
		next(err);
	}
);

//
//  error handler
//
app.use(function(err, req, res, next)
{
	console.log(err);
	let errDescription = {};
	res.status(err.status || 500);

	//
	//  If development show the stack trace
	//
	if (app.get('env') === 'development')
	{
		errDescription = err
	}

	return res.json(
		{
			message: err.message,
			description: errDescription
		}
	);

});

module.exports = app;
