resource "google_compute_network" "vpc_network" {
  name                    = var.input_vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnet" {
  count         = var.input_subnet_count
  name          = format("%s-%d", var.input_subnet_name, count.index +1)
  ip_cidr_range = "10.0.${count.index +1}.0/24"
  region        = var.auth_region
  network       = google_compute_network.vpc_network.id
}