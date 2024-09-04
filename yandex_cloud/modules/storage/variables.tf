#======== Local vars ===========#

variable "instance_boot_disk_size" {
    type = number
    description = ""
}

variable "instance_boot_disk_type" {
    type = string
    description = ""
}

variable "instance_data_disks_per_vm" {
    type = number
    description = ""
}

variable "instance_data_disk_size" {
    type = number
    description = ""
}

variable "instance_data_disk_type" {
    type = string
    description = ""
}

#========= Transport vars ==========#


variable "zone_name" {
    type = list
    description = ""
}

variable "instance_count" {
    type = number
    description = ""
}

variable "instance_name" {
  type = string
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

variable "auth_folder_id" {
    type = string
    description = ""
}
