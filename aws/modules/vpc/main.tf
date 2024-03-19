resource "aws_vpc" "ydb-intro-net" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ydb-intro-net"
  }
}

resource "aws_subnet" "subnets" {
  count = var.subnets_count
  vpc_id            = aws_vpc.ydb-intro-net.id
  cidr_block        = cidrsubnet(aws_vpc.ydb-intro-net.cidr_block, 8, count.index + 1)
  availability_zone = var.subnets_availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "ydb-private-subnet-${var.subnets_availability_zones[count.index]}"
  }
}

resource "aws_subnet" "pub_subnet_nat" {
  vpc_id            = aws_vpc.ydb-intro-net.id
  cidr_block        = cidrsubnet(aws_vpc.ydb-intro-net.cidr_block, 8, var.subnets_count + 1)
  availability_zone = var.subnets_availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "ydb-pub-subnet"
  }
}