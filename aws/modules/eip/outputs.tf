output "eips_ids" {
    value = aws_eip.nat_eip.*.id
}