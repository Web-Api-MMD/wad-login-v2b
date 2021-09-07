module.exports = (req, res, next) => {
    const token = req.header('x-authenticate-token');
    if(!token) return res.status(401).send(JSON.stringify({errorMessage: 'YOU SHALL NOT PASS!! Or just no token provided..'}));

    if(token == 'OK') next();
    return res.status(400).send(JSON.stringify({errorMessage: 'Invalid token.'}));
}

