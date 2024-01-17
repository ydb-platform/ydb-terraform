#============ Auth vars initializing ================
variable "key_path"                  {type = string}
variable "cloud_id"                  {type = string}
variable "folder_id"                 {type = string}
variable "zone_name"                 {type = string}

#============ General VM set up ====================
variable "vps_platform"              {type = string}
variable "os_image_id"               {type = string}
variable "boot_disk_type"            {type = string} 
variable "boot_disk_size"            {type = number}
variable "subnet_id"                 {type = string}

#============= Static vars initializing ============
variable "static_node_vm_value"      {type = number}
variable "static_node_vm_name"       {type = string}
variable "static_node_cores"         {type = number}
variable "static_node_memory"        {type = number}
variable "static_node_start_ic_port" {type = number}
variable "static_node_hostname"      {type = string}
variable "static_node_start_grpc_port" {type = number}
variable "static_node_start_mon_port" {type = number}
variable "static_node_disk_per_vm"   {type = number}
variable "static_node_attache_disk_name" {type = string}
variable "static_node_storage_size"  {type = string}
variable "static_node_attache_disk_type" {type = string}

#============= Dynnodes vars initializing ==========
variable "dyn_node_vm_value"         {type = number}
variable "dyn_node_vm_name"          {type = string}
variable "dyn_node_cores"            {type = number}
variable "dyn_node_memory"           {type = number}
variable "dyn_node_storage_size"     {type = string}
variable "dyn_node_start_ic_port"    {type = number}
variable "dyn_node_hostname"         {type = string}
variable "dyn_node_start_grpc_port"  {type = number}
variable "dyn_node_start_mon_port"   {type = number}

#====== SSH conn. vars initializing ================
variable "user"                      {type = string}
variable "ssh_key_pub_path"          {type = string}
variable "ssh_key_private_path"      {type = string}

#======= NET disk vars initializing ================
variable "dyn_node_disk_per_vm"       {type = number}
variable "dyn_node_attache_disk_name" {type = string}
variable "dyn_node_attache_disk_size" {type = number}
variable "dyn_node_attache_disk_type" {type = string}