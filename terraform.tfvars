#======== Auth setup zone ===========#
key_path = "./prod.json"                                        // Set the JSON SA key file
cloud_id = "b1g7gqj2vnq67gjseuva"                               // Yandex WEB GUI Cloud 
folder_id = "b1gs3jaj6lvb189376n4"                              // Yandex folder ID
zone_name = ["ru-central1-a", "ru-central1-b", "ru-central1-d"] // Yandex zones name
profile = "Yandex"                                              // Profile section from ``

#============ General VM set up ================#
vps_platform = "standard-v3"                                    // standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake.
os_image_id = "fd8clogg1kull9084s9o"                            // Ubuntu 22.04 LTS image. Run `yc compute image list --folder-id standard-images` to get a list of available OS images.
boot_disk_size = 40                                             // VM boot disk size

#======= Static nodes setup zone ============#
static_node_vm_value = 9                                        // Number of VMs being created
static_node_vm_name = "ydb-static-node"                         // Virtual machine name
static_node_cores = 4                                           //vCPU (2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32)                        
static_node_memory = 4                                          // Memory, GB (4GB, 8GB, 12GB, 16GB, 20GB, 24GB, 28GB, 32GB.)
static_node_hostname = "static-node"                            // Static node hostname
static_node_disk_per_vm = 1                                     // Number of disks attached to the VM
static_node_attache_disk_name = "ydb-stat-stor-disk"            // Name of the disk attached to the VM
static_node_storage_size = 200                                  // Size of the attached disk, GB (min 1 GB, max 256 TB)
static_node_attache_disk_type = "network-ssd"                   // Type of the attached disk (network-ssd, network-hdd, network-ssd-nonreplicated, network-ssd-io-m3)

#======== Installation VM setup zone ========#
installation_vm_name = "ydb-ansible-install-vm"                 // Name of the installation VM
installation_vm_hostname = "ydb-ansible-install-vm"             // Hostname of the installation VM
installation_vm_cores = 4                                       // Number of CPU cores of the installation VM
installation_vm_ram = 4                                         // Amount of RAM in the installation VM
installation_vm_boot_disk_type = "network-ssd"                  // Type of the attached disk of the installation VM
#======== DNS setup zone =============#
dns_name = "ydb-cluster"                                        // Domain zone name
domain = "ydb-cluster.com."                                     // Inner domain
default_net_id = "enpbgnk6g4u0p79s21vu"                         // Default cloud net

#====== SSH credentials zone =======#
user = "ubuntu"                                                 // Username to connect via SSH
ssh_key_pub_path = "~/yandex.pub"                               // Path to public part of SSH-key