resource "aws_acm_certificate" "yuyamada" {
  domain_name               = "yuyamada.com"
  subject_alternative_names = ["*.yuyamada.com"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
