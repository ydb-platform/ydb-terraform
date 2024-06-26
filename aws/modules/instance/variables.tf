variable "input_security_group_id" {
    description = "The ID of the security group to be associated with the resources."
    type = string
    
}

variable "req_key_pair" {
    description = "The name of the required key pair for SSH access to the instances."
    type = string
    
}

variable "instance_count" {
    description = "The number of instances to be created."
    type = number
    
}


variable "input_subnet_ids" {
    description = "List of subnet IDs where the instances will be launched."
    type = list(string)
    
}

variable "input_domain_name" {
    description = "The domain name associated with the DNS zone."
    type = string
    
}

variable "input_vm_prefix" {
    description = "The prefix that will be used for naming VMs and their hostnames."
    type = string
}

variable "input_instance_ami" {
    description = "Main instance AMI"
    type = string
}

variable "input_instance_type" {
    description = "Instance type"
    type = string
}

variable "input_boot_disk_size" {
    description = "Size of boot disk"
    type = number
}

variable "input_boot_disk_type" {
    description = "Type of boot disk"
    type = string
}

variable "input_instance_name_prefix" {
    description = "Name prefix of instance"
    type = string
}