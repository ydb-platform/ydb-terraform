#=============== Auth vars control zone ===========#

variable "aws_region" {
  description = "AWS region to use"
  type = string
  #default = "<region name>"
}

variable "aws_profile" {
  description = "AWS profile to use if you have multiple defined in ~/.aws/credentials."
  type = string
  default = "AWS"
}

#=============== VM control vars zone ==============#

variable "vm_count" {
  description = "The number of VMs to be created."
  type        = number
  default     = 4
}

variable "availability_zones" {
  description = "List of availability zones in the region." 
  # We are using 3 availability zones to create 3 VMs per zone, 9 VMs total.
  # To get the full list availability zones in a region use:
  # aws ec2 describe-availability-zones --region <region name> 
  
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}


#============== NETS control vars zone ===============#

variable "subnets_count" {
  description = "The number of VMs to be created."
  type        = number
  default     = 3
}

#============== Security control vars zone ===========#

variable "allow_ports_list" {
  description = "List of ports allowed through the firewall."
  # The ICMP protocol is allowed by default in the security module.
  type        = list(number)
  default     = [21, 22]
}

#=============== DNS control vars zone ================#

variable "vm_prefix" {
  description = "The prefix for the hostname, DNS VM name, and VM name in the EC2 Web UI."
  # This prefix is prepended to the names to form the full identifiers.
  type        = string
  default     = "static-node-"
}

variable "domain" {
  description = "The domain name used in the hostname and DNS zone configuration."
  type        = string
  default     = "ydb-cluster.com"
}