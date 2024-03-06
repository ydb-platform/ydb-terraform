#========== Auth =========#
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}


#========= VPC ============#
# Create Virtual Cloud NET and subnets.

module "vpc" {
  source = "./modules/vpc"

  # Global input data 
  subnets_count = var.subnets_count
  subnets_availability_zones = var.availability_zones
}


#============ Key pair ==========#  
# Create SSH key pair for SSH and Ansible access.

module "key_pair" {
  source = "./modules/key_pair/"
}


#======== Security =============#
# Create security groups, ingress and egress rules.

module "security" {
  source = "./modules/security/"
  
  # Global input data
  allow_ports = var.allow_ports_list

  # Modules input data
  ydb-intro-net-id = module.vpc.vpc_id
}

#=========== Instance ===========#
# Create EC2 instances with attached SSD disks.

module "instance" {
  source = "./modules/instance/"

  # Global input data
  instance_count = var.vm_count
  input_domain_name = var.domain
  input_vm_prefix = var.vm_prefix

  # Modules input data
  input_security_group_id = module.security.sec_out
  req_key_pair = module.key_pair.key_name
  input_subnet_ids = module.vpc.subnet_ids
}

#============== IEP ===================#
# Set up internet gateways by aws_internet_gateway.

module "eip" {
  source = "./modules/eip"

  # Global input data
  vm_ids = module.instance.ydb_vm_ids
  instance_count = var.vm_count
  
  # Modules input data 
  input_subnets_ids = module.vpc.subnet_ids
  input_vpc_id = module.vpc.vpc_id
}

#=============== DNS ==================#
# Create a DNS private zone by Route53.

module "dns" {
  source = "./modules/dns"

  # Global input data
  input_domain_name = var.domain
  input_vm_prefix = var.vm_prefix

  # Modules input data
  input_intro_net_id = module.vpc.vpc_id
  input_ydb_vms_subnet_ips = module.instance.instance_private_ips
}