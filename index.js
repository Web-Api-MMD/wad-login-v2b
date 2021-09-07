const env = require('dotenv').config();
const config = require('config');

const express = require('express');
const app = express();

const cors = require('cors');

// Custom Middleware
const setContentTypeJSON = require('./middleware/setResponseHeader');

// previously loginRouter
const accounts = require('./routes/accounts');
const dummies = require('./routes/dummies');

app.use(express.json());
app.use(cors());
app.use(setContentTypeJSON);

//previously /api/login
app.use('/api/accounts', accounts);
app.use('/api/dummies', dummies);

app.listen(config.get('port'), () => console.log(`Listening on port ${config.get('port')}...`));