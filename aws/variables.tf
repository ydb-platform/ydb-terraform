#=============== Auth vars control zone ===========#

variable "aws_region" {
  description = "AWS region to use"
  type = string
  #default = "<region name>"
}

variable "aws_profile" {
  description = "AWS profile to use if you have multiple defined in ~/.aws/credentials."
  type = string
  #default = "<AWS_profile>"
}

#=============== VM control vars zone ==============#

variable "vm_count" {
  description = "The number of VMs to be created."
  type        = number
  default     = 9
}

variable "availability_zones" {
  description = "List of availability zones in the region." 
  # We are using 3 availability zones to create 3 VMs per zone, 9 VMs total.
  # To get the full list availability zones in a region use:
  # aws ec2 describe-availability-zones --region <region name> 
  
  type        = list(string)
  default     = ["us-east-1c", "us-east-1b", "us-east-1f"]
}


variable "bastion_instance_ami" {
  description = "Bastion instance Ami ID"
  type = string
  default = "ami-080e1f13689e07408"
}

variable "instance_ami" {
  description = "Instance Ami ID"
  type = string
  default = "ami-080e1f13689e07408"
}

variable "instance_type" {
  description = "Instance type"
  default     = "c7a.4xlarge" # 16 vCPU, 16 GB RAM, x86
  type        = string 
}

variable "bastion_hostname_prefix" {
  description = "Bastion hostname prefix"
  type = string
  default = "bastion"
}

variable "bastion_instance_type" {
  description = "Bastion instance type"
  default     = "t3a.medium" # t3a.medium – 2 vCPU, 4 GB RAM
  type        = string
  
}

variable "ebs_name" {
  description = "Name of ebs_block_device"
  type = string
  default = "/dev/sdh"
}

variable "ebs_type" {
  description = "Type of ebs_block_device"
  type = string
  default = "gp2"
}

variable "ebs_size" {
  description = "Size of ebs_block_device"
  default     = 200 # The min size of ebs is 200 GB.
  type        = number
   
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
  # YDB IC, gRPC and mon ports are allowed too.
  
  type        = list(number)
  default     = [21, 22] # Do not include YDB range ports. All ports are added in the security module.
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