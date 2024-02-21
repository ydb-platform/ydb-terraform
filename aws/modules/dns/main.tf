resource "aws_route53_zone" "ydb_cluster" {
  name = var.input_domain_name
  vpc {
    vpc_id = var.input_intro_net_id 
  }

  tags = {
    Name = var.input_domain_name
  }
}

resource "aws_route53_record" "instance_dns_records" {
  for_each = { for idx, ip in var.input_ydb_vms_subnet_ips : (idx + 1) => ip }

  zone_id = aws_route53_zone.ydb_cluster.zone_id
  name    = "${var.input_vm_prefix}${each.key}.${aws_route53_zone.ydb_cluster.name}"
  type    = "A"
  ttl     = "300"
  records = [each.value]
}