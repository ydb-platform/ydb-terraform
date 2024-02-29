markdown
# Creating Infrastructure in Azure for YDB Cluster Deployment

To implement this Terraform scenario, you will need: an Azure account, an active payment account, sufficient funds to launch 9 virtual machines, Azure CLI for authentication in Azure, and prepared SSH keys.

You can download, install, and configure the Azure CLI by following [this](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) instruction. To authenticate in Azure using the Azure CLI, you can use the `az login` command in interactive mode, and to create a pair of SSH keys (Linux, macOS), the easiest way would be to use the `ssh-keygen` command.

After authenticating in Azure and generating SSH keys, you need to change the default value of the following variables in the root variables.tf file:
* `auth_location` – the name of the region where the infrastructure will be deployed. The list of available regions depending on the subscription can be obtained with the command `az account list-locations | grep "displayName"`.
* `ssh_key_path` – the path to the public part of the generated SSH key.

The value of other variables can be left unchanged. Being in the root directory of the Terraform scenario, execute the `terraform init` command – the Terraform provider will be installed, and modules initialized. After, execute the `terraform plan` command to create an infrastructure creation plan and then execute the `terraform apply` command to create infrastructure in the Azure cloud.

The following resources will be created:
* A resource group (`auth_resource_group_name`) in the specified region (auth_location).
* A cloud virtual network with a given name (`network_name`). The default CIDR: 10.0.0.0/16.
* Subnets (`subnets_count`) with the following IP issuance logic: "10.0.N.0/24".
* A security group allowing traffic on ports: 22, 53, 80.
* A local DNS zone with a customizable domain name (domain).
* Virtual servers with public IPs and SSH access.

You can get the list of public IP addresses of virtual machines for SSH connection with the command `az vm list-ip-addresses -g dev-rg -n dev-vm`.

## Variables Meaning

Global project variables containing authentication data, virtual server configuration, are contained in variables.tf, in the project's root directory.

| Variable Name | Description | Type | Default Value | Note |
|---------------|-------------|------|---------------|------|
| `auth_location` | The region where the infrastructure will be created  | string | East US | The list of available regions can be obtained with the command `az vm list-ip-addresses -g dev-rg -n dev-vm` |
| `auth_resource_group_name` | The name of the resource group | string | ydb-test-group | |
| `vm_name` | VM name | string | ydb-node | |
| `vm_count` | Number of VMs to be created | number | 3 | The minimum number of VMs for deploying a YDB cluster is eight VMs |
| `vm_user` | User for SSH connection to VM | string | ubuntu | |
| `vm_size` | Standard VM setup | string | East US | The list of available VM configurations can be obtained with the command `az vm list-skus --location <location name> --output table` |
| `network_name` | The name of the cloud network | string | ydb-network | |
| `subnets_count` | The number of subnets to be created in the resource group | number | 3 | |
| `domain` | The name of the DNS zone domain | string | ydb-cluster.com | |