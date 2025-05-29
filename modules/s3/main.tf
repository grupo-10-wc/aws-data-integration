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