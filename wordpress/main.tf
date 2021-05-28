provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "aws_and_infra" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aws-and-infra-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "aws-and-infra-public-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "aws-and-infra-private-subnet-1a"
  }
}
