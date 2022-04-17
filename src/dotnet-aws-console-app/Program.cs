// See https://aka.ms/new-console-template for more information
using dotnet_aws_integration;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;

// Begin Startup Config
var serviceCollection = new ServiceCollection();
var configuration = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json")
                .Build();

var url = configuration["apigateway-url"];

serviceCollection.AddHttpClient("ApiGateway", client =>
{
    client.BaseAddress = new System.Uri(url);
});

// End Startup Config


// Api Gateway Integrations

var client = new ApiGatewayClient(serviceCollection.BuildServiceProvider().GetRequiredService<IHttpClientFactory>());
var response = await client.Post();
var resp = await response.Content.ReadAsStringAsync(); 
Console.WriteLine(JsonConvert.DeserializeObject(resp));

// End Api Gateway Integrations


// SQS Integrations
string queueName = configuration["queue-name"];

await SqsService.Listen(queueName);

// End SQS Integrations
