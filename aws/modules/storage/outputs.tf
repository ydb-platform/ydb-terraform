output "map_first_ebs_name_id" {
    description = ""
    value = {for ebs in aws_ebs_volume.ebs_attached_disk_1: substr(ebs.tags["Name"], 0, length(ebs.tags["Name"]) - 2) => ebs.id}
}

output "map_sec_ebs_name_id" {
    description = ""
    value = {for ebs in aws_ebs_volume.ebs_attached_disk_2: substr(ebs.tags["Name"], 0, length(ebs.tags["Name"]) - 2) => ebs.id}
}

output "map_third_ebs_name_id" {
    description = ""
    value = {for ebs in aws_ebs_volume.ebs_attached_disk_3: substr(ebs.tags["Name"], 0, length(ebs.tags["Name"]) - 2) => ebs.id}
}