#============ Auth vars initializing ================
variable "key_path"                       {type = string}
variable "cloud_id"                       {type = string}
variable "folder_id"                      {type = string}
variable "zone_name"                      {type = list}
variable "profile"                        {type = string}

#============ General VM set up ====================
variable "vps_platform"                   {type = string}
variable "os_image_id"                    {type = string}
variable "boot_disk_size"                 {type = number}

#============= Static vars initializing ============
variable "static_node_vm_value"           {type = number}
variable "static_node_vm_name"            {type = string}
variable "static_node_cores"              {type = number}
variable "static_node_memory"             {type = number}
variable "static_node_hostname"           {type = string}
variable "static_node_disk_per_vm"        {type = number}
variable "static_node_attache_disk_name"  {type = string}
variable "static_node_storage_size"       {type = string}
variable "static_node_attache_disk_type"  {type = string}

#======== Installation VM setup zone ========#
variable "installation_vm_name"           {type = string}
variable "installation_vm_hostname"       {type = string}
variable "installation_vm_cores"          {type = number}
variable "installation_vm_ram"            {type = number}
variable "installation_vm_boot_disk_type" {type = string}

#============ DNS setup zone ===============#
variable "dns_name"                       {type = string}
variable "domain"                         {type = string}
variable "default_net_id"                 {type = string}

#====== SSH conn. vars initializing ================
variable "user"                           {type = string}
variable "ssh_key_pub_path"               {type = string}