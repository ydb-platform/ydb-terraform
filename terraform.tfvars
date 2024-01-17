#======== Auth setup zone ===========#
key_path = "./prod.json"                       // Set the JSON SA key file
cloud_id = "b1g7gqj2vnq67gjseuva"                   // Yandex WEB GUI Cloud 
folder_id = "b1gs3jaj6lvb189376n4"                  // Yandex folder ID
zone_name = "ru-central1-a"                         // Yandex zone name

#============ General VM set up ================#
vps_platform = "standard-v1"                        // standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake.
os_image_id = "fd8clogg1kull9084s9o"                // Ubuntu 20.04 image
boot_disk_type = "network-ssd"                    // Storage type
subnet_id = "e9bnabnpm471crn43kjr"                  // Subnet ID
boot_disk_size = 80

#======= Static nodes setup zone ============#
static_node_vm_value = 3
static_node_vm_name = "ydb-static-node"             // Virtual machine name
static_node_cores = 2                               //vCPU (2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32)                        
static_node_memory = 4                              // Memory, GB (4GB, 8GB, 12GB, 16GB, 20GB, 24GB, 28GB, 32GB.)
static_node_hostname = "static-node"
static_node_start_ic_port = 19000
static_node_start_grpc_port = 2100
static_node_start_mon_port = 2300
static_node_disk_per_vm = 1
static_node_attache_disk_name = "ydb-stat-stor-disk"
static_node_storage_size = 80
static_node_attache_disk_type = "network-ssd"

#======= Dyn nodes setup zone ============#
dyn_node_vm_value = 3
dyn_node_vm_name = "ydb-dyn-node"                   // Virtual machine name
dyn_node_cores = 2                                  //vCPU (2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32)                        
dyn_node_memory = 4                                 // Memory, GB (4GB, 8GB, 12GB, 16GB, 20GB, 24GB, 28GB, 32GB.)
dyn_node_storage_size = 80                          // The min disk size (GB)
dyn_node_start_ic_port = 20000
dyn_node_hostname = "dynamic-node"
dyn_node_start_grpc_port = 2200
dyn_node_start_mon_port = 2400


#======= NET disk zone =============#
dyn_node_disk_per_vm = 1                                     // NET-disk per VM
dyn_node_attache_disk_name = "ydb-dyn-stor-disk"                      // Disk name
dyn_node_attache_disk_size = 80                              // NB size must be divisible by 93 (GB)
dyn_node_attache_disk_type = "network-ssd"                   // Type of the NET disk

#====== SSH credentials zone =======#
user = "ubuntu"                                     // Username to connect via SSH
ssh_key_pub_path = "~/yandex.pub"                   // Path to public part of SSH-key
ssh_key_private_path = "~/yandex"                   // Path to private part of SSH-key