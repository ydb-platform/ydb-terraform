variable "instance_count" {
    description = "Instance count"
    type = number
}

variable "input_first_ebs_name" {
    description = "Name of first EBS volume"
    type = string
}

variable "input_first_ebs_size" {
    description = "Size of first EBS volume"
    type = number
}

variable "input_availability_zones" {
    description = "List of availability zones"
    type = list(string)
}

variable "input_first_ebs_type" {
    description = "Type of first EBS volume"
    type = string
}

variable "input_sec_attached_disk" {
    description = "Logical variable controlling the addition of a secondary EBS volume"
    type = bool
}


variable "input_sec_ebs_name" {
    description = "Name of secondary EBS volume"
    type = string
}

variable "input_sec_ebs_type" {
    description = "Type of secondary EBS volume"
    type = string
}

variable "input_sec_ebs_size" {
    description = "Size of secondary EBS volume"
    type = number
}

variable "input_instance_name_prefix" {
    description = "Name prefix of instance"
    type = string
}