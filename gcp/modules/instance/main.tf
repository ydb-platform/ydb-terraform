resource "google_compute_instance" "ydb-node" {
  count        = var.input_vm_count  
  name         = format("%s-%d", var.input_vm_name, count.index+1) 
  machine_type = var.input_vm_size
  zone         = var.input_zones[count.index % length(var.input_zones)]

  boot_disk {
    initialize_params {
      image = var.input_bootdisk_image
      size = 20
      
    }
  }

  hostname = format("%s-%d-%s", var.input_vm_name, count.index+1, trimsuffix(var.input_domain, "."))

  attached_disk {
    source = var.input_attached_disks_names[count.index % length(var.input_attached_disks_names)]
  }

  metadata = {
    ssh-keys = "${var.input_user}:${file(var.input_ssh_key_pub_path)}"
  }

  network_interface {
    network = var.input_network_name
    dynamic "access_config" {
      for_each = count.index == 0 ? [1] : []
      content {
        nat_ip = var.input_public_ip
      }
    }
    subnetwork = var.input_subnets_ids[count.index % length(var.input_subnets_ids)]
  }  
}