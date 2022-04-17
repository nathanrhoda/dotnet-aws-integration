using System.Net.Http;
using System.Threading.Tasks;

namespace dotnet_aws_integration
{
    public class ApiGatewayClient
    {
        private readonly IHttpClientFactory _clientFactory;
        public ApiGatewayClient(IHttpClientFactory clientFactory)
        {
            _clientFactory = clientFactory;
        }

        public async Task<HttpResponseMessage> Post()
        {
            var client = _clientFactory.CreateClient("ApiGateway");
            return await client.SendAsync(new HttpRequestMessage(HttpMethod.Post, ""));                        
        }
    }
}
