output "map_first_disks_names_ids" {
  description = "Map of firsts disk IDs to their respective zones for YDB static disks"

  value = {
    for disk in yandex_compute_disk.first-attached-disk :
    disk.name => disk.id
  }
}

output "map_sec_disks_names_ids" {
  description = "Map of secondarys disk IDs to their respective zones for YDB static disks"

  value = {
    for disk in yandex_compute_disk.second-attached-disk :
    disk.name => disk.id
  }
}
