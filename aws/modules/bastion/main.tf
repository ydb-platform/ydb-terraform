resource "aws_instance" "bastion" {
  ami           = var.input_bastion_ami_id
  instance_type = var.input_bastion_instance_type
  key_name      = var.input_key_pair
  vpc_security_group_ids = [var.input_security_group_id]
  subnet_id     = var.input_public_subnet_id

  tags = {
    Name = var.input_bastion_host_name
    Username = "ubuntu"
  }

  private_dns_name_options {
    hostname_type = "resource-name"
  }

  user_data = <<-EOF
              #!/bin/bash
              HOSTNAME="${var.input_bastion_host_name}.${var.input_domain_name}"
              echo "Setting hostname to $HOSTNAME"
              hostnamectl set-hostname $HOSTNAME

              # Backup the original config file
              cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

              # Allow GatewayPorts and TCPForwarding
              echo "Allowing GatewayPorts and TCPForwarding"
              sed -i '/^#GatewayPorts no/s/^#//g' /etc/ssh/sshd_config
              sed -i 's/^GatewayPorts no.*/GatewayPorts yes/' /etc/ssh/sshd_config
              sed -i '/^#AllowTcpForwarding no/s/^#//g' /etc/ssh/sshd_config
              sed -i 's/^AllowTcpForwarding no.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config

              # Restart SSH service to apply changes
              systemctl restart sshd
              EOF
}