provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_kms_key" "this" {}

resource "aws_sqs_queue" "nathan_queue" {
  name                              = "nathan-queue"
  kms_master_key_id                 = aws_kms_key.this.id
  kms_data_key_reuse_period_seconds = 300
}

