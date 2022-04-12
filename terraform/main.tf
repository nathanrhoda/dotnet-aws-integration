provider "aws" {
  region = "${var.aws_region}"
}


module "sqs" {
  source = "./modules/sqs"
  queue_name = "${var.queue_name}"
}