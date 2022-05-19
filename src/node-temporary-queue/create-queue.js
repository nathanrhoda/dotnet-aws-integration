'use strict'
const AWS = require('aws-sdk');
AWS.config.update({region: 'af-south-1'})

exports.handler = function (event, context, callback) {
    return new Promise((resolve, reject) => {
        var reqId = event.requestId   
        var sqs = new AWS.SQS({ apiVersion: '2012-11-05'});

        var createParams = {
            QueueName: `temporaryQueue_${reqId}`,
            Attributes: {
                'VisibilityTimeout': '60',
                'MessageRetentionPeriod': '86400'
            }
        };

        // Create a queue for Responses and pass back queueurl
        // When response is retrieved delete the queue
        // Maybe incorporate jurisdiction into queue as well
        sqs.createQueue(createParams, async function (err, createQueueResponse) {
            if(err){
                reject("Create Queue Error", err);                
            } else {
                const sendParams = {
                    MessageBody: JSON.stringify({ "Boom":"Shaka" }),
                    QueueUrl: createQueueResponse.QueueUrl,
                    MessageAttributes: {
                    RequestId: {
                        DataType: 'String',
                        StringValue: reqId
                        }                  
                    }
                };         
                sqs.sendMessage(sendParams, async function (err, sendMessageResponse){
                    if(err) {
                        reject("Send Message Error", err);                
                    } else {
                        console.log('Message: ', sendMessageResponse);
                        console.log('Queue Url: ', createQueueResponse.QueueUrl);
                        resolve(createQueueResponse.QueueUrl);
                    }
                });                    
            }            
        });        
    });
}