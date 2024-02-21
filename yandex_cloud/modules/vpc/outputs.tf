output "subnet_ids" {
  value = yandex_vpc_subnet.add-subnet[*].id
}

output "net_id" {
  value = yandex_vpc_network.ydb-inner-net.id
}
