variable "input_vpc_id" {
    description = "ID of VPC"
    type = string
}

variable "input_nat_id" {
    description = "ID of NAT"
    type = string
}

variable "input_subnets_count" {
    description = "Count of subnets."
    type = number
}

variable "input_subnets_ids" {
    description = "IDs of subnets."
    type = list(string)
}

variable "input_igw_id" {
    description = "ID of IGW"
    type = string
}

variable "input_pub_subnet_id" {
    description = "ID of IGW"
    type = string
}