locals {
  domain = "yuyamada.com"
}

resource "aws_route53_zone" "yuyamada" {
  name = local.domain

  tags = {
    Name = "yuyamada-route53-zone"
  }
}

output "zone_id" {
  value = aws_route53_zone.yuyamada.zone_id
}

output "name_servers" {
  value = aws_route53_zone.yuyamada.name_servers
}

resource "aws_route53_record" "cert" {
  for_each = {
    for dvo in aws_acm_certificate.yuyamada.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = aws_route53_zone.yuyamada.zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
}
