#============= Create NET and Subnets ==============#

resource "yandex_vpc_network" "ydb-inner-net" {
  name = "ydb-inner-net"
  folder_id = var.auth_folder_id
}

resource "yandex_vpc_subnet" "add-subnet" {
  count = 3
  v4_cidr_blocks = ["10.${count.index + 1}.0.0/16"]
  name           = "subnet-a-ru-cent-${count.index + 1}"
  zone           = element(var.auth_zone_name, count.index % length(var.auth_zone_name))
  network_id     = yandex_vpc_network.ydb-inner-net.id
  folder_id      = var.auth_folder_id
}