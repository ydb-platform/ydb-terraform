#============ String ===========#

variable "instance_count" {
  description = "Instance count"
  type = number
}

variable "instance_image_id" {
  description = "Ubuntu 22.04 LTS image. Run `yc compute image list --folder-id standard-images` to get a list of available OS images."
  type = string
  
}

variable "instance_platform" {
  description = "ID of instance platform"
  type = string
}

variable "instance_hostname" {
  description = "Instance hostname"
  type = string
}

variable "instance_cores" {
  description = "Number of vCPUs to be add."
  type = number
}

variable "instance_memory" {
  description = "Value of RAM instance."
  type = number
}

variable "boot_disk_size" {
  description = "Size of the attached disk, GB (min 1 GB, max 256 TB)"
  type = number
  default = 40
  
}

variable "instance_boot_disk_type" {
  description = "Type of disk instance attached."
  type = string
}

variable "map_sec_disks_names_ids" {
  description = "Map of secondary disks names and ids for attache to instance"
  type = map
}

variable "instance_data_disks_per_vm" {
  description = ""
  type = number
}

variable "instance_name" {
  description = "Instance name"
  type = string
}

#================= Transport vars =============#

variable "input_subnet_ids" {
  description = "List of subnet IDs to attach the VMs"
  type        = list(string)
}


variable "module_domain" {
  description = " YDB local DNS domain"
  type = string
  
}

variable "module_ssh_key_pub_path" {
  description = "Path to public SSH key"
  type = string
  
}

variable "module_user" {
  description = "User name for SSH connect"
  type = string
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

variable "auth_zone_name" {
    type = list
    description = "The name of the zone."
}
