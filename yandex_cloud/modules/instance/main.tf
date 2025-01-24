#============== Create VM for static nodes ================#

resource "yandex_compute_instance" "ydb-static-nodes" {
  count = var.instance_count
  platform_id = var.instance_platform
  name  = "${var.instance_name}-${1 + count.index}"
  zone  = element(var.auth_zone_name, count.index % length(var.auth_zone_name))
  allow_stopping_for_update = true
  hostname = "${var.instance_hostname}-${1 + count.index}.${var.module_domain}"
  

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.instance_image_id
      size = var.boot_disk_size
      type = var.instance_boot_disk_type
      name = "${var.instance_name}-${1 + count.index}-boot"
    }
  }

  dynamic "secondary_disk" {
    for_each = { for k, v in var.map_sec_disks_names_ids : k => v if startswith(k, "${var.instance_name}-${1 + count.index}")
}
    content {
      disk_id = secondary_disk.value
    }
  }


  network_interface {
    subnet_id = element(var.input_subnet_ids, count.index % length(var.input_subnet_ids))
    nat       = count.index == 0 ? true : false
  
  }

  metadata = {
    ssh-keys = "${var.module_user}:${file(var.module_ssh_key_pub_path)}"
  }

}
