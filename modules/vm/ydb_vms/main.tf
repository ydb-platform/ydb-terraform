#============== Create VM for static nodes ================#
resource "yandex_compute_instance" "ydb-static-nodes" {
  count = var.module_static_node_vm_value
  platform_id = var.module_vps_platform
  name  = "${var.static_node_vm_name}-${count.index + 1}"
  zone  = element(var.auth_zone_name, count.index % length(var.auth_zone_name))
  allow_stopping_for_update = true
  hostname = "${var.static_node_hostname}-${count.index + 1}.${var.module_domain}"
  

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
    for_each = slice(var.input_static_disks_ids, count.index * var.input_module_static_node_disk_per_vm, (count.index + 1) * var.input_module_static_node_disk_per_vm)
    content {
      disk_id = secondary_disk.value
      device_name = "${var.module_static_node_attache_disk_name}-${secondary_disk.key + 1}"
    }
  }

  network_interface {
    subnet_id = element(var.input_subnet_ids, count.index % length(var.input_subnet_ids))
    nat       = true
  
  }

  metadata = {
    ssh-keys = "var.module_user:${file(var.module_ssh_key_pub_path)}"
  }

}