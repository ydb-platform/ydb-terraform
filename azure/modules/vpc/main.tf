resource "azurerm_virtual_network" "main" {
  name                = var.input_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.auth_location
  resource_group_name = var.module_group_name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = var.module_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_public_ip" "pip" {
  name                = "ydb-pub-ip"
  resource_group_name = var.module_group_name
  location            = var.auth_location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = format("%s-%s", var.input_network_name, "interface")
  resource_group_name = var.module_group_name
  location            = var.auth_location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface" "internal" {
  name                = "ydb-int-inet"
  resource_group_name = var.module_group_name
  location            = var.auth_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "webserver" {
  name                = "tls_webserver"
  location            = var.auth_location
  resource_group_name = var.module_group_name
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "tls"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = azurerm_network_interface.main.private_ip_address
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.internal.id
  network_security_group_id = azurerm_network_security_group.webserver.id
}