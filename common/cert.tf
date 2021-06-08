resource "aws_acm_certificate" "yuyamada" {
  domain_name               = "yuyamada.com"
  subject_alternative_names = ["*.yuyamada.com"]
  validation_method         = "DNS"
  provider                  = aws.virginia

  lifecycle {
    create_before_destroy = true
  }
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.yuyamada.arn
}
