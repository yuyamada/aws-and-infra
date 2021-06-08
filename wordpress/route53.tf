resource "aws_route53_record" "root" {
  zone_id = data.terraform_remote_state.common.outputs.zone_id
  name    = "yuyamada.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.web.public_ip]
}

resource "aws_route53_record" "static" {
  zone_id = data.terraform_remote_state.common.outputs.zone_id
  name    = "static.yuyamada.com"
  type    = "CNAME"
  ttl     = 300
  records = ["d1nzw99wzczesy.cloudfront.net"]
}
