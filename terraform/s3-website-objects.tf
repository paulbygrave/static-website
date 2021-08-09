resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.website.id
  key    = "index.html"
  source = "${path.module}/files/index.html"
  content_type = "text/html"
  etag = filemd5("${path.module}/files/index.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.website.id
  key    = "error.html"
  source = "${path.module}/files/error.html"
  content_type = "text/html"
  etag = filemd5("${path.module}/files/error.html")
}

resource "aws_s3_bucket_object" "logo" {
  bucket = aws_s3_bucket.website.id
  key    = "checkout2.png"
  source = "${path.module}/files/checkout2.png"
  etag = filemd5("${path.module}/files/checkout2.png")
}