resource "aws_instance" "ydb-vm" {
  count = var.instance_count

  ami           = "ami-008fe2fc65df48dac"
  instance_type = "t2.micro"
  key_name      = var.req_key_pair
  vpc_security_group_ids = [var.input_security_group_id]
  subnet_id              = element(var.input_subnet_ids, count.index % length(var.input_subnet_ids))

  tags = {
    Name = "ydb-node-${count.index +1}"
    Username = "ubuntu"
  }

  private_dns_name_options {
    hostname_type = "resource-name"
  }

  user_data = <<-EOF
              #!/bin/bash
              HOSTNAME="${var.input_vm_prefix}$(( ${count.index} + 1 )).${var.input_domain_name}"
              echo "Setting hostname to $HOSTNAME"
              hostnamectl set-hostname $HOSTNAME
              EOF

  ebs_block_device {
    device_name = "/dev/sdh"
    volume_type = "gp2"
    volume_size = 40
  }

}