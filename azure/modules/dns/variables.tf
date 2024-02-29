variable "module_group_name" {
  description = "The name of the group where the DNS will be created."
  type        = string
}

variable "module_virtual_network_main_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "input_vm_count" {
  description = "The count of VMs. Used for adding records in the DNS zone."
  type        = number
}

variable "module_vm_private_ips" {
  description = "The list of private IP addresses for VMs within the internal network."
  type        = list(string)
}

variable "input_domain" {
  description = "The domain name."
  type        = string
}

variable "input_vm_name" {
  description = "The name of the VM. Used in creating the VM's FQDN."
  type        = string
}