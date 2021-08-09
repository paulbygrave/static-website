resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name = "${var.domain}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.cdn.domain_name}"
    zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}