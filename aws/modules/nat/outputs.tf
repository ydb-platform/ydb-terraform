output "nats_ids" {
    value = aws_nat_gateway.ydb-pub-nat.*.id
}