using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace dotnet_aws_integration
{
    public class ApiGatewayClient
    {
        private readonly HttpClient _htppClient;
        public ApiGatewayClient(HttpClient _htppClient)
        {
            this._htppClient = _htppClient;
        }

        public async Task<HttpResponseMessage> Post()
        { 
            var url = "https://0z89x3ti55.execute-api.af-south-1.amazonaws.com/dev/nathanresource";
            return await _htppClient.SendAsync(new HttpRequestMessage(HttpMethod.Post, url));            
        }
    }
}
