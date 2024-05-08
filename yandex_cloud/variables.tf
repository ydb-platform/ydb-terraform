#=============== Auth vars control zone ===========#

variable "key_path" {
    description = "Path to the json file with service account credentials"
    type = string
    # default = "./prod.json"
}

variable "cloud_id" {
    description = "Yandex cloud ID"
    type = string
    # default = "<yandex_cloud_id>"
}

variable "profile" {
    description = "Profile section"
    type = string
    default = "Yandex"
    
}

variable "folder_id" {
    description = "Yandex folder ID"
    type = string
    # default = "<yandex_folder_id>"
}

variable "zone_name" {
    description = "Names of availability zones to use"
    type = list(string)
    default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
    
}


#=============== VM control vars zone ==============#

variable "instance_count" {
    type = number
    default = 3
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
  description = "Number of vCPU per instance"
}

variable "instance_memory" {
  type = number
  default = 16
  description = "GB of RAM per instance"
}


variable "instance_name" {
  type = string
  default = "static-node"
  description = "Prefix for node names"
}

variable "instance_hostname" {
  type = string
  default = "static-node"
  description = "Prefix for node hostnames"
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
    description = "Path to the public part of SSH-key"
    # default = "~/<path_to_ssh_key>.pub"
}

#=============== Disk control vars zone ==============#

#========== Instance boot disk =======#

variable "instance_boot_disk_size" {
    type = number
    default = 80
    description = "VM boot disk size in GB"
}

variable "instance_boot_disk_type" {
    type = string
    default = "network-ssd"
    description = "VM boot disk type"
}

#========== Instance data disks =======#

variable "instance_data_disks_per_vm" {
    type = number
    default = 3
    description = "Number of data disks attached to each VM"
}

variable "instance_data_disk_size" {
    type = number
    default = 186
    description = "Size of each data disk in GB"
}

variable "instance_data_disk_type" {
    type = string
    default = "network-ssd-nonreplicated"
    description = "Type of each data disk"
}




#=============== DNS control vars zone ================#

variable "domain" {
    type = string
    default = "ydb-cluster.com."
    description = "Internal domain"
}




