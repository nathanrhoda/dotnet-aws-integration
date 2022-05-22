let handler = require('./aws-temp-queue-client.js');
var uuid = require('uuid');

handler.handler ( 
  {requestId:uuid.v1(), country: 'ZIM', action: 'API'}, // event
  {},
  (error, result) => { 
     if (error) console.error(JSON.stringify(error, null, 2));
     else console.log(JSON.stringify(result, null, 2));
  }
);