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

resource "aws_s3_bucket" "root_bucket" {
  bucket = "${var.domain}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "www.${var.domain}"
  }

  tags = {
    Name    = "${var.domain}-root-bucket"
    Project = "${var.domain}"
  }
}