let handler = require('./temp-queue-client');
var uuid = require('uuid');

handler.handler ( 
  {requestId:uuid.v1()}, // event
  {},
  (error, result) => { 
     if (error) console.error(JSON.stringify(error, null, 2));
     else console.log(JSON.stringify(result, null, 2));
  }
);