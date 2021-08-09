resource "aws_s3_bucket" "logs" {
  bucket = "${var.domain}-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_object" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
  key    = "logs/"
  source = "/dev/null"
}