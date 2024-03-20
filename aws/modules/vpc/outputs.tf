output "vpc_id" {
  value       = aws_vpc.ydb-intro-net.id
  description = "The ID of the VPC"
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnets.*.id
  description = "The IDs of the subnets"
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id
  description = "The IDs of the subnets"
}