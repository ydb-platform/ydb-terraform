variable "input_map_first_ebs_name_id" {
    description = "Map of names and ids EBS volumes"
    type = map
}

variable "input_map_sec_ebs_name_id" {
    description = "Map of names and ids EBS volumes"
    type = map
}

variable "input_map_third_ebs_name_id" {
    description = "Map of names and ids EBS volumes"
    type = map
}

variable "input_map_instance_name_id" {
    description = "Map of names and ids instances"
    type = map
}


variable "input_first_ebs_name" {
    description = "First EBS device name"
    type = string
}

variable "input_sec_ebs_name" {
    description = "Secondary EBS device name"
    type = string
}

variable "input_third_ebs_name" {
    description = "Third EBS device name"
    type = string
}