resource "aws_volume_attachment" "first_ebs_attached" {
  for_each = var.input_map_first_ebs_name_id
  device_name = "/dev/sdh"
  volume_id   = each.value
  instance_id = var.input_map_instance_name_id[each.key]
}

resource "aws_volume_attachment" "secondary_ebs_attached" {
  for_each = var.input_map_sec_ebs_name_id
  device_name = "/dev/sdj"
  volume_id   = each.value
  instance_id = var.input_map_instance_name_id[each.key]
}