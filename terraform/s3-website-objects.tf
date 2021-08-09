resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.website.id
  key    = "index.html"
  source = "${path.module}/files/index.html"

  etag = filemd5("${path.module}/files/index.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.website.id
  key    = "error.html"
  source = "${path.module}/files/error.html"

  etag = filemd5("${path.module}/files/error.html")
}