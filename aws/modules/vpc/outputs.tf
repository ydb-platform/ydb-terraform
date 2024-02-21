output "vpc_id" {
  value       = aws_vpc.ydb-intro-net.id
  description = "The ID of the VPC"
}

output "subnet_ids" {
  value = aws_subnet.ydb-intro-subnet.*.id
  description = "The IDs of the subnets"
}