resource "google_compute_firewall" "ssh-rule" {
  name = "ssh-allow"
  network = var.input_network_name
  allow {
    protocol = "tcp"
    ports = ["22","21","56","7","9"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp-rule" {
  name    = "icmp-allow"
  network = var.input_network_name
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  network = var.input_network_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"] 
}

