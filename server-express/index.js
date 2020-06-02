const express = require ('express');
const morgan = require('morgan');
const ejs = require('ejs')
const app = express();
//Require for routes
const routes = require('./routes');
const routesApi = require('./routes-api');

//Settings
app.set('appName', 'First Server');
app.set('views', __dirname + '/views')
app.set('view engine', 'ejs');

// middlewares
//app.use(morgan('dev'));
/*app.use(function(req, res, next){
    console.log('request url:' + req.url);
    next();
});*/
app.use((req, res, next) =>{
    console.log('pass here');
    next();
});
//Routes
app.use(routes);
app.use('/api', routesApi);

app.get('*', (req, res)=>{
    res.end('Archivo no encontrado');
})

app.listen(3000, ()=>{
    console.log('server up!');
    console.log('Nombre de la app:', app.get('appName'));
})