#======= Auth vars =========#

variable "auth_location" {
  type        = string
  description = "The name of the location, often referring to a geographical or cloud region."
}

variable "module_group_name" {
  type        = string
  description = "The name of the group for organizing resources."
}

#======= SSH vars ===========#

variable "input_ssh_keys" {
  type        = string
  description = "The path to the public SSH key for authentication."
}

variable "input_user" {
  type        = string
  description = "The SSH username for accessing the system."
}

#======== Compute and storage vars ======#

variable "input_vm_count" {
  description = "The number of VMs to create or manage."
  type        = number
}

variable "input_vm_size" {
  type        = string
  description = "The predefined size specification for the VM, determining its compute resources."
}

variable "input_vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

#======= NET vars =========#

variable "module_network_interface_ids" {
  type        = list(string)
  description = "A list of network interface IDs to attach to the VMs. The free tier allows a maximum of 2 interfaces."
}

variable "input_nat_private_ip_first_vm" {
  type        = string
  description = "The private IP address of the first VM, used for NAT configurations."
}