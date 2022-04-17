variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type     = string
}

variable "cloudwatch_role_arn" {
  description = "CloudWatch role required for apigateway"
  type        = string
}