#=============== Auth vars control zone ===========#

variable "auth_location" {
  description = "The region where the infrastructure will be created."
  type        = string
  default     = "East US"
}

variable "auth_resource_group_name" {
  description = "The name of the group where the infrastructure will be created."
  type        = string
  default     = "ydb-test-group"
}

#=============== VM control vars zone ==============#

variable "vm_count" {
  description = "The number of virtual machines to create."
  type        = number
  default     = 4
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default     = "ydb-node"
}

variable "vm_user" {
  description = "The default SSH user name."
  type        = string
  default     = "ubuntu"
}

variable "vm_size" {
  description = "The size specification of the virtual machine based on the required resources."
  type        = string
  default     = "Standard_B1ls"
}

variable "ssh_key_path" {
  description = "The file path to the public SSH key for VM access."
  type        = string
  default     = "~/yandex.pub"
}

variable "network_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "ydb-network"
}

#============== NETS control vars zone ===============#

variable "subnets_count" {
  description = "The number of subnets to create within the network."
  type        = number
  default     = 3
}

#=============== DNS control vars zone ================#

variable "domain" {
  description = "The domain name associated with the DNS configurations."
  type        = string
  default     = "ydb-cluster.com"

}