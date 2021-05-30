resource "aws_security_group" "aws_and_infra" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "aws_and_infra"
  }
}

resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.aws_and_infra.cidr_block]
  security_group_id = aws_security_group.aws_and_infra.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [aws_vpc.aws_and_infra.cidr_block]
  security_group_id = aws_security_group.aws_and_infra.id
}
