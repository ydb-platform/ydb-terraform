#========= Auth ===============#

variable "auth_location" {
    description = ""
    type = string
    default = "East US"   
}

variable "auth_resource_group_name" {
    description = ""
    type = string
    default = "ydb-test-group"   
}

#======== VM conf vars ============#

variable "vm_name" {
    description = ""
    type = string
    default = "ydb-node" 
}

variable "vm_user" {
    description = ""
    type = string
    default = "ubuntu"
}

variable "vm_size" {
    description = ""
    type = string
    default = "Standard_B1ls"
}

variable "ssh_key_path" {
    description = ""
    type = string
    default = "~/yandex.pub"
}

variable "network_name" {
    description = ""
    type = string
    default = "ydb-network"
}