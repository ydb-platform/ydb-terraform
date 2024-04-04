#============== Create VM for static nodes ================#

resource "yandex_compute_instance" "ydb-static-nodes" {
  count = var.instance_count
  platform_id = var.instance_platform
  name  = "${var.instance_name}-${count.index + 1}"
  zone  = element(var.auth_zone_name, count.index % length(var.auth_zone_name))
  allow_stopping_for_update = true
  hostname = "${var.instance_hostname}-${count.index + 1}.${var.module_domain}"
  

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.instance_image_id
      size = var.boot_disk_size
      type = var.instance_first_attached_disk_type
      name = "${var.instance_name}-${count.index + 1}-boot"
    }
  }

  dynamic "secondary_disk" {
    for_each = { for k, v in var.map_first_disks_names_ids : k => v if substr(k, 0, length(k) - 2) == "${var.instance_name}-${count.index + 1}" && substr(k, -1, 1) == "1"
}
    content {
      disk_id = secondary_disk.value
    }
  }

  dynamic "secondary_disk" {
    for_each = var.sec_instance_attached_disk ? { for k, v in var.map_sec_disks_names_ids : k => v if substr(k, 0, length(k) - 2) == "${var.instance_name}-${count.index + 1}" && substr(k, -1, 1) == "2"
} : {}
    content {
      disk_id = secondary_disk.value
    }
  }


  network_interface {
    subnet_id = element(var.input_subnet_ids, count.index % length(var.input_subnet_ids))
    nat       = count.index == 0 ? true : false
  
  }

  metadata = {
    ssh-keys = "var.module_user:${file(var.module_ssh_key_pub_path)}"
  }

}