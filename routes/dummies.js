const express = require('express');
const router = express.Router();


router.get('/public', (req, res) => {
    res.send(JSON.stringify({message: 'This is a public endpoint.'}));

});

router.get('/private', (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({message: 'This is a private endpoint. Only members allowed yo.'}));
    
});

module.exports = router;