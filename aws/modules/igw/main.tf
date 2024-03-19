resource "aws_internet_gateway" "ydb_intro_igw" {
  vpc_id = var.input_vpc_id

  tags = {
    Name = "ydb-intro-igw"
  }
}