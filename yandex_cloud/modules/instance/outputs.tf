output "instances_fqdn" {
    description = "List of YDB nodes hostnames."
    value = yandex_compute_instance.ydb-static-nodes.*.fqdn
}