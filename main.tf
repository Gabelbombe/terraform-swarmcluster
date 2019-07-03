/**
# Terraform Autoscaling Swarm example...

## Installation

Start by cloning this repository

### Dependencies

- [terraform](https://www.terraform.io/downloads.html)
- [awscli](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [jq](https://stedolan.github.io/jq/download/)

### Configuration

- Edit `terraform.tfvars` and update with your settings
- Edit `terraform.tf` if you want to use remote state

### Terraform Infrastructure

The make file included from `makefiles/terraform.mk` has some helpers for applying your Terraform infrastructure.

Plan your infrastructure first (a dry run):

```bash
$ make plan
```

When you are happy, execute the plan generated above

```bash
$ make apply
```

### Accessing a Swarm Manager

Provided you have added an SSH key, you will be able access an available Swarm Manager using the command:

```bash
$ make swarm-ssh
```

### Deploying the Example Application

An example app is included in `docker/docker-compose.yml`

The make file included from `makefiles/swarm.mk` has some helpers for applying your Terraform infrastructure.

```bash
$ make swarm-deploy
```

## Concepts

![AWS Resource Diagram](/assets/aws-resource-diagram.svg "AWS Resource Diagram")

> Note, the `make` commands shown will only work once you have created your swarm using the steps above

### EC2 Autoscaling Groups

The swarm is composed of multiple EC2 autoscaling groups performing various roles.

You can show all available instances and the groups to which they belong using:

```bash
$ make swarm-instances
```

##### Manager Group

For a functioning cluster, you must run a manager group, which by default consists of 3 Swarm Manager instances, one in each availability zone.

```bash
$ make swarm-managers
```

##### Worker Groups

You can have as many or as few worker groups as you wish, running in as many different configurations as you choose. Instances in worker groups join the cluster as Swarm Workers. By default this terraform config creates a single worker group running 1 instance.

### Docker Swarm Discovery

In order to provide automatic swarm initialization we run a one shot docker container on instance launch, which uses an S3 Bucket to find active managers and join tokens.

[See here for more information on how this works.](docker/aws-swarm-init)

### DNS Records (Route 53)

TODO: Look into https://aws.amazon.com/about-aws/whats-new/2017/12/amazon-route-53-releases-auto-naming-api-name-service-management/ to see if it can replace this requirement.

To allow external addressing of nodes in the cluster, you can configure an autoscaling group to automatically maintain a route 53 DNS record. By default only the manager group has a DNS record configured.

This record will be updated on the following autoscaling events:

 - Instance Launched
 - Instance Terminated
 - Autoscaling Group Scale Down&ast;

&ast;*NOTE:** An Autoscaling Lifecycle Hook is configured on scale down events, to delay the termination of the instance until (DNS TTL + 120) seconds has elapsed from the time of the event.

## Removing Nodes from Rotation

##### Graceful Removal and Shutdown
In the case of groups with DNS records attached or groups executing long running tasks, you probably want to decommission hosts in a more graceful fashion.

The steps to do this are:

 - Set the docker node to DRAIN state, to prevent new tasks being allocated
 - Stop all the containers on the node
 - Set the host to unhealthy in the autoscaling group&ast;

&ast;This will automatically trigger the notification to update any associated DNS records. If this is the case the instance will remain in the group until a period of (DNS TTL + 120) has expired.

```bash
$ make swarm-remove-instance ID=<instance-id>
```

##### Hard Termination
If for any reason you need to force a node out of the cluster you can simply terminate it. The autoscaling group will automatically provision a new host and the swarm will automatically rebalance the containers the node was running.

##### Removing "downed" Nodes

Once instance have been removed from the swarm, the node is show in a "down" state in the `docker node ls` output. You can remove these nodes using the make task:

```bash
$ make swarm-tidy
```

## Destroying the swarm

WARNING: this will destroy ALL infrastructure elements with no method of retrieving data or configuration.

```bash
$ make clean
```

## Documentation generation
Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ |sed '$d' >| README.md
```

## Pull Requests
Are welcome...

## License
GPL 3.0 Licensed. See [LICENSE](https://github.com/niigataken/terraform-cos/tree/master/LICENSE) for full details.

### Author
Maintained by [Jd Daniel](mailto:dodomeki@gmail.com)

## TODO

 - Send EC2 logs to CloudWatch
 - Set up CloudWatch Alarms
   - Lambda failures
   - EC2 Health
 - Docker Registry in example app
 - CI in example docker-compose
*/

provider "aws" {
  allowed_account_ids = ["${var.account_id}"]
  max_retries         = 5
  region              = "${var.region}"
}

// Use these more often then not, declare ahead...
provider "null" {}

provider "template" {}
provider "random" {}
