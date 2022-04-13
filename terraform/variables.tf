variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "af-south-1"
}

variable "queue_name" {
  description = "The queue name"
  default     = "nathan-queue"
}

variable "lambda_name" {
  description = "The name of the lambda to create"
  default     = "nathan-lambda"
}