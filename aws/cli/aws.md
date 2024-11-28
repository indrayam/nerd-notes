# aws cli

AWS v2 is the new client. Download it [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux-mac.html)

### Get version
```bash
aws --version
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
