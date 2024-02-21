variable "ydb-intro-net-id" {
    description = "The ID of the VPC where your resources will be deployed."
    type = string
}

variable "allow_ports" {
    description = "A list of port numbers that are allowed through the security group associated with the instances."
    type = list(number)
}

#==================== Auth vars =========================#

variable "auth_aws_region" {
    description = "The AWS region where the resources will be deployed."
    type = string
}

variable "auth_aws_profile" {
    description = "The AWS profile to use for authentication."
    type = string
}