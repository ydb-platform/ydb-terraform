output "subnets_ids" {
    value = google_compute_subnetwork.subnet.*.id
}