data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# data "terraform_remote_state" "lambda" {
#   backend = "local"

#   config = {
#     path = "${path.module}/../../terraform.tfstate"
#   }
# }
resource "aws_api_gateway_rest_api" "NathanAPI" {
  name        = "${var.api_gateway_name}"
  description = "This is my API "
}

resource "aws_api_gateway_resource" "NathanResource" {
  rest_api_id = aws_api_gateway_rest_api.NathanAPI.id
  parent_id   = aws_api_gateway_rest_api.NathanAPI.root_resource_id
  path_part   = "nathanresource"
}

resource "aws_api_gateway_method" "NathanMethod" {
  rest_api_id   = aws_api_gateway_rest_api.NathanAPI.id
  resource_id   = aws_api_gateway_resource.NathanResource.id
  http_method   = "POST"
  authorization = "NONE"
}