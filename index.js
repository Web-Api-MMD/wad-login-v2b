const env = require('dotenv').config();
const config = require('config');

const express = require('express');
const app = express();

const cors = require('cors');

// previously loginRouter
const accounts = require('./routes/accounts');

app.use(express.json());
app.use(cors());
//previously /api/login
app.use('/api/accounts', accounts);

app.listen(config.get('port'), () => console.log(`Listening on port ${config.get('port')}...`));