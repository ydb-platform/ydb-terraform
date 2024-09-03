terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.auth_key_path
  cloud_id                 = var.auth_cloud_id
  folder_id                = var.auth_folder_id
  zone                     = var.auth_zone_name[0]
}