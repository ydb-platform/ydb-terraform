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
  zone                     = var.zone_name[0]
  profile                  = var.profile
}

#============== Create NET disks for static nodes =========#
resource "yandex_compute_disk" "ydb-static-disks" {
  count = var.static_node_vm_value * var.static_node_disk_per_vm 
  name = "${var.static_node_attache_disk_name}-${count.index + 1}"
  size = var.static_node_storage_size
  type = var.static_node_attache_disk_type
  zone = element(var.zone_name, count.index % length(var.zone_name))
}

#============= Create NET and Subnets ==============#

resource "yandex_vpc_network" "ydb-inner-net" {
  name = "ydb-inner-net"
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "add-subnet" {
  count = 3
  v4_cidr_blocks = ["10.${count.index + 1}.0.0/16"]
  name           = "subnet-a-ru-cent-${count.index + 1}"
  zone           = element(var.zone_name, count.index % length(var.zone_name))
  network_id     = yandex_vpc_network.ydb-inner-net.id
  folder_id      = var.folder_id
}

output "subnet_ids" {
  value = yandex_vpc_subnet.add-subnet[*].id
}


#============= Create Ansible install VM =================#

resource "yandex_compute_instance" "ydb-ansible-install-vm" {
  platform_id = var.vps_platform
  name  = var.installation_vm_name
  zone  = var.zone_name[0]
  allow_stopping_for_update = true
  hostname = var.installation_vm_hostname
  

  resources {
    cores  = var.installation_vm_cores
    memory = var.installation_vm_ram
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = var.boot_disk_size
      type = var.installation_vm_boot_disk_type
    }
  }

  network_interface {
    subnet_id = element(yandex_vpc_subnet.add-subnet.*.id, 0)
    nat       = true
  
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub_path)}"
    user-data = file("${path.module}/ydb-ansible-vm-prepare.sh")
  }

}


#============== Create VM for static nodes ================#
resource "yandex_compute_instance" "ydb-static-nodes" {
  count = var.static_node_vm_value
  platform_id = var.vps_platform
  name  = "${var.static_node_vm_name}-${count.index + 1}"
  zone  = element(var.zone_name, count.index % length(var.zone_name))
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
      type = var.static_node_attache_disk_type
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
    subnet_id = element(yandex_vpc_subnet.add-subnet.*.id, count.index % length(yandex_vpc_subnet.add-subnet.*.id))
    nat       = true
  
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub_path)}"
  }

}

#============== Create DNS private zone ================
resource "yandex_dns_zone" "ydb-cluster-dns-private" {
  name             = var.dns_name
  zone             = var.domain
  public           = false
  private_networks = [yandex_vpc_network.ydb-inner-net.id]
  folder_id = var.folder_id
}
