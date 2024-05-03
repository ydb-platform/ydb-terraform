output "map_sec_disks_names_ids" {
  description = "Map of secondarys disk IDs to their respective zones for YDB static disks"

  value = {
    for disk in yandex_compute_disk.data-disk :
    disk.name => disk.id
  }
}
