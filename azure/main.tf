terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
       prevent_deletion_if_contains_resources = false
    }
  }
}

module "resource_group" {
    source = "./modules/resource_group"

    auth_location = var.auth_location
    auth_resource_group_name = var.auth_resource_group_name
}

module "vpc" {
    source = "./modules/vpc"

    module_group_name = module.resource_group.group_name
    input_subnets_count = var.subnets_count
    input_network_interface_count = var.vm_count

    auth_location = var.auth_location
    input_network_name = var.network_name
    input_vm_count = var.vm_count
    module_network_security_group_id = module.security.network_security_group_id
}

module "security" {
  source = "./modules/security"

  auth_location = var.auth_location
  module_group_name = module.resource_group.group_name

}

module "vm" {
    source = "./modules/vm"

    input_vm_name = var.vm_name
    input_vm_count = var.vm_count
    module_group_name = module.resource_group.group_name
    auth_location = var.auth_location
    input_vm_size = var.vm_size
    input_user = var.vm_user
    input_ssh_keys = var.ssh_key_path
    module_network_interface_ids = module.vpc.network_interface_main_ids
    input_nat_private_ip_first_vm = module.vpc.nat_private_ip_first_vm
}


module "dns" {
  source = "./modules/dns"

  module_group_name = module.resource_group.group_name
  module_virtual_network_main_id = module.vpc.virtual_network_main_id
  input_vm_count = var.vm_count
  input_domain = var.domain
  module_vm_private_ips = module.vpc.vm_private_ips
  input_vm_name = var.vm_name
}