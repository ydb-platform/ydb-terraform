#=============== Auth vars control zone ===========#

variable "key_path" {
    description = "Path to the json file with service account credentials"
    type = string
    #default = "./prod.json"
    
}

variable "cloud_id" {
    description = "Yandex Cloud ID"
    type = string
    #default = "<yandex cloud ID >" 
    
}

variable "profile" {
    description = "Profile section from"
    type = string
    default = "Yandex"
    
}

variable "folder_id" {
    description = "Yandex folder ID"
    type = string
    #default = "<yandex cloud folder ID>"
}

variable "zone_name" {
    description = "Names of availability zones to use"
    type = list(string)
    default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
    
}


#=============== VM control vars zone ==============#

variable "instance_count" {
    type = number
    default = 9
    description = "Number of VMs being created"
}

variable "instance_platform" {
    type = string
    default = "standard-v3"
    description = "standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake"
}

variable "instance_cores" {
  type = number
  default = 16
  description = ""
}

variable "instance_memory" {
  type = number
  default = 16
  description = ""
}


variable "instance_name" {
  type = string
  default = "static-node"
  description = ""
}

variable "instance_hostname" {
  type = string
  default = "static-node"
  description = ""
}

variable "instance_image_id" {
  type = string
  default = "fd8clogg1kull9084s9o"
  description = "Ubuntu 22.04 LTS image. Run `yc compute image list --folder-id standard-images` to get a list of available OS images."
}

variable "user" {
    type = string
    default = "ubuntu"
    description = "Username to connect via SSH"
}

variable "ssh_key_pub_path" {
    type = string
    #default = "<path to SSH pub>"
    description = "Path to the public part of SSH-key"
}

#=============== Disk control vars zone ==============#

#========== First attached instance disk =======#

variable "instance_first_attached_disk_size" {
    type = number
    default = 250
    description = ""
}

variable "instance_first_attached_disk_type" {
    type = string
    default = "network-ssd"
    description = ""
}

#========== Second attached instance disk =======#

variable "sec_instance_attached_disk" {
    description = "Variable to determine if a secondary disk is attached."
    type = bool
    default = false
}

variable "instance_sec_attached_disk_size" {
    type = number
    default = 50
    description = ""
}

variable "instance_sec_attached_disk_type" {
    type = string
    default = "network-ssd"
    description = ""
}




#=============== DNS control vars zone ================#

variable "domain" {
    type = string
    default = "ydb-cluster.com."
    description = "Internal domain"
}




