output "fqdn_list" {
  value = [for dns_record in google_dns_record_set.host-a : dns_record.name]
  description = "List of FQDNs for the YDB cluster"
}
