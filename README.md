# Deploying infrastructure with Terraform for YDB cluster installation

Before downloading and using the ready-made scripts, ensure that you have access to the necessary amount of infrastructure resources. If you are using cloud providers, check the account balance and the cloud provider CLI configuration.

For the stable operation of the YDB cluster, nine servers are required, each of which must have the following specifications: 16 CPUs, 16 GB RAM, a dedicated disk with a capacity of no less than 200 GB. The servers must have network connectivity, and port 22 must be open for Ansible SSH access.

## Repository structure, configuration, and execution of Terraform scripts

The repository contains directories whose names correspond to the names of cloud providers (`yandex_cloud`, `azure`, `aws`). Each directory contains `readme` files in Russian and English that describe the processes of installation, configuration, and script execution. The main file is `main.tf`, located in the root directory of each scenario. It describes the cloud resources that will be created after running the `terraform init` command.

The number of resources to be created and their properties are described in the `variables.tf` file, also located in the root directory of each scenario. The file contains variables in the following format:
```
variable "<variable name>" {
  description = " ... "
  type        = <variable type (string, number, list, map)>
  default     = <default value>
}
```

Variables are organized into logical groups to make it easier to find necessary variables and change their values. The `Auth vars control zone` group contains variables for authentication with the provider's cloud, and the `VM control vars zone` group includes variables that control the settings of virtual servers. The properties of variables from all groups are described in the `readme` files of each scenario. Note that Terraform scripts are set up by default to create nine VMs. This value is fixed in the `vm_count` variable.

In addition to global variables (defining overall infrastructure settings), each module (a subdirectory with `.tf` files located in the `modules` directory) contains local variables in the `variables.tf` file. Variables with the `default` option set local values for the module, while variables without the `default` option are transport variables—they receive values from global variables.

After setting the authentication variable values and configuring (if needed) the CLI, you can execute a sequence of commands while in the root directory of the scenario:
* `terraform init` – download the Terraform provider and initialize modules.
* `terraform plan` – show the execution plan and the resources to be created.
* `terraform init` (re-applied) – create the cloud infrastructure.

Connection options to VMs are described in the `readme` files of each scenario.

## Cloud resources and their creation scheme by Terraform

Terraform scripts (in this repository) implement a unified resource creation scheme:
1. A cloud network is created in the selected region.
2. Three subnets are created in different availability zones of the region.
3. Security groups are applied to regulate traffic exchange between VMs.
4. VMs are created and connected to the subnets.
5. A DNS private zone is created.
