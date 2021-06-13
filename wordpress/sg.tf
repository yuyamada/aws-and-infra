module "sg_web" {
  source = "./modules/sg"

  config = {
    vpc_id = aws_vpc.aws_and_infra.id
    ingress = [
      {
        protocol        = "icmp",
        port            = -1,
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        protocol        = "tcp",
        port            = 22,
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        protocol        = "tcp",
        port            = 80,
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
    ]
  }
}

module "sg_db" {
  source = "./modules/sg"

  config = {
    vpc_id = aws_vpc.aws_and_infra.id
    ingress = [
      {
        protocol        = "tcp",
        port            = 80,
        cidr_blocks     = []
        security_groups = [module.sg_web.id]
      },
    ]
  }
}

module "sg_lb" {
  source = "./modules/sg"

  config = {
    vpc_id = aws_vpc.aws_and_infra.id
    ingress = [
      {
        protocol        = "icmp",
        port            = -1,
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        protocol        = "tcp",
        port            = 80,
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
    ]
  }
}
