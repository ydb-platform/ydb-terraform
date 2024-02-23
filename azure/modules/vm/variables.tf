variable "input_vm_name" {
    description = ""
    type = string
}

variable "input_vm_count" {
    description = ""
    type = number
}


variable "auth_location" {
    type = string
    description = ""
}

variable "module_group_name" {
    type = string
    description = ""
}


variable "input_ssh_keys" {
    type = string
    description = ""
}

variable "input_user" {
    type = string
    description = ""
}

variable "input_vm_size" {
    type = string
    description = ""
}

variable "module_network_interface_ids" {
  type        = list(string)
  description = "List of network interface IDs to attach to the VMs"
}