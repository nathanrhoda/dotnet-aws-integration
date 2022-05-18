resource "aws_kms_key" "this" {}

resource "aws_sqs_queue" "nathan_queue" {
  name                              = "${var.queue_name}"
  kms_master_key_id                 = aws_kms_key.this.id
  kms_data_key_reuse_period_seconds = 300
  fifo_queue                  = true
  content_based_deduplication = true
}