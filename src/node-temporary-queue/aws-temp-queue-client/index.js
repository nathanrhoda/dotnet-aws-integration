const Client = require('./aws-temp-queue-client.js')

module.exports.sendMessage = async function(reqId, country){
    var event = {requestId:reqId, country:country};
    return Client.handler(event);
};

module.exports.sendAndReceiveMessage = async function(reqId, country){
    var event = {requestId:reqId, country:country, action:'API'};
    return Client.handler(event);
};