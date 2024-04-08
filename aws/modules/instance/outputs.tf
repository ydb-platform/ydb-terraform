output "instance_private_ips" {
  value = aws_instance.ydb-vm.*.private_ip
  description = "List of private IP addresses for the instance"
}

output "ydb_vm_ids" {
  value = aws_instance.ydb-vm.*.id
  description = "List of IDs for YDB VM instances"
}

output "map_instance_name_id" {
  description = "A map of instance IDs to their availability zones"
  value = { for instance in aws_instance.ydb-vm : instance.tags["Name"] => instance.id }
}
