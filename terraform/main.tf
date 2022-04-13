module "sqs" {
  source = "./modules/sqs"
  queue_name = "${var.queue_name}"
}

module "lambda" {
  source = "./modules/lambda"
  lambda_name = "${var.lambda_name}"
}