resource "google_compute_address" "ip_ext" {
  name   = "node-1-ext-ip"
  region = var.input_region
}