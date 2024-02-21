#==================== Auth vars =========================#

variable "auth_aws_region" {
    description = "The AWS region where the resources will be deployed."
    type = string
}

variable "auth_aws_profile" {
    description = "The AWS profile to use for authentication."
    type = string
}