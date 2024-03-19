resource "aws_eip" "internet_gateway" {
  domain = "vpc"

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_eip" "node_1_eip" {
  domain = "vpc"
  instance = var.input_node_1_id

  tags = {
    Name = "node_1_eip"
  }
}