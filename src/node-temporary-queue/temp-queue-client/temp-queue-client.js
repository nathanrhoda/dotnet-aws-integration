let createQ = require('./create-queue');
let readQ = require('./read-queue');

'use strict'
const AWS = require('aws-sdk');

exports.handler = function (event, context, callback) {
    return new Promise((resolve, reject) => {        
        
        createQ.handler(event)
            .then((queueUrl)=>{
                console.log(queueUrl);
                readQ.handler(event)
                    .then((msg)=>{
                        console.log(msg);
                        resolve(msg);
                    })                
                    .catch((err)=>{
                        reject(err);
                    });
            })
            .catch((err)=>{
                reject(err);
            });                
    });    
}