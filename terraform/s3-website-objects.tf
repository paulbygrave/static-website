resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.website_bucket.id
  acl          = "public-read"
  key          = "index.html"
  source       = "${path.module}/files/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/files/index.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.website_bucket.id
  acl          = "public-read"
  key          = "error.html"
  source       = "${path.module}/files/error.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/files/error.html")
}

resource "aws_s3_bucket_object" "logo" {
  bucket       = aws_s3_bucket.website_bucket.id
  acl          = "public-read"
  key          = "images/checkout2.png"
  source       = "${path.module}/images/checkout2.png"
  content_type = "image/jpeg"
  etag         = filemd5("${path.module}/images/checkout2.png")
}