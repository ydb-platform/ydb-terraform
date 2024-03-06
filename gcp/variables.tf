#=============== Auth vars control zone ===========#

variable "project" {
  description = "The name of the GCP project."
  type        = string
  default     = "ydb-terraform"
}

variable "region" {
  description = "The GCP region where the infrastructure will be created."
  type        = string
  default     = "us-east1"
}

variable "zones" {
  description = "Allow GCP zones by region."
  # Use command `./gcloud compute zones list | grep <region name>` to take a allow zones.
  type        = list(string)
  default     = ["us-east1-b", "us-east1-c", "us-east1-d" ]
}

#============== NETS control vars zone ===============#

variable "vpc_name" {
    description = "The GCP VPC name."
    type        = string
    default     = "ydb-vpc"
}

variable "subnet_count" {
    description = "The GCP subnet count."
    type        = number
    default     = 3
}

variable "subnet_name" {
    description = "The GCP subnet name."
    type        = string
    default     = "ydb-inner"
}

#=============== VM control vars zone ==============#

variable "vm_count" {
  description = "The number of virtual machines to create."
  type        = number
  default     = 4
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default     = "ydb-node"
}

variable "vm_size" {
  description = "The size specification of the virtual machine based on the required resources."
  # Use command `./gcloud compute machine-types list --filter="zone:( us-east1-b us-east1-c us-east1-d)"` 
  # to get list of  
  type        = string
  default     = "e2-small"
}

variable "bootdisk_image" {
    description = "Bootdisk image"
    # Use command `./gcloud compute images list --filter="family:ubuntu-minimal-2204-lts"` to take list of Ubuntu images.
    type = string
    default = "ubuntu-minimal-2204-jammy-v20240229"
}


variable "user" {
    description = "SSH user."
    type = string
    default = "ubuntu"
}

variable "ssh_key_pub_path" {
    description = "Path to public SSH key."
    type = string
    default = "~/yandex.pub"
}


#=============== DNS control vars zone ================#

variable "domain" {
    type = string
    default = "ydb-cluster.com."
    description = "Internal domain"
}