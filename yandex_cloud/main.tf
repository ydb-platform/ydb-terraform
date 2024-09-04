provider "yandex" {
  service_account_key_file = var.key_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_name[0]
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

# =========== Storage =============#
# Create disks for VMs.


module "storage" {
  source = "./modules/storage/"

  zone_name = var.zone_name
  instance_count = var.instance_count

  # Auth data input
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_folder_id = var.folder_id

  instance_name = var.instance_name
  instance_boot_disk_type = var.instance_boot_disk_type
  instance_boot_disk_size = var.instance_boot_disk_size
  instance_data_disks_per_vm = var.instance_data_disks_per_vm
  instance_data_disk_type = var.instance_data_disk_type
  instance_data_disk_size = var.instance_data_disk_size

}

#============ VPC ============#
# Create Virtual Cloud NET and subnets. 

module "vpc" {
  source = "./modules/vpc/"

  # Auth data input
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_folder_id = var.folder_id
  auth_zone_name = var.zone_name

}

#=========== Instance =============#
# Create VMs. 

module "instance" {
  source         = "./modules/instance"

  instance_image_id = var.instance_image_id
  instance_count = var.instance_count
  instance_platform = var.instance_platform
  instance_hostname = var.instance_hostname
  instance_cores = var.instance_cores
  instance_memory = var.instance_memory
  instance_boot_disk_type = var.instance_boot_disk_type
  map_sec_disks_names_ids = module.storage.map_sec_disks_names_ids
  instance_name = var.instance_name
  instance_data_disks_per_vm = var.instance_data_disks_per_vm

  # Modules data input
  
  input_subnet_ids  = module.vpc.subnet_ids


  # Global data input
  module_ssh_key_pub_path = var.ssh_key_pub_path
  module_user = var.user
  module_domain = var.domain

  # Auth data input
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_folder_id = var.folder_id
  auth_zone_name = var.zone_name
  
  depends_on = [
    module.storage, module.vpc
  ]
}

module "dns" {
  source = "./modules/dns/"

  #==== Another module data input===# 
  input_net_id = module.vpc.net_id

  #==== Global data input ======#
  module_folder_id = var.folder_id
  module_domain = var.domain

  #===== Auth data input =======#
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_folder_id = var.folder_id
  auth_zone_name = var.zone_name
}

resource "local_file" "ydb_nodes_hosts" {
    content  = join("\n", module.instance.instances_fqdn)
    filename = "hosts.txt"
}

