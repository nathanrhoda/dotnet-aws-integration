output "sqs-arn" {
  value = aws_sqs_queue.nathan_queue.arn
}

# output "lambda_root_resource_id" {
#   value = aws_lambda_function.node_lambda.root_resource_id
# }