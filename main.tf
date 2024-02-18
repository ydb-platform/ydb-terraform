provider "yandex" {
  service_account_key_file = var.key_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_name[0]
  profile                  = var.profile
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


module "storage" {
  source = "./modules/storage/"

  #==== Global data input ======#
  module_zone_name = var.zone_name
  module_static_node_disk_per_vm = var.static_node_disk_per_vm
  module_static_node_attache_disk_name = var.static_node_attache_disk_name
  module_static_node_vm_value = var.static_node_vm_value

  #===== Auth data input =======#
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_profile = var.profile
  auth_folder_id = var.folder_id
  auth_zone_name = var.zone_name

}

module "vpc" {
  source = "./modules/vpc/"

  #===== Auth data input =======#
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_profile = var.profile
  auth_folder_id = var.folder_id
  auth_zone_name = var.zone_name


}

module "ydb_vms" {
  source         = "./modules/vm/ydb_vms/"

  #==== Another module data input===# 
  input_static_disks_ids = module.storage.ydb_static_disks_ids
  input_subnet_ids  = module.vpc.subnet_ids
  input_module_static_node_disk_per_vm = var.static_node_disk_per_vm

  #==== Global data input ======#
  module_static_node_attache_disk_name = var.static_node_attache_disk_name
  module_ssh_key_pub_path = var.ssh_key_pub_path
  module_user = var.user
  module_static_node_vm_value = var.static_node_vm_value
  module_vps_platform = var.vps_platform
  module_domain = var.domain

  #===== Auth data input =======#
  auth_key_path = var.key_path
  auth_cloud_id = var.cloud_id
  auth_profile = var.profile
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
  auth_profile = var.profile
  auth_folder_id = var.folder_id
  auth_zone_name = var.zone_name
}

