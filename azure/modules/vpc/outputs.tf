output "network_interface_main" {
    value = azurerm_network_interface.main.id
}

output "network_interface_int" {
    value = azurerm_network_interface.internal.id
}