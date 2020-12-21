var express = require('express');
var router = express.Router();

// Get Homepage
router.get('/', function(req, res){
	res.render('index');
});

router.get('/login', function(req, res){
	res.render('login');
});

// Get Homepage
router.get('/about', function(req, res){
	res.render('about');
});

router.post('/login', function(req, res){
	var email = req.body.email;
	var password = req.body.password;

	req.checkBody('email', 'You must type your email to log in.').notEmpty();
	req.checkBody('email', 'Invalid email format.').isEmail();
	req.checkBody('password', 'You must type your password to log in.').notEmpty();

	var errors = req.validationErrors();
	if(errors){
		res.render('login',{
      errors:errors
    });
	}else{
		console.log('No Errors');
	}

});

module.exports = router;
