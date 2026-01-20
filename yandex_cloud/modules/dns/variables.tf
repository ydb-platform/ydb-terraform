#========== Local vars ===========#
variable "dns_name" {
    type = string
    default = "ydb-cluster"
    description = ""
}

#=========== Transport vars =======#
variable "input_net_id" {
    type = string
    description = ""
}

variable "module_domain" {
    type = string
    description = ""
}

#============= Auth vars =====================#

variable "auth_zone_name" {
    type = list
    description = "The name of the zone."
}