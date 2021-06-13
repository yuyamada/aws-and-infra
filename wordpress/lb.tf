resource "aws_lb" "aws_and_infra" {
  name               = "aws-and-infra"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.sg_lb.id]
  subnets = [
    aws_subnet.public.id,
    aws_subnet.public_sub.id,
  ]
}

output "lb_dns_name" {
  value = aws_lb.aws_and_infra.dns_name
}

resource "aws_lb_target_group" "aws_and_infra" {
  name     = "aws-and-infra-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.aws_and_infra.id
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.aws_and_infra.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_sub" {
  target_group_arn = aws_lb_target_group.aws_and_infra.arn
  target_id        = aws_instance.web_sub.id
  port             = 80
}

resource "aws_lb_listener" "aws_and_infra" {
  load_balancer_arn = aws_lb.aws_and_infra.arn
  port              = 80

  default_action {
    target_group_arn = aws_lb_target_group.aws_and_infra.arn
    type             = "forward"
  }
}
