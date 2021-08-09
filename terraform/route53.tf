resource "aws_route53_record" "domain" {
   name = local.domain_name
   zone_id = data.aws_route53_zone.domain.zone_id
   type = "A"
   alias {
     name = aws_s3_bucket.website.bucket_domain_name
     zone_id = aws_s3_bucket.website.hosted_zone_id
     evaluate_target_health = true
   }
}