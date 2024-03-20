resource "aws_route_table" "rout_public_subnets" {
  vpc_id = var.input_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.input_igw_id
  }

  tags = {
    Name = "Route to public IP"
  }
}

resource "aws_route_table" "rout_private_subnets" {
  count  = var.input_subnets_count
  vpc_id = var.input_vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(var.input_nats_ids, count.index)
  }

  tags = {
    Name = "Route private NET to NAT ${count.index + 1}"
  }
}


resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = var.input_pub_subnets_ids[count.index]
  route_table_id = aws_route_table.rout_public_subnets.id
}

resource "aws_route_table_association" "private" {
  count          = var.input_subnets_count
  subnet_id      = var.input_private_subnets_ids[count.index]
  route_table_id = aws_route_table.rout_private_subnets[count.index].id
}