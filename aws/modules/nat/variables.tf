variable "input_eips_ids" {
    description = "EIP ID"
    type = list(string)
}

variable "input_public_subnets_ids" {
    description = "ID of public subnet"
    type = list(string)
}