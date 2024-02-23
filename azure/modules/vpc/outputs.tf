output "network_interface_main_ids" {
  value = azurerm_network_interface.main.*.id
}

output "virtual_network_main_id" {
  value = azurerm_virtual_network.main.id
}

output "vm_private_ips" {
  value = [for nic in azurerm_network_interface.main : nic.ip_configuration[0].private_ip_address]
  description = "List of private IP addresses for the VMs"
}


output "nat_private_ip_first_vm" {
  value = azurerm_network_interface.main[0].ip_configuration[0].private_ip_address
}