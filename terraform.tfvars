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
private_network = "enpbgnk6g4u0p79s21vu"
boot_disk_size = 80

#======= Static nodes setup zone ============#
static_node_vm_value = 10
static_node_vm_name = "ydb-static-node"             // Virtual machine name
static_node_cores = 2                               //vCPU (2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32)                        
static_node_memory = 4                              // Memory, GB (4GB, 8GB, 12GB, 16GB, 20GB, 24GB, 28GB, 32GB.)
static_node_hostname = "static-node"
static_node_start_ic_port = 19001
static_node_start_grpc_port = 2135
static_node_start_mon_port = 8765
static_node_disk_per_vm = 1
static_node_attache_disk_name = "ydb-stat-stor-disk"
static_node_storage_size = 80
static_node_attache_disk_type = "network-ssd"

#======== DNS setup zone =============#
dns_name = "ydb-cluster" 
domain = "ydb-cluster.com."

#====== SSH credentials zone =======#
user = "ubuntu"                                     // Username to connect via SSH
ssh_key_pub_path = "~/yandex.pub"                   // Path to public part of SSH-key
ssh_key_private_path = "~/yandex"                   // Path to private part of SSH-key
