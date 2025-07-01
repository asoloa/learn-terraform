resource "aws_s3_bucket" "test_bucket" {
    bucket = "asoloa-crc-test-bucket"
    force_destroy = true
    tags = {
        Name = "asoloa-crc-test-bucket"
        Environment = "Test"
    }
}

resource "aws_s3_bucket_public_access_block" "test_bucket" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}