resource "aws_eip" "web" {
  vpc                       = true
  instance                  = aws_instance.web.id
  associate_with_private_ip = aws_instance.web.private_ip
}

output "web_public_ip" {
  value = aws_eip.web.public_ip
}

resource "aws_eip" "web_sub" {
  vpc                       = true
  instance                  = aws_instance.web_sub.id
  associate_with_private_ip = aws_instance.web_sub.private_ip
}

output "web_sub_public_ip" {
  value = aws_eip.web_sub.public_ip
}
