resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-public-subnet-1a"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-private-subnet-1a"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id                  = aws_vpc.aws_and_infra.id
  cidr_block              = "10.0.21.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-private-subnet-1c"
  }
}
