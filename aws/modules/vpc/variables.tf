variable "subnets_count" {
    description = "The number of subnets to be created within the VPC."
    type = number
}

variable "subnets_availability_zones" {
    description = "A list of availability zones where the subnets will be created."
    type = list
}