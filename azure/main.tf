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

    auth_location = var.auth_location
    input_network_name = var.network_name
}

module "vm" {
    source = "./modules/vm"

    input_vm_name = var.vm_name
    module_group_name = module.resource_group.group_name
    auth_location = var.auth_location
    input_vm_size = var.vm_size
    input_user = var.vm_user
    input_ssh_keys = var.ssh_key_path
    module_azurerm_network_interface = [module.vpc.network_interface_main, module.vpc.network_interface_int]
}