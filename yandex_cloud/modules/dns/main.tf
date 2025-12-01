#============== Create DNS private zone ================
resource "yandex_dns_zone" "ydb-cluster-dns-private" {
  name             = var.dns_name
  zone             = var.module_domain
  public           = false
  private_networks = [var.input_net_id]
}