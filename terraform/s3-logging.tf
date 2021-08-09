resource "aws_s3_bucket" "logs" {
  bucket = "${local.name}-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_object" "logs" {
    bucket = aws_s3_bucket.logs.id
    acl    = "private"
    key    = "logs/"
    source = "/dev/null"
}