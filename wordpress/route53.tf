locals {
  domain = "yuyamada.com"
}

resource "aws_route53_zone" "aws_and_infra" {
  name = local.domain

  tags = {
    Name = "aws-and-infra-route53-zone"
  }
}

output "name_servers" {
  value = aws_route53_zone.aws_and_infra.name_servers
}

resource "aws_route53_record" "aws_and_infra" {
  zone_id = aws_route53_zone.aws_and_infra.zone_id
  name    = local.domain
  type    = "A"
  ttl     = 300
  records = [aws_eip.aws_and_infra.public_ip]
}
