variable "input_vpc_id" {
    description = "ID of VPC"
    type = string
}

variable "input_subnets_count" {
    description = "Count of subnets."
    type = number
}

variable "input_igw_id" {
    description = "ID of IGW"
    type = string
}

variable "input_nats_ids" {
    description = "ID of IGW"
    type = list(string)
}

variable "input_private_subnets_ids" {
    description = "IDs of subnets."
    type = list(string)
}

variable "input_pub_subnets_ids" {
    description = "ID of IGW"
    type = list(string)
}