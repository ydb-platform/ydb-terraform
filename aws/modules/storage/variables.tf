variable "instance_count" {
    description = "Instance count"
    type = number
}

variable "input_ebs_attached_disk_size" {
    description = "Size of first EBS volume"
    type = number
}

variable "input_ebs_attached_disk_type" {
    description = "Type of first EBS volume"
    type = string
}

variable "input_instance_name_prefix" {
    description = "Name prefix of instance"
    type = string
}

variable "input_availability_zones" {
    description = "List of availability zones"
    type = list(string)
}