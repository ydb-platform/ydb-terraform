resource "azurerm_virtual_network" "main" {
  name                = var.input_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.auth_location
  resource_group_name = var.module_group_name
}

resource "azurerm_subnet" "internal" {
  count                = var.input_subnets_count
  name                 = "internal-${count.index + 1}"
  resource_group_name  = var.module_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}

resource "azurerm_public_ip" "pip" {
  count               = var.input_subnets_count
  name                = "pub-ip-${count.index + 1}"
  resource_group_name = var.module_group_name
  location            = var.auth_location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  count               = var.input_network_interface_count
  name                = "ydb-nic${count.index + 1}"
  resource_group_name = var.module_group_name
  location            = var.auth_location

  ip_configuration {
    name                          = "ipconfig${count.index + 1}"
    subnet_id                     = azurerm_subnet.internal[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  count                   = var.input_network_interface_count
  network_interface_id    = azurerm_network_interface.main[count.index].id
  network_security_group_id = var.module_network_security_group_id
}