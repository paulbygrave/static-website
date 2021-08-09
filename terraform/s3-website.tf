# Our WWW S3 bucket that will hold our objects
resource "aws_s3_bucket" "website_bucket" {
  bucket = "www.${var.domain}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = aws_s3_bucket.logs.id
    target_prefix = "logs/"
  }

  versioning {
    enabled = true
  }

  tags = {
    Name    = "${var.domain}-website-bucket"
    Project = "${var.domain}"
  }
}

# Bucket policy that enables public access to the bucket and objects
# Ideally we'd lock this down and use a Cloudfront Origin Access Identity to grant access instead
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "WebsiteBucketPolicy"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.website_bucket.arn,
          "${aws_s3_bucket.website_bucket.arn}/*",
        ]
      }
    ]
  })
}

# Root S3 bucket with the redirect
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.domain
  acl    = "public-read"

  website {
    redirect_all_requests_to = "www.${var.domain}"
  }

  tags = {
    Name    = "${var.domain}-root-bucket"
    Project = "${var.domain}"
  }
}