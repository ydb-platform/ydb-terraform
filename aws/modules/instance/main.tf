resource "aws_instance" "ydb-vm" {
  count = var.instance_count

  ami                    = var.input_instance_ami
  instance_type          = var.input_instance_type
  key_name               = var.req_key_pair
  vpc_security_group_ids = [var.input_security_group_id]
  subnet_id              = element(var.input_subnet_ids, count.index % length(var.input_subnet_ids))

  tags = {
    Name                 = "ydb-node-${count.index +1}"
    Username             = "ubuntu"
  }

  private_dns_name_options {
    hostname_type        = "resource-name"
  }

  user_data = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname ${var.input_vm_prefix}${count.index + 1}.${var.input_domain_name}
    EOF


  ebs_block_device {
    device_name          = var.input_ebs_name
    volume_type          = var.input_ebs_type
    volume_size          = var.input_ebs_size
  }

}