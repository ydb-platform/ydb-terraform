variable "input_bastion_instance_type" {
    description = "Instance type of bastion host"
    type = string
}

variable "input_key_pair" {
    description = "SSH key pair"
    type = string
}

variable "input_public_subnet_id" {
    description = "List of public subnets ids"
    type = string
}

variable "input_domain_name" {
    description = "DNS domain name"
    type = string
}

variable "input_bastion_host_name" {
    description = "Name of bastion host"
    type = string
}

variable "input_security_group_id" {
    description = "List of IDs of security groups"
    type = string
}

variable "input_bastion_ami_id" {
    description = "ID bastion ami"
    type = string
}