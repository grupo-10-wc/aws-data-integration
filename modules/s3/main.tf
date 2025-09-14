resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags

  force_destroy       = false
  object_lock_enabled = false
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.this.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  count = var.lambda_function_arn != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }
}