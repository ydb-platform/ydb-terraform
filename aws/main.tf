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
  
  allow_ports = var.allow_ports_list
  input_instance_value = var.vm_count
  vpc_id = module.vpc.vpc_id
}

#=========== Instance ===========#
# Create EC2 instances with attached SSD disks.

module "instance" {
  source = "./modules/instance/"

  instance_count = var.prod ? var.vm_count : var.testing_instance_count
  input_domain_name = var.domain
  input_vm_prefix = var.vm_prefix

  input_instance_ami = var.instance_ami
  input_instance_type = var.prod ? var.instance_type : var.testing_instance

  input_security_group_id = module.security.sec_out
  req_key_pair = module.key_pair.key_name
  input_subnet_ids = module.vpc.private_subnets_ids

  input_ebs_name = var.ebs_name
  input_ebs_type = var.ebs_type
  input_ebs_size = var.prod ? var.ebs_size : var.testing_instance_ebs_size
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
  input_eips_ids = module.eip.eips_ids
  input_public_subnets_ids = module.vpc.public_subnets_ids
}

#============ Route ====================#
module "route" {
  source = "./modules/route"
  input_vpc_id = module.vpc.vpc_id
  input_subnets_count = var.subnets_count
  input_private_subnets_ids = module.vpc.private_subnets_ids
  input_igw_id = module.igw.igw_id
  input_pub_subnets_ids = module.vpc.public_subnets_ids
  input_nats_ids = module.nat.nats_ids
}


#============== Bastion ================#
module "bastion" {
  source                       = "./modules/bastion"
  input_public_subnet_id       = module.vpc.public_subnets_ids[0]
  input_key_pair               = module.key_pair.key_name
  input_bastion_instance_type  = var.prod ? var.bastion_instance_type : var.testing_instance_bastion
  input_security_group_id      = module.security.sec_out
  input_bastion_host_name      = var.bastion_hostname_prefix
  input_domain_name            = var.domain
  input_bastion_ami_id         = var.bastion_instance_ami
}

#=============== DNS ==================#
# Create a DNS private zone by Route53.

module "dns" {
  source                   = "./modules/dns"
  input_domain_name        = var.domain
  input_vm_prefix          = var.vm_prefix
  input_intro_net_id       = module.vpc.vpc_id
  input_ydb_vms_subnet_ips = module.instance.instance_private_ips
  input_bastion_ip         = module.bastion.bastion_private_ip
  input_bastion_prefix     = var.bastion_hostname_prefix
}