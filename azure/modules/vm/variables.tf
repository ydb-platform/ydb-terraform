variable "input_vm_name" {
    description = ""
    type = string
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

variable "module_azurerm_network_interface" {
    type = list(string)
    description = ""
}