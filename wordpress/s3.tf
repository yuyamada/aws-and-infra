resource "aws_s3_bucket" "aws_and_infra" {
  bucket = "yuyamada-aws-and-infra-wp"
  acl    = "private"
}
