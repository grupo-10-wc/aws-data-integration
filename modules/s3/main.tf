resource "aws_s3_bucket" "s3_raw_bucket_wc" {
  bucket = var.bucket_name
  tags = var.tags

  force_destroy = false
  object_lock_enabled = false
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.s3_raw_bucket_wc.id

  block_public_acls = false
  block_public_policy = false
}