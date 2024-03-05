# Creating infrastructure in Yandex Cloud for deploying a YDB cluster

To implement this Terraform scenario, you will need: an active billing account in Yandex Cloud, sufficient funds to launch 9 virtual machines, [Yandex CLI](https://cloud.yandex.ru/en/docs/cli/quickstart), [AWS CLI](https://aws.amazon.com/cli/), and prepared SSH keys.

To create infrastructure in Yandex Cloud using Terraform, you need to:
1. Prepare the cloud for work:
    * [Register](https://console.cloud.yandex.ru/) in Yandex Cloud.
    * [Connect](https://cloud.yandex.com/en/docs/billing/concepts/billing-account) a billing account.
    * [Ensure](https://console.cloud.yandex.ru/billing) there are sufficient funds for creating nine VMs.
2. Install and configure Yandex Cloud CLI:
    * [Download](https://cloud.yandex.ru/en/docs/cli/quickstart) Yandex Cloud CLI.
    * [Create](https://cloud.yandex.ru/en/docs/cli/quickstart#initialize) a profile.
3. [Create](https://cloud.yandex.com/en/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials) a service account using CLI.
4. [Generate](https://cloud.yandex.ru/en/docs/cli/operations/authentication/service-account#auth-as-sa) a SA key in JSON format to connect Terraform to the cloud using CLI: `yc iam key create --service-account-name <acc name> --output <file name> --folder-id <cloud folder id>`. A SA key will be generated, and secret information will be displayed in the terminal:
    ```
    access_key:
        id: ajenhnhaqgd3vp...
        service_account_id: aje90em65r6922...
        created_at: "2024-03-05T20:10:50.0150..."
        key_id: YCAJElaLsa0z3snzH4E...
    secret: YCPKNJDVhRZgyywl4hQwVdcSRC...
    ```
    Copy `access_key.id` and `secret`. You will need these values later when working with AWS CLI.
5. [Download](https://aws.amazon.com/cli/) AWS CLI.
6. Set up AWS CLI environment:
    * Run the command `aws configure` and sequentially enter the previously saved `access_key.id` and `secret`. Use `ru-central1` for the region value:
    ```
    aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN********
    AWS Secret Access Key [None]: wJalr********/*******/bPxRfiCYEX********
    Default region name [None]: ru-central1
    Default output format [None]:
    ```
    This will create `~/.aws/credentials` and `~/.aws/config` files.
7. Edit `~/.aws/credentials` and `~/.aws/config` as follows:
    * Add `[Ya_def_reg]` to `~/.aws/config` before `region = ru-central1-a`.
    * Add `[Yandex]` before the secret key connection information.
8. Add the following block to the `~/.terraformrc` file (if the file does not exist – create it):
    ```
    provider_installation {
        network_mirror {
            url = "https://terraform-mirror.yandexcloud.net/"
            include = ["registry.terraform.io/*/*"]
        }
        direct {
            exclude = ["registry.terraform.io/*/*"]
        }
    }
    ```
9. [Configure](https://cloud.yandex.com/en/docs/tutorials/infrastructure-management/terraform-quickstart#configure-provider) Yandex Cloud Terraform provider.
10. Download this repository with the command `git clone https://github.com/ydb-platform/ydb-terraform.git`.
11. Go to the `yandex_cloud` directory (in the downloaded repository) and make changes to the following variables in the `variables.tf` file:
    * `key_path` – the path to the generated SA key using CLI.
    * `cloud_id` – Cloud ID. You can get the list of available clouds with the command `yc resource-manager cloud list`.
    * `profile` – the name of the profile from the `~/.aws/config` file.
    * `folder_id` – Cloud folder ID. Can be obtained with the command `yc resource-manager folder list`.

Now, being in the `yandex_cloud` directory, you can execute the command `terraform init` to install the provider and initialize the modules. Then you need to execute a series of commands:
* `terraform plan` – to create a plan of the future infrastructure.
* `terraform apply` – to create resources in the cloud.

## Variable values

The project's global variables, which contain data for authentication, configuration of virtual servers, are located in `variables.tf` in the project's root directory.

| Variable Name | Description | Type | Default Value | Note |
|---------------|-------------|------|---------------|------|
| `key_path` | Path to the SA key in JSON format. | string | "./prod.json" | SA key can be created using CLI command `yc iam key create \ --service-account-id <service acc ID> \ --folder-name <folder cloud name> \ --output key.json`. |
| `cloud_id` | Cloud ID. | string | `<yandex cloud ID>` | List of available clouds can be obtained with `yc resource-manager cloud list`. |
| `profile` | Name of the security profile from the `~/.aws/credentials` file. | string | "Yandex" | If there are no security profiles in `~/.aws/credentials`, it should be created by adding `[Yandex]` before `aws_access_key_id` and `aws_secret_access_key`. |
| `folder_id` | Yandex Cloud folder ID. | string | `<yandex cloud folder ID>` | Yandex Cloud folder ID can be obtained with `yc resource-manager folder list`. |
| `vm_count` | Number of VMs to be created in the cloud. | number | 9 | The minimum number of VMs for creating a YDB cluster is 8. |
| `static_node_disk_per_vm` | Number of disks attached to each VM. | number | 1 | |
| `vps_platform` | Type of virtualization platform. | string | `standard-v3` | standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake. |
| `static_node_attached_disk_name` | Name of the disk attached to VM. | string | "ydb-data-disk" | |
| `user` | User for SSH connection. | string | "ubuntu" | |
| `ssh_key_pub_path` | Path to the SSH public key part. | string | "<path to SSH pub>" | An SSH key pair can be created using the `ssh-keygen` command. |
| `zone_name` | Availability zones of Yandex Cloud. | list | ["ru-central1-a", "ru-central1-b", "ru-central1-d"] | The list of availability zones does not include ru-central1-c zone – it is being phased out. |
| `domain` | Name of the DNS domain zone. | string | "ydb-cluster.com." | The domain name must always end with a dot. |
