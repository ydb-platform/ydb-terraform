resource "azurerm_linux_virtual_machine" "main" {
  count = var.input_vm_count
  name                = format("%s-%d", var.input_vm_name, count.index + 1)
  resource_group_name = var.module_group_name
  location            = var.auth_location
  size                = var.input_vm_size
  admin_username      = var.input_user
  
  network_interface_ids = [element(var.module_network_interface_ids, count.index)]
  

  admin_ssh_key {
    username   = var.input_user
    public_key = file(var.input_ssh_keys)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}