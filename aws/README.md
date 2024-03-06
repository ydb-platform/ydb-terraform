# Setting up AWS infrastructure for deploying a YDB cluster

To implement this Terraform scenario, you will need: an AWS account, AWS CLI, an active billing account, sufficient funds to launch 9 virtual machines, and prepared SSH keys.

You can create an AWS account by following this [link](https://console.aws.amazon.com). After creating an account, you need to replenish the balance with an amount sufficient for the operation of 9 VMs. You can calculate the cost of maintaining the infrastructure using this [calculator](https://calculator.aws/#/createCalculator/ec2-enhancement).

Then, you need to create a user and a connection key in AWS Cloud for working with AWS CLI:
* The user is created in the Security credentials → Access management → [Users](https://console.aws.amazon.com/iam/home#/users) → Create User section.
* On the next step, you need to assign rights to the user. Choose `AmazonEC2FullAccess`.
* After creating the user – go to it, open the `Security credentials` tab, and press the **Create access key** button in the **Access keys** section.
* From the options presented, select `Command Line Interface`.
* Next, come up with a tag for marking the key and press the **Create access key** button.
* Copy the values of the `Access key` and `Secret access key` fields.

After creating the user and access key, you can download and install [AWS CLI](https://aws.amazon.com/cli/). Next, you need to execute the `aws configure` command and enter the `Access key` and `Secret access key` values saved earlier. It remains to edit the files `~/.aws/credentials` and `~/.aws/config` as follows:
* Add `[AWS_def_reg]` in `~/.aws/config` before `region = ...`.
* Add `[AWS]` before the secret key connection information.

Now you can download the repository and set the current variable values. You can download the repository with the command `git clone https://github.com/ydb-platform/ydb-terraform.git`. Go to the `aws` directory in the downloaded repository and edit the following variables in the `variable.tf` file:
* `aws_region` – the region in which the infrastructure will be deployed.
* `aws_profile` – the name of the security profile from the `~/.aws/credentials` file.
* `availability_zones` – list of the region's availability zones. It is formed from the name of the region and a sequential letter. For example, for the `us-west-2` region, the list of availability zones will look like this: `["us-west-2a", "us-west-2b", "us-west-2c"]`.

To create the infrastructure for the first time, you need to execute a sequence of commands:
* `terraform init` – provider setup and module initialization.
* `terraform plan` – creation of the future infrastructure plan.
* `terraform apply` – to create resources in the cloud.

Subsequently, use the commands `terraform plan`, `terraform apply`, and `terraform destroy` (to destroy the created infrastructure).

## Variable values

The global variables of the project, containing data for authentication, configuration of virtual servers, are located in the root `variables.tf`, while the local variables of the modules are in `variables.tf` within each module. The variables of the root `variables.tf` file:

| Variable Name | Description | Type  | Default Value | Note |
|---------------|-------------|-------|---------------|------|
| `aws_region` | The region where the infrastructure will be deployed. | string | <region name> ||
| `aws_profile` | The name of the security profile from the `~/.aws/credentials` file. | string | AWS ||
| `vm_count` | The number of VMs being created | number| 9 | The minimum number of machines in a YDB cluster should be at least eight for redundancy type block-4-2 and nine VMs for morrow-3-dc. |
| `availability_zones` | List of the region's availability zones. | list | ["us-west-2a", "us-west-2b", "us-west-2c"] | Formed from the name of the region and a sequential letter. For example, for the `us-west-2` region, the list will look like this: `["us-west-2a", "us-west-2b", "us-west-2c"]`. |
| `subnets_count` | The number of subnets to be created in the availability zones. | number| 3 ||
| `allow_ports_list` | List of ports for which traffic will be allowed | list  | [21, 22]||
| `vm_prefix` | Prefix for VM names. | string| static-node- ||
| `domain` | The name of the domain for the private DNS zone. | string| ydb-cluster.com ||
