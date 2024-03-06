output "vm_name_internal_ip" {
  value = {
    for i, name in google_compute_instance.ydb-node.*.name : 
      name => google_compute_instance.ydb-node.*.network_interface.0.network_ip[i]
  }
  description = "Map of VM names to their internal IP addresses"
}
