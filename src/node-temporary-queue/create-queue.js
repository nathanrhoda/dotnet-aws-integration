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
                'VisibilityTimeout': '5',
                'MessageRetentionPeriod': '86400'
            }
        };

        console.log(event);
        sqs.createQueue(createParams, async function (err, createQueueResponse) {
            console.log(createQueueResponse);
            if(err){
                reject("Create Queue Error", err);                
            } else {
                const sendParams = {
                    MessageBody: JSON.stringify({ "James":"Bond" }),
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
                        resolve(createQueueResponse.QueueUrl);
                    }
                });                    
            }            
        });        
    });
}