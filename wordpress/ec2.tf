resource "aws_instance" "web" {
  ami                    = "ami-0ca38c7440de1749a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  private_ip             = "10.0.10.10"
  key_name               = aws_key_pair.aws_and_infra.id

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl enable httpd.service
    systemctl start httpd.service
    sudo yum install -y mysql
  EOF

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-web"
  }
}
