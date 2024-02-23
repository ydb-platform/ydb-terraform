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

variable "vm_count" {
    description = ""
    type = number
    default = 4
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

#====== NETS conf vars =========#

variable "subnets_count" {
    type = number
    description = ""
    default = 3
}

#========= DNS conf vars =========#

variable "domain" {
    type = string
    description = ""
    default = "ydb-cluster.com"
}