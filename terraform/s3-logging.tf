# Separate bucket for S3 access logs (AWS sends logs every 2 hours)
resource "aws_s3_bucket" "logs" {
  bucket = "${var.domain}-log-bucket"
  acl    = "log-delivery-write"
}

# S3 directory object to use as prefix
resource "aws_s3_bucket_object" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
  key    = "logs/"
  source = "/dev/null"
}