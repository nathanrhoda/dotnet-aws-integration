package com.awssqs;

import java.util.concurrent.TimeUnit;
//import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeoutException;

import com.amazonaws.services.sqs.AmazonSQSRequester;
import com.amazonaws.services.sqs.AmazonSQSRequesterClientBuilder;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.SendMessageRequest;



public class SQSVirtualQueueWrapper 
{
    public String handler() {        
        AmazonSQSRequester sqsRequester = AmazonSQSRequesterClientBuilder.defaultClient();
        String requestQueueUrl = "";
        String body = "";
        SendMessageRequest request = new SendMessageRequest()
            .withQueueUrl(requestQueueUrl)
            .withMessageBody(body);
        
        // // If no response is received, in 20 seconds,
        // // trigger the TimeoutException.        
        try {
            Message reply = sqsRequester.sendMessageAndGetResponse(request, 20, TimeUnit.SECONDS);    
            return reply.getBody();
        } catch (Exception e) {
            return e.getMessage();            
        }       
    }
}
