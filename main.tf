#========== Provider initializing zone =============
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

#============== Auth zone ================
provider "yandex" {
  service_account_key_file = var.key_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_name
  profile                  = "Yandex"
}


#============== Create DNS private zone ================
resource "yandex_dns_zone" "ydb-claster-dns-private" {
  name             = var.dns_name
  zone             = var.domain
  public           = false
  private_networks = [var.private_network]
}

#============== Create NET disks for static nodes =========
resource "yandex_compute_disk" "ydb-static-disks" {
  count = var.static_node_vm_value * var.static_node_disk_per_vm 
  name = "${var.static_node_attache_disk_name}-${count.index + 1}"
  size = var.static_node_storage_size
  type = var.static_node_attache_disk_type
  zone = var.zone_name
}

resource "yandex_compute_instance" "ydb-static-nodes" {
  count = var.static_node_vm_value
  platform_id = var.vps_platform
  name  = "${var.static_node_vm_name}-${count.index + 1}"
  zone  = var.zone_name
  allow_stopping_for_update = true
  hostname = "${var.static_node_hostname}-${count.index + 1}.${var.domain}"
  

  resources {
    cores  = var.static_node_cores
    memory = var.static_node_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = var.boot_disk_size
      type = var.boot_disk_type
    }
  }

  dynamic "secondary_disk" {
    for_each = slice(yandex_compute_disk.ydb-static-disks.*.id, count.index * var.static_node_disk_per_vm , (count.index + 1) * var.static_node_disk_per_vm )
    content {
      disk_id = secondary_disk.value
      device_name = "${var.static_node_attache_disk_name}-${secondary_disk.key + 1}"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = count.index == var.static_node_vm_value - 1 ? true : false
  
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub_path)}"
  }

}


#======= Create DNS zone ===============#
resource "yandex_dns_recordset" "ydb-static-nodes-fqdn" {
  count = length(yandex_compute_instance.ydb-static-nodes.*.id)

  zone_id = yandex_dns_zone.ydb-claster-dns-private.id
  name    = "static-node-${count.index + 1}"
  type    = "A"
  ttl     = 300
  data    = [yandex_compute_instance.ydb-static-nodes[count.index].network_interface[0].ip_address]
}

resource "yandex_dns_recordset" "ydb-claster-a-record" {
  zone_id = yandex_dns_zone.ydb-claster-dns-private.id
  name    = var.domain
  type    = "A"
  ttl     = 300
  data    = tolist([for instance in yandex_compute_instance.ydb-static-nodes : instance.network_interface[0].ip_address])
}

resource "local_file" "hosts" {
  content = <<-EOF
    [all]
    
    ${yandex_compute_instance.ydb-static-nodes[length(yandex_compute_instance.ydb-static-nodes.*.id) - 1].network_interface[0].nat_ip_address} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/yandex ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  EOF
  filename = "./hosts"
}