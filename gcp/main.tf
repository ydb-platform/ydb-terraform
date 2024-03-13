provider "google" {
  project     = var.project
  region      = var.region
}

module "vpc" {
    source = "./modules/vpc"
    input_vpc_name = var.vpc_name
    input_subnet_count = var.subnet_count
    input_subnet_name = var.subnet_name

    #auth
    auth_region = var.region
}

module "disks" {
    source = "./modules/disk"
    input_zones = var.zones
    input_vm_count = var.vm_count
}

module "eip" {
    source = "./modules/eip"
    input_project = var.project
    input_region = var.region
}

module "security" {
    source = "./modules/security"
    input_network_name = var.vpc_name
    depends_on = [module.vpc]
}

module "instance" {
    source = "./modules/instance"

    input_vm_count = var.vm_count
    input_vm_name = var.vm_name
    input_vm_size = var.vm_size
    input_zones = var.zones
    input_subnets_ids = module.vpc.subnets_ids
    input_bootdisk_image = var.bootdisk_image
    input_user = var.user
    input_ssh_key_pub_path = var.ssh_key_pub_path
    input_attached_disks_names = module.disks.attached_disks_names
    input_public_ip = module.eip.public_ip
    input_network_name = var.vpc_name
    input_domain = var.domain
}

module "dns" {
    depends_on = [module.vpc, module.instance]
    source = "./modules/dns"
    input_domain = var.domain
    input_network_name = var.vpc_name
    input_vm_name_internal_ip = module.instance.vm_name_internal_ip
    input_project = var.project
}

resource "local_file" "export_fqdn_list" {
  content = join("\n", [for fqdn in module.dns.fqdn_list : "${element(split(".", fqdn), 0)}    ${fqdn}"])
  filename = "${path.module}/fqdn_list.txt"
}

