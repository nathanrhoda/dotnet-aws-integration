const Client = require('./temp-queue-client.js')

module.exports.sendMessage = async function(reqId, queueName, body){
    var event = {requestId:reqId};
    return Client.handler(event);
};