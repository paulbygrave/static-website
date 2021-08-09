# SSL Certificate
resource "aws_acm_certificate" "ssl_certificate" {
  provider                  = aws.acm_provider
  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "EMAIL"

  tags = {
    Name    = "${var.domain}-certificate"
    Project = "${var.domain}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Validation for the certificate
resource "aws_acm_certificate_validation" "cert_validation" {
  provider        = aws.acm_provider
  certificate_arn = aws_acm_certificate.ssl_certificate.arn
}