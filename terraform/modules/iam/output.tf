output "iam_cloudwatch_role_arn" {
  description = "CloudWatch role required for apigateway"
  value = aws_iam_role.NathanCloudwatchRole.arn
}