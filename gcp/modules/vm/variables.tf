variable "input_vm_count" {
  description = "The number of virtual machines to create."
  type        = number
}

variable "input_vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "input_vm_size" {
  description = "The size specification of the virtual machine based on the required resources."
  type        = string
}

variable "input_zones" {
  description = "Allow GCP zones by region."
  type        = list(string)
}

variable "input_subnets_ids" {
  description = "Subnet ids."
  type        = list(string)
}

variable "input_bootdisk_image" {
    description = "Bootdisk image"
    type = string
}

variable "input_user" {
    description = "User for connect by SSH"
    type = string
}

variable "input_ssh_key_pub_path" {
    description = "Path to public SSH key"
    type = string
}

variable "input_attached_disks_names" {
    description = "Names of attached disks."
    type = list(string)
}

variable "input_public_ip" {
  description = ""
  type = string
}

variable "input_network_name" {
  description = ""
  type = string
}

variable "input_domain" {
  description = ""
  type = string
}