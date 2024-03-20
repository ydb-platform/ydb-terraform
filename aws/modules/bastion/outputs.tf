output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
  description = "Bastion private IP address"
}