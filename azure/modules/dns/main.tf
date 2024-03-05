resource "azurerm_private_dns_zone" "ydb_cluster_com" {
  name                = var.input_domain
  resource_group_name = var.module_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "link-ydb-network"
  resource_group_name   = var.module_group_name
  private_dns_zone_name = azurerm_private_dns_zone.ydb_cluster_com.name
  virtual_network_id    = var.module_virtual_network_main_id
}

resource "azurerm_private_dns_a_record" "vm" {
  count               = var.input_vm_count
  name                = format("%s-%d.%s", var.input_vm_name, count.index + 1, var.input_domain)
  zone_name           = azurerm_private_dns_zone.ydb_cluster_com.name
  resource_group_name = var.module_group_name
  ttl                 = 300
  records             = [element(var.module_vm_private_ips, count.index)]
}