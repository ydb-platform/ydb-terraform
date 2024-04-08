resource "aws_instance" "ydb-vm" {
  count = var.instance_count

  ami                    = var.input_instance_ami
  instance_type          = var.input_instance_type
  key_name               = var.req_key_pair
  vpc_security_group_ids = [var.input_security_group_id]
  subnet_id              = element(var.input_subnet_ids, count.index % length(var.input_subnet_ids))

  tags = {
    Name                 = format("%s-%d", "${var.input_instance_name_prefix}", "${count.index +1}")
    Username             = "ubuntu"
  }

  private_dns_name_options {
    hostname_type        = "resource-name"
  }

  root_block_device {
    volume_size = var.input_boot_disk_size
    volume_type = var.input_boot_disk_type
    
    tags = {
    Name                 = format("%s-%d-%s", "${var.input_instance_name_prefix}", "${count.index +1}", "boot")
  }

  }

  user_data = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname ${var.input_vm_prefix}${count.index + 1}.${var.input_domain_name}
    EOF

}