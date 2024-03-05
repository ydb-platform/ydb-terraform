resource "azurerm_resource_group" "ydb-test-group" {
  name     = var.auth_resource_group_name
  location = var.auth_location
}