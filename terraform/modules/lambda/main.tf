data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


# resource "aws_api_gateway_rest_api" "api" {
#   name = "myapi"
# }

# resource "aws_api_gateway_resource" "resource" {
#   path_part   = "resource"
#   parent_id   = aws_api_gateway_rest_api.api.root_resource_id
#   rest_api_id = aws_api_gateway_rest_api.api.id
# }

# resource "aws_api_gateway_method" "method" {
#   rest_api_id   = aws_api_gateway_rest_api.api.id
#   resource_id   = aws_api_gateway_resource.resource.id
#   http_method   = "GET"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "integration" {
#   rest_api_id             = aws_api_gateway_rest_api.api.id
#   resource_id             = aws_api_gateway_resource.resource.id
#   http_method             = aws_api_gateway_method.method.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.node_lambda.invoke_arn
# }

# resource "aws_lambda_permission" "apigw_lambda" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.node_lambda.function_name
#   principal     = "apigateway.amazonaws.com"
  
#   source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
# }


data "archive_file" "zip" {
  type        = "zip"
  source_file = "modules/lambda/functions/${var.lambda_name}.js"
  output_path = "modules/lambda/functions/${var.lambda_name}.zip"
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = [
        "sts:AssumeRole"        
    ]
  }
}

resource "aws_iam_role" "nathan_iam_for_lambda" {
  name               = "nathan_iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}

data "aws_iam_policy_document" "lambda_invocation_policy" {

  statement {
    effect = "Allow"

    actions = ["lambda:InvokeFunction"]

    resources = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:*"]
  }
}

resource "aws_iam_role_policy" "lambda_invoke_role_policy" {
  name   = "lambda-invoke-role-policy"
  role   = "${aws_iam_role.nathan_iam_for_lambda.id}"
  policy = "${data.aws_iam_policy_document.lambda_invocation_policy.json}"
}

data "archive_file" "node_zip" {
  type        = "zip"
  source_file = "modules/lambda/functions/${var.lambda_name}.js"
  output_path = "modules/lambda/functions/${var.lambda_name}.zip"
}

resource "aws_lambda_function" "node_lambda" {
  function_name = "${var.lambda_name}"

  filename         = "${data.archive_file.node_zip.output_path}"
  source_code_hash = "${data.archive_file.node_zip.output_base64sha256}"

  role    = "${aws_iam_role.nathan_iam_for_lambda.arn}"
  handler = "${var.lambda_name}.lambda_Handler"
  runtime = "nodejs14.x"

  environment {
    variables = {
      greeting = "Hello"
    }
  }
}