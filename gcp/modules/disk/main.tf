resource "google_compute_disk" "ydb-attach-disk" {
  count = var.input_vm_count  
  name  = format("%s-%d", "ydb-disk", count.index+1) 
  type  = "pd-ssd"
  zone  = var.input_zones[count.index % length(var.input_zones)]
  size  = 20
  physical_block_size_bytes = 4096
}