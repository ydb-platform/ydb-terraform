resource "aws_ebs_volume" "first_attached_disk" {
  count             = var.instance_count  
  availability_zone = element(var.input_availability_zones, count.index % length(var.input_availability_zones))
  size              = var.input_first_ebs_size
  type              = var.input_first_ebs_type

  tags = {
    Name                 = format("%s-%d-%d", "${var.input_instance_name_prefix}", "${count.index +1}", 1)
  }
}

resource "aws_ebs_volume" "secondary_attached_disk" {
  for_each = var.input_sec_attached_disk ? toset([for idx in range(var.instance_count) : tostring(idx)]) : toset([])

  availability_zone = element(var.input_availability_zones, each.key % length(var.input_availability_zones))
  size              = var.input_sec_ebs_size
  type              = var.input_sec_ebs_type

  tags = {
    Name                 = format("%s-%d-%d", "${var.input_instance_name_prefix}", "${each.key +1}", 2)
  }

}
