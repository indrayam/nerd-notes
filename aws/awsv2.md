# aws cli

AWS v2 is the new client. Download it [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux-mac.html)

```bash
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-macos.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws2 configure
```

```bash
NAME
       aws -

DESCRIPTION
       The  AWS  Command  Line  Interface is a unified tool to manage your AWS
       services.

SYNOPSIS
          aws [options] <command> <subcommand> [parameters]

       Use aws command help for information on a  specific  command.  Use  aws
       help  topics  to view a list of available help topics. The synopsis for
       each command shows its parameters and their usage. Optional  parameters
       are shown in square brackets.
...
...
```

### Getting help for a sub-command
For example: Here's how you get help for "configure" sub-command

```bash
aws configure help
```

### Setup your configuration

```bash
aws configure
```

### Show my current configuration

```bash
aws configure list
```

### Get version
```bash
aws --version
```

### To set/reset configuration
Will prompt you to set/reset the values. Hit enter to keep the default

```bash
aws configure
```

### Display the current configuration that is being used

```bash
aws configure list
```

### Aliases for .bashrc or .zshrc

```bash
alias awsls='aws ec2 describe-instances --query "Reservations[*].Instances[*].{instance_name: Tags[?Key=='Name'] | [0].Value, instance_id: InstanceId, type: InstanceType, ip_address_private: PrivateIpAddress, ip_address_public: PublicIpAddress, instance_state: State.Name, vpc_id: VpcId, subnet_id: SubnetId, availability_zone: Placement.AvailabilityZone, image_id: ImageId, ebs_volume_id: BlockDeviceMappings[0].Ebs.VolumeId}" --output table'
alias awsgw='aws ec2 describe-internet-gateways --query "InternetGateways[*].{internet_gateway_id: InternetGatewayId, vpc_id: Attachments[0].VpcId, state: Attachments[0].State}" --output table'
alias awselb='aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].{elb_name: LoadBalancerName, availability_zone: AvailabilityZones[0], subnet_id: Subnets[0], vpc_id: VPCId, instance_id: Instances[*].InstanceId}" --output table'
alias awsvpc='aws ec2 describe-vpcs --query "Vpcs[*].{vpc_id: VpcId, cidr_block: CidrBlock, state: State}" --output table'
alias awssub='aws ec2 describe-subnets --query "Subnets[*].{vpc_id: VpcId, subnet_id: SubnetId, availability_zone: AvailabilityZone, cidr_block: CidrBlock, public_network: MapPublicIpOnLaunch}" --output table'
alias awslssec='aws ec2 describe-security-groups --query "SecurityGroups[*].{vpc_id: VpcId, group_id: GroupId, group_name: GroupName, group_description: Description}" --output table'
```

### Find the latest Ubuntu AMI ID

```bash
aws ec2 describe-images --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-*-amd64*' --query 'Images[*].[ImageId,CreationDate,Description]' --output text | sort -k2 -r | head -n5
```

### Using aws profiles to connect to Cisco Cloud Storage

Edit `~/.aws/config` like this:

```bash
[default]
region = us-east-1
output = json
[profile ciscoalln]
region = us-east-1
output = json
```

Edit `~/.aws/credentials` like this:

```bash
[default]
aws_access_key_id = ...
aws_secret_access_key = ...
[ciscoalln]
aws_access_key_id = ...
aws_secret_access_key = ...
```

Interact with Cisco Cloud Storage using the following commands:

```bash
aws --profile ciscoalln --endpoint-url https://alln-cloud-storage-1.cisco.com s3 ls
aws --profile ciscoalln --endpoint-url https://alln-cloud-storage-1.cisco.com s3 mb s3://demo
aws --profile ciscoalln --endpoint-url https://alln-cloud-storage-1.cisco.com s3 ls s3://demo
aws --profile ciscoalln --endpoint-url https://alln-cloud-storage-1.cisco.com s3 cp cdcli-final.png s3://demo
```

