module "sqs" {
  source = "./modules/sqs"
  queue_name = "${var.queue_name}"
}

module "api-gateway" {
  source = "./modules/apigateway"
  api_gateway_name = "${var.api_gateway_name}"  
}

module "lambda" {
  source = "./modules/lambda"
  lambda_name = "${var.lambda_name}"
  apigw_api_id = module.api-gateway.api_gateway_api_id
  apigw_http_method = module.api-gateway.api_gateway_method
  apigw_resource_path = module.api-gateway.api_gateway_resource_path
  apigw_resource_id = module.api-gateway.api_gateway_resource_id
}