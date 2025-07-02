# S3 Bucket Resource
resource "aws_s3_bucket" "crc_bucket" {
  bucket        = "asoloa.com"
  force_destroy = true
  tags          = local.common_tags
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "crc_bucket" {
  bucket                  = aws_s3_bucket.crc_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "crc_bucket_policy" {
  bucket = aws_s3_bucket.crc_bucket.id
  policy = <<EOT
    {
        "Version": "2008-10-17",
        "Id": "PolicyForCloudFrontPrivateContent",
        "Statement": [
            {
                "Sid": "AllowCloudFrontServicePrincipal",
                "Effect": "Allow",
                "Principal": {
                    "Service": "cloudfront.amazonaws.com"
                },
                "Action": "s3:GetObject",
                "Resource": "${aws_s3_bucket.crc_bucket.arn}/*",
                "Condition": {
                    "StringEquals": {
                        "AWS:SourceArn": "${aws_cloudfront_distribution.s3_distribution.arn}"
                    }
                }
            }
        ]
    }
    EOT
}