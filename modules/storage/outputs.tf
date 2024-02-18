output "ydb_static_disks_ids" {
  value = [for disk in yandex_compute_disk.ydb-static-disks : disk.id]
  description = "List of IDs for YDB static disks"
}