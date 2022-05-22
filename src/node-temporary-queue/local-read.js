let handler = require('./read-queue');
var uuid = require('uuid');

handler.handler (   
  {requestId: "0be38db0-d848-11ec-b68b-e7bfffde54dc"},
  {},
  (error, result) => { 
     if (error) console.error(JSON.stringify(error, null, 2));
     else console.log(JSON.stringify(result, null, 2));
  }
);