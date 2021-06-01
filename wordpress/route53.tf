resource "aws_route53_record" "root" {
  zone_id = "Z04197496KUGLNFLCZGL" # common/route53.tf
  name    = "yuyamada.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.web.public_ip]
}
