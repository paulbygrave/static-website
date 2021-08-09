resource "aws_s3_bucket" "website" {
  bucket = "${local.name}-website.paulbygrave.com"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  versioning {
    enabled = true
  }

  tags = {
    Name    = "${local.name}-website-bucket"
    Project = "${local.name}"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${local.name}-log-bucket"
  acl    = "log-delivery-write"
}
