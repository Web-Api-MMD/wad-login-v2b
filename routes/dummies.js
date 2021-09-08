const express = require('express');
const router = express.Router();
const auth = require('../middleware/authenticate');
const admin = require('../middleware/admin');


router.get('/public', (req, res) => {
    res.send(JSON.stringify({message: 'This is a public endpoint.'}));

});

router.get('/private', [auth], (req, res) => { // [auth, ...] middleware is set her. just use an array with one item if only one piece of middleware
    res.send(JSON.stringify({message: 'This is a private endpoint. Only members allowed yo.', account: req.account})); // req.account exists becuase it "went through" the auth
});
 
router.get('/adminonly', [auth, admin], (req, res) => {
    res.send(JSON.stringify({message: 'This is for admins only yo.', account: req.body}));
});

module.exports = router;