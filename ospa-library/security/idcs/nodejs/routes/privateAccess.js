var express = require('express');
var router = express.Router();

// Get Homepage
router.get('/home', function(req, res){
	res.render('home');
});

// Get Homepage
router.get('/myProfile', function(req, res){
	res.render('myProfile');
});

// Get Homepage
router.get('/appDetails', function(req, res){
	res.render('appDetails');
});

module.exports = router;
