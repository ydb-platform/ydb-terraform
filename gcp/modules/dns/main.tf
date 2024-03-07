resource "google_dns_managed_zone" "ydb-cluster" {
  name = "ydb-cluster"
  dns_name = var.input_domain
  description = "ydb-cluster domain zone"
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/${var.input_project}/global/networks/${var.input_network_name}"
    }
  }
}


resource "google_dns_record_set" "host-a" {
  for_each = var.input_vm_name_internal_ip

  name         = "${each.key}.${google_dns_managed_zone.ydb-cluster.dns_name}"
  managed_zone = google_dns_managed_zone.ydb-cluster.name
  type         = "A"
  ttl          = 300

  rrdatas      = [each.value]
}
