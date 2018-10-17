# openstack 

### Login

```bash
export OS_AUTH_URL="https://cloud-rtp-1.cisco.com:5000/v3"
export OS_IDENTITY_API_VERSION=3
export OS_PROJECT_NAME="CICD-POC"
export OS_PROJECT_DOMAIN_NAME="cisco"
export OS_USERNAME="anasharm"
export OS_USER_DOMAIN_NAME="cisco"
export OS_PASSWORD='<password>' # DO NOT PUT THIS IN A FILE ;-)
```

Or

```bash
--os-auth-url <url>
--os-identity-api-version 3
--os-project-name <project-name>
--os-project-domain-name <project-domain-name>
--os-username <username>
--os-user-domain-name <user-domain-name>
[--os-password <password>]
```

### Server Create

```bash
openstack flavor list # List available flavors
openstack image list # List available images
openstack network list # List available provider networks
openstack security group list # List available security groups 
```

Use the values after running the above commands (as shown below):

```bash
openstack server create --flavor 1vCPUx2GB --image CentOS-7-Generic --nic net-id=aebcebae-06a3-4796-8713-4375b03ae0fb --security-group default --key-name "anand on macbook" k8s-control-plane

openstack server create --flavor 2vCPUx2GB --image ubuntu-16-04 --nic net-id=aebcebae-06a3-4796-8713-4375b03ae0fb --security-group default --key-name "anand on macbook" k8s-control-plane

openstack server create --flavor 2vCPUx2GB --image ubuntu-16-04 --nic net-id=aebcebae-06a3-4796-8713-4375b03ae0fb --security-group default --key-name "anand on macbook" k8s-node-1
openstack server create --flavor 2vCPUx2GB --image ubuntu-16-04 --nic net-id=aebcebae-06a3-4796-8713-4375b03ae0fb --security-group default --key-name "anand on macbook" k8s-node-2
openstack server create --flavor 2vCPUx2GB --image ubuntu-16-04 --nic net-id=aebcebae-06a3-4796-8713-4375b03ae0fb --security-group default --key-name "anand on macbook" k8s-node-3
```

### Create image using Glance

```bash
glance image-create --name "ubuntu" --file xenial-server-cloudimg-amd64-disk1.raw --progress --container-format bare --disk-format raw --visibility private
```

Or

```bash
o image create --private --file xenial-server-cloudimg-amd64-disk1.raw --disk-format raw "CoDE-xenial-server-cloudimg-amd64-disk1"
```

### Get a specific value

```bash
openstack server show -c status --format value my-instance-name
```
