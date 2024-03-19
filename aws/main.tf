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
  vpc_id = module.vpc.vpc_id
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
  input_subnet_ids = module.vpc.subnets_ids
}

#============== IEP ===================#
# Set up internet gateways by aws_internet_gateway.

module "eip" {
  source = "./modules/eip"
  input_vpc_id = module.vpc.vpc_id
  input_node_1_id = module.instance.ydb_vm_ids[0]
}

# =========== IGW ==================#
module "igw" {
  source = "./modules/igw"
  input_vpc_id = module.vpc.vpc_id
}

#============ NAT ==================#

module "nat" {
  source = "./modules/nat"
  input_eip_id = module.eip.eip_id
  input_pub_subnet_id = module.vpc.pub_subnet_id
}

#============ Route ====================#
module "route" {
  source = "./modules/route"
  input_vpc_id = module.vpc.vpc_id
  input_nat_id = module.nat.nat_id
  input_subnets_count = var.subnets_count
  input_subnets_ids = module.vpc.subnets_ids
  input_igw_id = module.igw.igw_id
  input_pub_subnet_id = module.vpc.pub_subnet_id
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