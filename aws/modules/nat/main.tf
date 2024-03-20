resource "aws_nat_gateway" "ydb-pub-nat" {
  count         = 3
  allocation_id = var.input_eips_ids[count.index]
  subnet_id     = var.input_public_subnets_ids[count.index]

  tags = {
    Name        = "NAT-${count.index + 1}"
  }
}