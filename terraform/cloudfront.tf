
# resource "aws_cloudfront_distribution" "cdn" {
#   origin {
#     origin_id   = var.domain
#     domain_name = "${var.domain}.s3.amazonaws.com"
#   }

#   enabled             = true
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = var.domain

#     forwarded_values {
#       query_string = true
#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   # The cheapest priceclass
#   price_class = "PriceClass_100"

#   # This is required to be specified even if it's not used.
#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#       locations        = []
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }