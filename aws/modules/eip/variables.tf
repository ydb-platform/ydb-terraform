#============== Global input vars ===========#

variable "instance_count" {
    description = "The number of VMs to create."
    type = number
}

variable "vm_ids" {
    description = "List of VM IDs, received from the instance module."
    type = list(string)
    
}

#============== Modules input vars ====================#

variable "input_vpc_id" {
    description = "The ID of the network, received from the VPC module."
    type = string
    
}

variable "input_subnets_ids" {
    description = "List of subnet IDs from the network, received from the VPC module."
    type = list(string)
}


#==================== Auth vars =========================#

variable "auth_aws_region" {
    description = "The AWS region where the resources will be deployed."
    type = string
}

variable "auth_aws_profile" {
    description = "The AWS profile to use for authentication."
    type = string
}