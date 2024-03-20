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

variable "input_bastion_ip" {
    description = "IP of bastion host"
    type = string
}

variable "input_bastion_prefix" {
    description = "Prefix name of bastion host"
    type = string
}