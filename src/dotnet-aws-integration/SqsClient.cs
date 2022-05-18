using Amazon.SQS;
using Amazon.SQS.Model;
using System;
using System.Threading.Tasks;

namespace dotnet_aws_integration
{
    public static class SqsService
    {
        private const int MaxMessages = 1;
        private const int WaitTime = 2;
        public static async Task Listen(string queueName)
        {
            var sqsClient = new AmazonSQSClient();
            Console.WriteLine($"Reading messages from queue\n  {queueName}");
            Console.WriteLine("Press any key to stop. (Response might be slightly delayed.)");
            do
            {
                var msg = await SqsService.GetMessage(sqsClient, queueName, WaitTime);
                if (msg.Messages.Count != 0)
                {
                    if (SqsService.ProcessMessage(msg.Messages[0]))
                        await SqsService.DeleteMessage(sqsClient, msg.Messages[0], queueName);
                }
            } while (!Console.KeyAvailable);
        }
        //
        // Method to read a message from the given queue
        // In this example, it gets one message at a time
        private static async Task<ReceiveMessageResponse> GetMessage(
          IAmazonSQS sqsClient, string qUrl, int waitTime = 0)
        {
            return await sqsClient.ReceiveMessageAsync(new ReceiveMessageRequest
            {
                QueueUrl = qUrl,
                MaxNumberOfMessages = MaxMessages,
                WaitTimeSeconds = waitTime
                // (Could also request attributes, set visibility timeout, etc.)
            });
        }


        //
        // Method to process a message
        // In this example, it simply prints the message
        private static bool ProcessMessage(Message message)
        {
            Console.WriteLine($"\nMessage body of {message.MessageId}:");
            Console.WriteLine($"{message.Body}");
            return true;
        }


        //
        // Method to delete a message from a queue
        private static async Task DeleteMessage(
          IAmazonSQS sqsClient, Message message, string qUrl)
        {
            Console.WriteLine($"\nDeleting message {message.MessageId} from queue...");
            await sqsClient.DeleteMessageAsync(qUrl, message.ReceiptHandle);
        }
    }
}
