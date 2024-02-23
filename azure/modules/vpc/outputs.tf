output "network_interface_main_ids" {
  value = azurerm_network_interface.main.*.id
}