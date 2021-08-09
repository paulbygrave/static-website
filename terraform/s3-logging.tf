resource "aws_s3_bucket" "log_bucket" {
  bucket = "${local.name}-log-bucket"
  acl    = "log-delivery-write"
}
