#=============== Auth vars control zone ===========#

variable "project" {
  description = "The name of the GCP project."
  type        = string
  #default    = "<project name>"
}

variable "region" {
  description = "The GCP region where the infrastructure will be created."
  #Use the command `./gcloud compute regions list` to list available regions.
  type         = string
  #default     = "<region>"
}

variable "zones" {
  description = "List of GCP zones within the specified region that are allowed for deployment."
  #Use the command `./gcloud compute zones list | grep <region-name>` to list available zones in a region. Replace <region-name> with the actual name of your region, such as 'us-east1'."
  type        = list(string)
  #default    = [<zone name>, ... ]
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
    # Use command `./gcloud compute images list --filter="family:ubuntu"` to take list of Ubuntu images.
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
    #default = "<path to SSH pub key>"
}


#=============== DNS control vars zone ================#

variable "domain" {
    type = string
    default = "ydb-cluster.com."
    description = "Internal domain"
}