# ============== Local vars =====================#

#============ String ===========#
variable "static_node_vm_name" {
  type = string
  default = "ydb-static-node"
  description = ""
}

variable "static_node_hostname" {
  type = string
  default = "static-node"
  description = ""
}

variable "static_node_attache_disk_type" {
  type = string
  default = "network-ssd"
  description = "Type of the attached disk (network-ssd, network-hdd, network-ssd-nonreplicated, network-ssd-io-m3)"
}

variable "os_image_id" {
  type = string
  default = "fd8clogg1kull9084s9o"
  description = "Ubuntu 22.04 LTS image. Run `yc compute image list --folder-id standard-images` to get a list of available OS images."
}

#========= Number ===============#

variable "static_node_cores" {
  type = number
  default = 16
  description = ""
}

variable "static_node_memory" {
  type = number
  default = 16
  description = ""
}


variable "boot_disk_size" {
  type = number
  default = 40
  description = "Size of the attached disk, GB (min 1 GB, max 256 TB)"
}

#================= Transport vars =============#

variable "input_static_disks_ids" {
  description = "List of disk IDs for attaching to YDB VMs"
  type        = list(string)
}

variable "module_vps_platform" {
  type = string
  description = ""
}

variable "input_subnet_ids" {
  description = "List of subnet IDs to attach the VMs"
  type        = list(string)
}

variable "module_static_node_vm_value" {
  type = number
  description = ""
}


variable "module_domain" {
  type = string
  description = ""
}

variable "input_module_static_node_disk_per_vm" {
  type = number
  description = ""
}

variable "module_static_node_attache_disk_name" {
  type = string
  description = ""
}

variable "module_ssh_key_pub_path" {
  type = string
  description = ""
}

variable "module_user" {
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