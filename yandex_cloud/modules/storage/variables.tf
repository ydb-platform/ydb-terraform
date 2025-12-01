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