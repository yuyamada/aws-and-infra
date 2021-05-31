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
