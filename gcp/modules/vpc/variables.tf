variable "auth_region" {
    description = "The GCP region where the infrastructure will be created."
    type        = string
}

variable "input_vpc_name" {
    description = "The GCP VPC name."
    type        = string
}

variable "input_subnet_count" {
    description = "The GCP subnet count."
    type        = number
}

variable "input_subnet_name" {
    description = "The GCP subnet name."
    type        = string
}