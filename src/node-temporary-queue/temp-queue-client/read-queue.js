'use strict'
const AWS = require('aws-sdk');
AWS.config.update({region: 'af-south-1'})

exports.handler = function (event, context, callback) {
    return new Promise((resolve, reject) => {

console.log(process.env.AWS_REGION);
        var reqId = event.requestId;
        var baseUrl = `https://sqs.${process.env.AWS_REGION}.amazonaws.com/479835631161/`;
        var queueName = `temporaryQueue`;
        var queueUrl = `${baseUrl}${queueName}_${reqId}`;
        var sqs = new AWS.SQS({ apiVersion: '2012-11-05'});

        var params = {
            AttributeNames: [
               "SentTimestamp"
            ],
            MaxNumberOfMessages: 10,
            MessageAttributeNames: [
               "All"
            ],
            QueueUrl: queueUrl,
            VisibilityTimeout: 20,
            WaitTimeSeconds: 0
           };
           
      
           sqs.receiveMessage(params, function(err, data) {
            if (err) {
                console.log("Receive Error", err);
                reject("Receive Error", err);   
            } else if (data.Messages) {
                console.log("Message Received");
                var deleteParams = {
                    QueueUrl: queueUrl,
                    ReceiptHandle: data.Messages[0].ReceiptHandle
                };
                sqs.deleteMessage(deleteParams, function(err, deleteResponse) {
                    if (err) {
                        console.log("Delete Error", err);
                        reject("Delete Error", err);   
                    } else {
                        console.log("Temp Queue Deleted");
                        return resolve(data);           
                    }
                });                    
            }
          });   
    });
}