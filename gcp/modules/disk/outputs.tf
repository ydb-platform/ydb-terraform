output "attached_disks_names" {
    value = google_compute_disk.ydb-attach-disk.*.name
}