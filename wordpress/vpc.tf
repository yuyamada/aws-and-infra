resource "aws_vpc" "aws_and_infra" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-vpc"
  }
}
