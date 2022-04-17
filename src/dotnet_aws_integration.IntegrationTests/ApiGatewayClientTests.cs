using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace dotnet_aws_integration.IntegrationTests
{
    [TestClass]
    public class ApiGatewayClientTests
    {
        protected static IHttpClientFactory _clientFactory;
        protected IConfiguration _configuration;
        protected IServiceCollection _serviceCollection;

        public ApiGatewayClientTests()
        {
            _serviceCollection = new ServiceCollection();

            _configuration = new ConfigurationBuilder()
                            .AddJsonFile("appsettings.json")
                            .Build();

            var url = _configuration["apigateway-url"];

            _serviceCollection.AddHttpClient("ApiGateway", client =>
            {
                client.BaseAddress = new System.Uri(url);
            });
            _clientFactory = _serviceCollection.BuildServiceProvider().GetRequiredService<IHttpClientFactory>();
        }

        [TestMethod]
        public async Task ApiGatewayClient_Post_Returns200()
        {
            var client = _clientFactory.CreateClient("ApiGateway");
            var response = await client.SendAsync(new HttpRequestMessage(HttpMethod.Post, ""));
            var jsonResult = await response.Content.ReadAsStringAsync();
            var result = JsonConvert.DeserializeObject(jsonResult).ToString();

            Assert.AreEqual(HttpStatusCode.OK, response.StatusCode);
            Assert.IsNotNull("Hello Nathan", result);
        }
    }
}