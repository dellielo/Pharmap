var express = require('express');
var cookieParser = require('cookie-parser');
var morgan = require('morgan');
var bodyparser = require('body-parser');
var app = express();
const neo4j = require('./neo4j')
const Joi = require('joi')

app.use((req, res, next) => {
    console.log('Entering on', req.originalUrl);
    return next();
})

app.use(function (req, res, next) {
    var allowedOrigins = ['http://localhost:3000', 'https://projet-hackathon-03.appspot.com'];
    var origin = req.headers.origin;
    if (allowedOrigins.indexOf(origin) > -1) {
        res.setHeader('Access-Control-Allow-Origin', origin);
    }
    res.header("Access-Control-Allow-Credentials", "true");
    res.header("Access-Control-Allow-Headers", "Origin, Content-Type, Authorization, x-id, Content-Length, X-Requested-With");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    next();
});


app.use(cookieParser());
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));
app.use(morgan('dev'));

app.get('/helloworld', (req, res) => {
    res.status(200).send("Hello world");
});

app.post('/query', async (req, res) => {
    const shema = Joi.object().keys({
        endpoint: Joi.string().min(1).required(),
        username: Joi.string().min(1).required(),
        password: Joi.string().min(1).required(),
        query: Joi.string().min(1).required()
    }).options({ stripUnknown: true })

    const {value, error} = Joi.validate(req.body, shema)
    if (error) return res.status(400).end()

    try {
        const neo = neo4j(value.endpoint, value.username, value.password)
        console.log('query: ', value.query)
        const r = await neo.session.run(value.query)
        res.status(200).send(r.records)
        neo.driver.close()
    } catch(e) {
        console.log(e)
        return res.status(e.status || 500).send({error: e})
    }
})

app.listen(8081, () => console.log('Listening on 8081'));

module.exports = app