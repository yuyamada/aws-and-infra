variable "config" {
  type = object({
    vpc_id = string
    ingress = list(object({
      protocol        = string
      port            = number
      cidr_blocks     = list(string)
      security_groups = list(string)
    }))
  })
}

resource "aws_security_group" "sg" {
  vpc_id = var.config.vpc_id

  dynamic "ingress" {
    for_each = var.config.ingress

    content {
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "id" {
  value = aws_security_group.sg.id
}
