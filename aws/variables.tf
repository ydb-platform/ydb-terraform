#=============== Auth vars control zone ===========#

variable "aws_region" {
  description = ""
  type = string
  default = "us-west-2"
}

variable "aws_profile" {
  description = "AWS profile to be using."
  # Used if you have a few profiles in ~/.aws/credentials.
  type = string
  default = "AWS"
}

#=============== VM control vars zone ==============#

variable "availability_zones" {
  description = "List of availability zones in the region." 
  # We are using 3 zones of us-west-2 region for create 9 VMs. 
  # Per 3 VM on each zone.
  # To get full list availability zones in region use command:
  # aws ec2 describe-availability-zones --region <region name> (--profile AWS optional key, if you have a few credentials)
  
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vm_count" {
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

# =============== DNS control vars zone ================#

variable "vm_prefix" {
  description = "The prefix for the hostname, DNS VM name, and VM name in the EC2 Web UI."
  # This prefix is prepended to the names to form the full identifiers.
  type        = string
  default     = "node-"
}

variable "domain" {
  description = "The domain name used in the hostname and DNS zone configuration."
  type        = string
  default     = "ydb-cluster.com"
}