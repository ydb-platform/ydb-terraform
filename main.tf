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


#============ Create static nodes instances ========

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
  hostname = "${var.static_node_hostname}-${count.index + 1}"
  

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
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub_path)}"
  }

}


#=============== Create Dynnodes zone ==========================#

#============== Create NET disks for Dynnodes =========
resource "yandex_compute_disk" "ydb-dynnode-disks" {
  count = var.dyn_node_vm_value * var.dyn_node_disk_per_vm 
  name = "${var.dyn_node_attache_disk_name}-${count.index + 1}"
  size = var.dyn_node_storage_size
  type = var.dyn_node_attache_disk_type
  zone = var.zone_name
}

#============ Create dynnode instances ========
resource "yandex_compute_instance" "ydb-dynnode" {
  count = var.dyn_node_vm_value
  platform_id = var.vps_platform
  name  = "${var.dyn_node_vm_name}-${count.index + 1}"
  zone  = var.zone_name
  allow_stopping_for_update = true
  hostname = "${var.dyn_node_hostname}-${count.index + 1}"

  resources {
    cores  = var.dyn_node_cores
    memory = var.dyn_node_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = var.boot_disk_size
      type = var.boot_disk_type
    }
  }

  dynamic "secondary_disk" {
    for_each = slice(yandex_compute_disk.ydb-dynnode-disks.*.id, count.index * var.dyn_node_disk_per_vm , (count.index + 1) * var.dyn_node_disk_per_vm )
    content {
      disk_id = secondary_disk.value
      device_name = "${var.dyn_node_attache_disk_name}-${secondary_disk.key + 1}"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub_path)}"
  }

}


#=================== Output data ========================#
output "vm_public_dynnodes_ips" {
  value = yandex_compute_instance.ydb-dynnode.*.network_interface.0.nat_ip_address
}

output "vm_public_static_nodes_ips" {
  value = yandex_compute_instance.ydb-static-nodes.*.network_interface.0.nat_ip_address
}

output "static_node_names" {
  value = yandex_compute_instance.ydb-static-nodes.*.hostname
}

output "dynamic_node_names" {
  value = yandex_compute_instance.ydb-dynnode.*.hostname
}


resource "local_file" "hosts" {
  content = <<-EOF
    [${var.static_node_vm_name}]
    ${join("\n", [for i, static_node in yandex_compute_instance.ydb-static-nodes : "${static_node.hostname} ansible_host=${static_node.network_interface.0.nat_ip_address} ic_port=${var.static_node_start_ic_port + i} grpc_port=${var.static_node_start_grpc_port + i} mon_port=${var.static_node_start_mon_port + i} non_mounted_disks_val=${var.static_node_disk_per_vm} ansible_ssh_user=${var.user} ansible_ssh_private_key_file=${var.ssh_key_private_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'"])}
    
    [${var.dyn_node_vm_name}]
    ${join("\n", [for i, dyn_node in yandex_compute_instance.ydb-dynnode : "${dyn_node.hostname} ansible_host=${dyn_node.network_interface.0.nat_ip_address} ic_port=${var.dyn_node_start_ic_port + i} grpc_port=${var.dyn_node_start_grpc_port + i} mon_port=${var.dyn_node_start_mon_port + i} non_mounted_disks_val=${var.dyn_node_disk_per_vm} ansible_ssh_user=${var.user} ansible_ssh_private_key_file=${var.ssh_key_private_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'"])}
  EOF

  filename = "./hosts"
}







