resource "aws_security_group" "aws_and_infra" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "aws_and_infra"
  }
}

resource "aws_security_group_rule" "ingress_ping" {
  type              = "ingress"
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_and_infra.id
}

resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_and_infra.id
}

resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_and_infra.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_and_infra.id
}
