output "map_first_ebs_name_id" {
    description = ""
    value = {for ebs in aws_ebs_volume.first_attached_disk: substr(ebs.tags["Name"], 0, length(ebs.tags["Name"]) - 2) => ebs.id}
}

output "map_sec_ebs_name_id" {
    description = ""
    value = {for ebs in aws_ebs_volume.secondary_attached_disk: substr(ebs.tags["Name"], 0, length(ebs.tags["Name"]) - 2) => ebs.id}
}