# aws cli command dump

### Creating a new instance

```sh
aws ec2 run-instances \
--image-id "ami-0f9c89940aa8bc39e" \
--instance-type "t2.micro" \
--key-name "anasharm-on-macbook" \
--subnet-id  "subnet-04bf7c46982dc3746" \
--security-group-ids "sg-05b865b962dcdc834" \
--associate-public-ip-address
```

### Delete an instance

```bash
aws ec2 terminate-instances --instance-id
```

### List all instances

```bash
aws ec2 describe-instances --query "Reservations[*].Instances[*].{instance_id: InstanceId, type: InstanceType, ip_address_private: PrivateIpAddress, ip_address_public: PublicIpAddress, instance_state: State.Name, vpc_id: VpcId, subnet_id: SubnetId, availability_zone: Placement.AvailabilityZone, image_id: ImageId, ebs_volume_id: BlockDeviceMappings[0].Ebs.VolumeId}" --output table
```

### List all AMIs

```sh
export AWS_DEFAULT_REGION=us-east-1

aws ec2 describe-images \
--filters "Name=name,Values=ubuntu*20.04-amd64*" \
--query "sort_by(Images, &CreationDate)[-1:].[Name, ImageId, CreationDate]"

aws ec2 describe-images \
--filters "Name=name,Values=ubuntu*20.04-arm64*" \
--query "sort_by(Images, &CreationDate)[-1:].[Name, ImageId, CreationDate]"

aws ec2 describe-images \
--image-ids ami-0f9c89940aa8bc39e
```
