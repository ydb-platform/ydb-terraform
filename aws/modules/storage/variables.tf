variable "instance_count" {
    description = ""
    type = number
}

variable "input_first_ebs_name" {
    description = ""
    type = string
}

variable "input_first_ebs_size" {
    description = ""
    type = number
}

variable "input_availability_zones" {
    description = ""
    type = list(string)
}

variable "input_first_ebs_type" {
    description = ""
    type = string
}

variable "input_sec_attached_disk" {
    description = ""
    type = bool
}


variable "input_sec_ebs_name" {
    description = ""
    type = string
}

variable "input_sec_ebs_type" {
    description = "Type of ebs"
    type = string
}

variable "input_sec_ebs_size" {
    description = "Size of ebs"
    type = number
}

variable "input_instance_name_prefix" {
    description = ""
    type = string
}