resource "aws_eip" "aws_and_infra" {
  vpc                       = true
  instance                  = aws_instance.aws_and_infra.id
  associate_with_private_ip = aws_instance.aws_and_infra.private_ip
}

output "public_ip" {
  value = aws_eip.aws_and_infra.public_ip
}
