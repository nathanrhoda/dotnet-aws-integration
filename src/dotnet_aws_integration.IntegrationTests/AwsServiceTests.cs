using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Threading.Tasks;

namespace dotnet_aws_integration.IntegrationTests
{
    [TestClass]
    public class AwsServiceTests
    {
        [TestMethod]
        public async Task CreateVirtualQueue_SupplyingValidInput_ReturnsQueueName()
        {
            //var queueurl = "https://sqs.af-south-1.amazonaws.com/479835631161/nathan-q";            
            var queueurl = "nathan-q_" + Guid.NewGuid().ToString();
            var queuename = await SqsService.CreateQueueAsync(queueurl);
            Assert.IsNotNull(queuename);
        }
    }
}
