#============== Create NET disks for static nodes =========#

resource "yandex_compute_disk" "data-disk" {
  count = var.instance_data_disks_per_vm * var.instance_count
  name = "${var.instance_name}-${1 + floor(count.index / var.instance_data_disks_per_vm)}-disk-${1 + (count.index % var.instance_data_disks_per_vm)}"
  size = var.instance_data_disk_size
  type = var.instance_data_disk_type
  zone = element(var.zone_name, floor(count.index / var.instance_data_disks_per_vm) % length(var.zone_name))
}
