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
  }

}