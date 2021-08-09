resource "aws_s3_bucket" "website" {
  bucket = "${local.name}.com"
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
    Name    = "${local.name}-website-bucket"
    Project = "${local.name}.com"
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

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
          aws_s3_bucket.website.arn,
          "${aws_s3_bucket.website.arn}/*",
        ]
      }
    ]
  })
}

resource "aws_s3_bucket" "subdomain" {
  bucket = "www.${local.domain_name}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "http://${local.domain_name}"
  }

  tags = {
    Name    = "${local.domain_name}-redirect-bucket"
    Project = "${local.domain_name}.com"
  }
}