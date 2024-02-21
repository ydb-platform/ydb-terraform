variable "subnets_count" {
    description = "The number of subnets to be created within the VPC."
    type = number
}

variable "subnets_availability_zones" {
    description = "A list of availability zones where the subnets will be created."
    type = list
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