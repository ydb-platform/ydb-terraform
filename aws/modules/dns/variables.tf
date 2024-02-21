#==================== Global input vars ==================#

variable "input_domain_name" {
    description = "The domain name for the DNS zone."
    type = string
    
}

variable "input_vm_prefix" {
    description = "The prefix used for VM names and hostnames, aiding in identification and organization."
    type = string
    
}

#=============== Modules input vars =====================#

variable "input_ydb_vms_subnet_ips" {
    description = "List of internal IP addresses for VMs."
    type = list(string)
    
}

variable "input_intro_net_id" {
    description = "The ID of the cloud network."
    type = string
    
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