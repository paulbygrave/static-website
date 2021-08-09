resource "aws_s3_bucket" "website" {
  bucket = "${local.name}-website-bucket"
  acl    = "private"

  tags = {
    Name    = "${local.name}-website-bucket"
    Project = "${local.name}"
  }
}