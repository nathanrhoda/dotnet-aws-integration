data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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

resource "aws_api_gateway_deployment" "NathanDeployment" {
  rest_api_id = aws_api_gateway_rest_api.NathanAPI.id
  depends_on = [aws_api_gateway_method.NathanMethod]

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.NathanAPI))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "NathanStage" {
  deployment_id = aws_api_gateway_deployment.NathanDeployment.id
  rest_api_id   = aws_api_gateway_rest_api.NathanAPI.id
  stage_name    = "dev"
}

resource "aws_api_gateway_method_settings" "NathanMethodSettings" {
  rest_api_id = aws_api_gateway_rest_api.NathanAPI.id
  stage_name  = aws_api_gateway_stage.NathanStage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_account" "NathanGatewayAccount" {
  cloudwatch_role_arn = "${var.cloudwatch_role_arn}"
}
