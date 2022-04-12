// See https://aka.ms/new-console-template for more information
using Amazon.SQS;
using Amazon.SQS.Model;
using dotnet_aws_sqs;

string queueName = "https://sqs.af-south-1.amazonaws.com/479835631161/nathan-queue";

await SqsService.Listen(queueName);
