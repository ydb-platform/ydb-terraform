resource "aws_eip" "nat_eip" {
  count = 3
  domain = "vpc"

  tags = {
    Name = "NAT_EIP_${count.index + 1}"
  }
}