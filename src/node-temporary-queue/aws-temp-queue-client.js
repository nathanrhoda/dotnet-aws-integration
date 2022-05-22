'use strict'

const AWS = require('aws-sdk');
AWS.config.update({region: 'af-south-1'})

exports.handler = async function (event, context, callback) {
    return new Promise(async (resolve, reject) => {
        var reqId = event.requestId;   
        
        console.log(event);
        var createParams = {
            QueueName: `temporaryQueue_${reqId}`,
            Attributes: {
                'VisibilityTimeout': '60',
                'MessageRetentionPeriod': '86400'
            }
        };
                
        var sqs = new AWS.SQS({ apiVersion: '2012-11-05'});
        sqs.createQueue(createParams, function (createErr, createQueueResponse) {
            if(createErr){
                console.log("Create Queue Error: ", createErr);                
                reject(createErr);
            } else {                
                console.log("Queue Created");                
                const sendParams = {
                    MessageBody: JSON.stringify(event),
                    QueueUrl: createQueueResponse.QueueUrl,
                    MessageAttributes: {
                    RequestId: {
                        DataType: 'String',
                        StringValue: reqId
                        }                  
                    }
                };                                        

                sqs.sendMessage(sendParams, async function (sendErr, sendMessageResponse){
                    if(sendErr) {
                        reject("Send Message Error", sendErr);                
                    } else {                        
                        if(event.action !== 'API') {
                            resolve(createQueueResponse.QueueUrl);
                        } else {
                            console.log("Message Sent");                
                            var receiveParams = {
                                AttributeNames: [
                                "SentTimestamp"
                                ],
                                MaxNumberOfMessages: 10,
                                MessageAttributeNames: [
                                "All"
                                ],
                                QueueUrl:  createQueueResponse.QueueUrl,
                                VisibilityTimeout: 20,
                                WaitTimeSeconds: 0
                            };

                            sqs.receiveMessage(receiveParams, function(receiveErr, data) {
                                if (receiveErr) {
                                    console.log("Receive Error", receiveErr);
                                    reject("Receive Error", receiveErr);   
                                } else if (data.Messages) {
                                    console.log("Messages Received");
                                    console.log(data.Messages);                                                                        

                                    var deleteParams = {
                                        QueueUrl: createQueueResponse.QueueUrl,
                                    };
                                    
                                    sqs.deleteQueue(deleteParams, function(deleteErr, deleteResponse) {
                                        if (deleteErr) {
                                            console.log("Delete Error", deleteErr);
                                            reject("Delete Error", deleteErr);   
                                        } else {
                                            console.log("Temp Queue Deleted");
                                            resolve(data.Messages);         
                                        }
                                    });                    
                                }
                            });  
                        }                      
                    }
                });                           
            }            
        });                               
     });
}


