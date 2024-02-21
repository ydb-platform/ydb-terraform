#========== Auth vars =================#

variable "key_path" {
    description = "Path to the json file with service account credentials"
    type = string
    default = "prod.json"
    
}

variable "cloud_id" {
    description = "Yandex Cloud ID"
    type = string
    default = "b1g7gqj2vnq67gjseuva" 
    
}

variable "profile" {
    description = "Profile section from"
    type = string
    default = "Yandex"
    
}

variable "folder_id" {
    description = "Yandex folder ID"
    type = string
    default = "b1gs3jaj6lvb189376n4"
}

variable "zone_name" {
    description = "Names of availability zones to use"
    type = list(string)
    default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
    
}


#====== String vars ========#
variable "vps_platform" {
    type = string
    default = "standard-v3"
    description = "standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake"
}

variable "static_node_attached_disk_name" {
    type = string
    default = "ydb-data-disk"
    description = "Name of the disk attached to the VM"
}

variable "user" {
    type = string
    default = "ubuntu"
    description = "Username to connect via SSH"
}

variable "ssh_key_pub_path" {
    type = string
    default = "~/yandex.pub"
    description = "Path to the public part of SSH-key"
}

variable "domain" {
    type = string
    default = "ydb-cluster.com."
    description = "Internal domain"
}

#=====Number vars========#
variable "static_node_vm_value" {
    type = number
    default = 9
    description = "Number of VMs being created"
}

variable "static_node_disk_per_vm" {
    type = number
    default = 1
    description = "Number of disks attached to the VM"
}

