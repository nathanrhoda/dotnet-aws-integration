variable "lambda_name" {
  description = "The name of the lambda to create"
  type     = string
}

variable "apigw_api_id" {
  //${aws_api_gateway_rest_api.api.id}
  description = "ID for Api Gateway"
  type = string
}

variable apigw_http_method {
  //${aws_api_gateway_method.method.http_method}
  description = "Http Method for Api Gateway"
  type = string
}

variable apigw_resource_path {
  //${aws_api_gateway_resource.resource.path}
  description = "Api Gateway Resource Path"
  type = string
}
