#============== Create NET disks for static nodes =========#
resource "yandex_compute_disk" "first-attached-disk" {
  count = var.instance_count
  name = "${var.instance_name}-${count.index + 1}-1"
  size = var.instance_first_attached_disk_size
  type = var.instance_first_attached_disk_type
  zone = element(var.zone_name, count.index % length(var.zone_name))
}


resource "yandex_compute_disk" "second-attached-disk" {
  count = var.sec_instance_attached_disk == true ? var.instance_count : 0
  name = "${var.instance_name}-${count.index + 1}-2"
  size = var.instance_sec_attached_disk_size
  type = var.instance_sec_attached_disk_type
  zone = element(var.zone_name, count.index % length(var.zone_name))

  depends_on = [yandex_compute_disk.first-attached-disk]
}