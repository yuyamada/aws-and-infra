resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws_and_infra.id

  tags = {
    Name = "${local.project_name}-${terraform.workspace}-public-route-table"
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

resource "aws_route_table_association" "public_sub" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.public.id
}
