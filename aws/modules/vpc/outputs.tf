output "vpc_id" {
  value       = aws_vpc.ydb-intro-net.id
  description = "The ID of the VPC"
}

output "subnets_ids" {
  value = aws_subnet.subnets.*.id
  description = "The IDs of the subnets"
}

output "pub_subnet_id" {
  value = aws_subnet.pub_subnet_nat.id
  description = "The IDs of the subnets"
}