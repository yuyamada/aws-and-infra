resource "aws_key_pair" "aws_and_infra" {
  public_key = file("./.ssh/aws-and-infra.pub")
}
