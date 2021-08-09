data "aws_route53_zone" "domain" {
  name         = local.domain_name
  private_zone = false
}