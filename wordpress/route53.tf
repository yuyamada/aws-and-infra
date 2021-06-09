resource "aws_route53_record" "root" {
  zone_id = data.terraform_remote_state.common.outputs.zone_id
  name    = "yuyamada.com"
  type    = "A"

  alias {
    name                   = aws_lb.aws_and_infra.dns_name
    zone_id                = aws_lb.aws_and_infra.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "static" {
  zone_id = data.terraform_remote_state.common.outputs.zone_id
  name    = "static.yuyamada.com"
  type    = "CNAME"
  ttl     = 300
  records = ["d1nzw99wzczesy.cloudfront.net"]
}
