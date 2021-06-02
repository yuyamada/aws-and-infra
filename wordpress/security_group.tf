resource "aws_security_group" "web" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-web"
  }
}

resource "aws_security_group_rule" "web_ping_from_all" {
  type              = "ingress"
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_ssh_from_all" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_http_from_all" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_to_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group" "db" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-db"
  }
}

resource "aws_security_group_rule" "db_mysql_from_web" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.web.id
  security_group_id        = aws_security_group.db.id
}

resource "aws_security_group_rule" "db_to_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db.id
}
