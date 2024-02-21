#======== Local vars ===========#

variable "static_node_storage_size" {
    type = number
    default = 200
    description = ""
}

variable "static_node_attache_disk_type" {
    type = string
    default = "network-ssd"
    description = ""
}

#========= Transport vars ==========#

variable "module_static_node_attached_disk_name" {
  type        = string
  description = "ydb-disk"
}

variable "module_static_node_disk_per_vm" {
    type = number
    description = ""
}

variable "module_zone_name" {
    type = list
    description = ""
}

variable "module_static_node_vm_value" {
    type = number
    description = ""
}


#============= Auth vars =====================#

variable "auth_key_path" {
    type = string
    description = "Set the JSON SA key file"
}

variable "auth_cloud_id" {
    type = string
    description = "Yandex WEB GUI Cloud"
}

variable "auth_profile" {
    type = string
    description = "Profile section from"
}

variable "auth_folder_id" {
    type = string
    description = ""
}

variable "auth_zone_name" {
    type = list
    description = "The name of the zone."
}
