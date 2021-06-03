data "template_file" "user_data" {
  template = file("./user_data.sh.tpl")
  vars = {
    db_host          = aws_db_instance.mysql.address
    db_root_user     = "root"
    db_root_password = "password"
  }
}


resource "aws_instance" "web" {
  ami                    = "ami-0ca38c7440de1749a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  private_ip             = "10.0.10.10"
  key_name               = aws_key_pair.aws_and_infra.id

  provisioner "file" {
    source      = "./init.sql"
    destination = "~/init.sql"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.web.public_ip
      private_key = file("./.ssh/aws-and-infra")
    }
  }

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-web"
  }
}
