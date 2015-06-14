require('coffee-script/register');
server = require('./server');
server({ port : process.env.PORT || 3000 });