resource "aws_internet_gateway" "ydb_intro_igw" {
  vpc_id = var.input_vpc_id

  tags = {
    Name = "ydb-intro-igw"
  }
}

resource "aws_route_table" "ydb_intro_rt" {
  vpc_id = var.input_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ydb_intro_igw.id
  }

  tags = {
    Name = "ydb-intro-rt"
  }
}

resource "aws_route_table_association" "ydb_intro_rta" {
  count = length(var.input_subnets_ids)

  subnet_id      = element(var.input_subnets_ids, count.index)
  route_table_id = aws_route_table.ydb_intro_rt.id
}

resource "aws_eip" "add_pub_ip_to_vms" {
  count    = length(var.vm_ids)
  instance = element(var.vm_ids, count.index)
}