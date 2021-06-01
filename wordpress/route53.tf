data "terraform_remote_state" "common" {
  backend = "s3"
  config = {
    bucket = "yuyamada-terraform"
    key    = "aws_and_infra/common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


resource "aws_route53_record" "root" {
  zone_id = data.terraform_remote_state.common.outputs.zone_id
  name    = "yuyamada.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.web.public_ip]
}
