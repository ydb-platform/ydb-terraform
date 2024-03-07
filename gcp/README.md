# Creating infrastructure in Google Cloud Platform for deploying YDB cluster

To implement this Terraform scenario, you will need: a Google Cloud Platform (GCP) account, an active billing account, enough funds to launch 9 virtual machines, and prepared SSH keys.

1. Register in the Google Cloud console.
2. [Create](https://console.cloud.google.com/projectselector2/home) a project.
3. Activate [billing account](https://console.cloud.google.com/billing/manage) and fund it sufficiently for launching nine VMs. You can calculate the cost using the [calculator](https://cloud.google.com/products/calculator?hl=en&dl=CiQ2N2I0OThlMS04NmQ1LTRhMzUtOTI0NS04YmVmZTVkMWQ2ODUQCBokRjJGMjBFOTgtQkY0MC00QTcyLUFFNjktODYxMDU2QUIyRDBD).
4. Activate [Compute Engine API](https://console.cloud.google.com/apis/api/compute.googleapis.com/metrics) and [Cloud DNS API](https://console.cloud.google.com/apis/api/dns.googleapis.com/metrics).
5. Download and install GCP CLI following [this instruction](https://cloud.google.com/sdk/docs/install).
6. Go to the subdirectory `.../google-cloud-sdk/bin` and execute the command `./gcloud compute regions list` to get a list of available regions.
7. Execute the command `./gcloud auth application-default login` to set up the connection profile.
8. Download the repository using the command `git clone https://github.com/ydb-platform/ydb-terraform`.
9. Go to the `gcp` subdirectory (located in the downloaded repository) and in the file `variables.tf`, set the actual values for the following variables:
    * `project` – the project name that was set in the Google Cloud console.
    * `region` – the region where the infrastructure will be deployed.
    * `zones` – the list of availability zones in which the subnets and VMs will be created.

Now, being in the `gcp` subdirectory, you can execute the sequence of the following commands to install the provider, initialize modules, and create the infrastructure:
* `terraform init` – install the provider and initialize modules.
* `terraform plan` – create a plan for the future infrastructure.
* `terraform apply` – deploy resources in the cloud.

Afterwards, use the commands `terraform plan`, `terraform apply`, and `terraform destroy` (to destroy the created infrastructure).

## Variable Values

Global project variables containing authentication data, virtual server configuration, are located in the root `variables.tf`, while module-specific local variables are in `variables.tf` within each module. Variables in the root `variables.tf` file:

| Variable Name | Description | Type | Default Value | Note |
|---------------|-------------|------|---------------|------|
| `project` | The project name that was set in the Google Cloud console. | string | <project name> | |
| `region` | The region where the infrastructure will be deployed. | string | <region> | A list of regions can be obtained by the command `./gcloud compute regions list`.|
| `zones` | The list of availability zones where the subnets and VMs will be created. | list(string) | [\<zone name>, ... ] | A list of availability zones can be obtained by the command `./gcloud compute zones list \| grep <region-name>`.|
| `vpc_name` | The name of the cloud network. | string | ydb-vpc | |
| `subnet_count` | The number of subnets. | string | 3 | Networks are created in different availability zones. |
| `subnet_name` | Subnet name prefix. | string | ydb-inner | The full name of the subnet is formed from the subnet name prefix and its sequential creation number. |
| `vm_count` | The number of VMs to be created | number | 9 | The minimum number of VMs for creating a YDB cluster is 8.|
| `vm_name` | VM name. | string | ydb-node | |
| `vm_size` | The name of the VM template from which the server will be created. | string | e2-small | The template defines the number of CPU cores and the amount of RAM. A list of available templates for specific availability zones can be obtained by the command `./gcloud compute machine-types list --filter="zone:( <zone name> )"`. Use space as a separator in the list of zones. Quotes are not required in the list. |
| `bootdisk_image` | The name of the boot disk template. | string | ubuntu-minimal-2204-jammy-v20240229 | A list of available boot disk images can be obtained by the command `./gcloud compute images list --filter="family:<os name>"`. |
| `user` | The username for SSH connection. | string | ubuntu | |
| `ssh_key_pub_path` | The path to the public SSH key that will be uploaded to the server. | string | <path to SSH pub key> | An SSH key pair can be generated with the command `ssh-keygen`. |
| `domain` | The DNS domain name of the private zone. | string | ydb-cluster.com. | | 