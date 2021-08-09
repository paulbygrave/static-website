resource "aws_s3_bucket" "website" {
  bucket = var.domain
  acl    = "public-read"
  policy = <<EOF
    {
      "Version":"2008-10-17",
      "Statement":[{
        "Sid":"AllowPublicRead",
        "Effect":"Allow",
        "Principal": {"AWS": "*"},
        "Action":["s3:GetObject"],
        "Resource":["arn:aws:s3:::${var.domain}/*"]
      }]
    }
  EOF

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