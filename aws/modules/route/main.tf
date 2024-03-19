resource "aws_route_table" "public" {
  vpc_id = var.input_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.input_igw_id
  }

  tags = {
    Name = "Route to public IP"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.input_subnets_count
  subnet_id      = var.input_subnets_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = var.input_pub_subnet_id
  route_table_id = aws_route_table.public.id
}
