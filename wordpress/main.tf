locals {
  project_name = "aws-and-infra"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "aws_and_infra" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${local.project_name}-public-subnet-1a"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${local.project_name}-private-subnet-1a"
  }
}

resource "aws_internet_gateway" "aws_and_infra" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "${local.project_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "${local.project_name}-public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.aws_and_infra.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}