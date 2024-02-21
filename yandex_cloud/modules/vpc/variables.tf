#============= Auth vars =====================#

variable "auth_key_path" {
    type = string
    description = "Set the JSON SA key file"
}

variable "auth_cloud_id" {
    type = string
    description = "Yandex WEB GUI Cloud"
}

variable "auth_profile" {
    type = string
    description = "Profile section from"
}

variable "auth_folder_id" {
    type = string
    description = ""
}

variable "auth_zone_name" {
    type = list
    description = "The name of the zone."
}