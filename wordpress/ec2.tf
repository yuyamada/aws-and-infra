data "template_file" "user_data" {
  template = file("./user_data.sh.tpl")
  vars = {
    db_host           = aws_db_instance.mysql.address
    db_root_user      = "root"
    db_root_password  = "password" # TODO: use secret manager
    wp_db_name        = "aws_and_infra"
    wp_db_user        = "aws_and_infra"
    wp_db_password    = "password" # TODO: use secret manager 
    wp_url            = "http://yuyamada.com"
    wp_title          = "aws_and_infra"
    wp_admin_user     = "aws_and_infra"
    wp_admin_password = "password" # TODO: use secret manager 
    wp_admin_email    = "ya4ma1da3@gmail.com"
  }
}


resource "aws_instance" "web" {
  ami                    = "ami-0ca38c7440de1749a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  private_ip             = "10.0.10.10"
  key_name               = aws_key_pair.aws_and_infra.id
  iam_instance_profile   = aws_iam_instance_profile.wpadmin.name
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-web"
  }
}

resource "aws_instance" "web_sub" {
  ami                    = "ami-0ca38c7440de1749a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_sub.id
  vpc_security_group_ids = [aws_security_group.web.id]
  private_ip             = "10.0.11.10"
  key_name               = aws_key_pair.aws_and_infra.id
  iam_instance_profile   = aws_iam_instance_profile.wpadmin.name
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-web-sub"
  }
}
