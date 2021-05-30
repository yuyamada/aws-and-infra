resource "aws_internet_gateway" "aws_and_infra" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-igw"
  }
}
