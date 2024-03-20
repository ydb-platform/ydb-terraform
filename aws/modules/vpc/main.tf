resource "aws_vpc" "ydb-intro-net" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ydb-intro-net"
  }
}


resource "aws_subnet" "public_subnets" {
  count = 3
  vpc_id            = aws_vpc.ydb-intro-net.id
  cidr_block        = cidrsubnet(aws_vpc.ydb-intro-net.cidr_block, 8, (count.index + 1) * 10)
  availability_zone = var.subnets_availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "ydb-public-subnet-${var.subnets_availability_zones[count.index]}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = var.subnets_count
  vpc_id            = aws_vpc.ydb-intro-net.id
  cidr_block        = cidrsubnet(aws_vpc.ydb-intro-net.cidr_block, 8, (count.index + 1) * 10 + 1)
  availability_zone = var.subnets_availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "ydb-private-subnet-${var.subnets_availability_zones[count.index]}"
  }
}

