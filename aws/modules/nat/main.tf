resource "aws_nat_gateway" "ydb-pub-nat" {
  allocation_id = var.input_eip_id
  subnet_id     = var.input_pub_subnet_id

  tags = {
    Name = "gw NAT"
  }
}