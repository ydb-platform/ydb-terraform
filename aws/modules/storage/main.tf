resource "aws_ebs_volume" "ebs_attached_disk_1" {
  count             = var.instance_count
  availability_zone = element(var.input_availability_zones, count.index % length(var.input_availability_zones))
  size              = var.input_ebs_attached_disk_size
  type              = var.input_ebs_attached_disk_type

  tags = {
    Name            = format("%s-%d-%d", "${var.input_instance_name_prefix}", "${count.index +1}", 1)
  }
}

resource "aws_ebs_volume" "ebs_attached_disk_2" {
  count             = var.instance_count
  availability_zone = element(var.input_availability_zones, count.index % length(var.input_availability_zones))
  size              = var.input_ebs_attached_disk_size
  type              = var.input_ebs_attached_disk_type

  tags = {
    Name            = format("%s-%d-%d", "${var.input_instance_name_prefix}", "${count.index +1}", 2)
  }
}

resource "aws_ebs_volume" "ebs_attached_disk_3" {
  count             = var.instance_count
  availability_zone = element(var.input_availability_zones, count.index % length(var.input_availability_zones))
  size              = var.input_ebs_attached_disk_size
  type              = var.input_ebs_attached_disk_type

  tags = {
    Name            = format("%s-%d-%d", "${var.input_instance_name_prefix}", "${count.index +1}", 3)
  }
}