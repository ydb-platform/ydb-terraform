variable "vpc_id" {
    description = "The ID of the VPC where your resources will be deployed."
    type = string
}

variable "allow_ports" {
    description = "A list of port numbers that are allowed through the security group associated with the instances."
    type = list(number)
}