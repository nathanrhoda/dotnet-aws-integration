const queueClient = require('aws-temp-queue-client');

exports.handler = async (event) => {
    
    const result = await queueClient.sendAndReceiveMessage(event.requestId, event.country);
    const response = {
        statusCode: 200,
        body: JSON.stringify(result),
    };
    return response;
};
