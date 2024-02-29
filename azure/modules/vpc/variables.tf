#========== Auth vars =============#

variable "auth_location" {
  type        = string
  description = "The name of the location, often referring to an Azure region."
}

variable "module_group_name" {
  type        = string
  description = "The name of the group where resources are organized."
}

#======== NET setup vars ===========#

variable "input_network_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "input_network_interface_count" {
  type        = number
  description = "The number of network interfaces that will be created."
}

#======= Subnets setup vars =========#

variable "input_subnets_count" {
  type        = number
  description = "The number of subnets that will be created."
}

variable "module_network_security_group_id" {
  type        = string
  description = "The ID of the network security group that will be applied to the subnets."
}

variable "input_vm_count" {
  type        = number
  description = "The number of VMs that will be created."
}