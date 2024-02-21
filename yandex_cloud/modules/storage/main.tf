#============== Create NET disks for static nodes =========#
resource "yandex_compute_disk" "ydb-static-disks" {
  count = var.module_static_node_vm_value * var.module_static_node_disk_per_vm 
  name = "${var.module_static_node_attached_disk_name}-${count.index + 1}"
  size = var.static_node_storage_size
  type = var.static_node_attache_disk_type
  zone = element(var.module_zone_name, count.index % length(var.module_zone_name))
}