module "sqs" {
  source = "./modules/sqs"
  queue_name = "${var.queue_name}"
}

module "lambda" {
  source = "./modules/lambda"
  lambda_name = "${var.lambda_name}"
}

module "api-gateway" {
  source = "./modules/apigateway"
  api_gateway_name = "${var.api_gateway_name}"
}

output api_gateway_id{
  value = module.api-gateway.api_gateway_api_id
}
