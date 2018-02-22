## gcloud help
NAME
    gcloud - manage Google Cloud Platform resources and developer workflow

SYNOPSIS
    gcloud GROUP | COMMAND [--account=ACCOUNT] [--configuration=CONFIGURATION]
        [--flatten=[KEY,...]] [--format=FORMAT] [--help] [--project=PROJECT_ID]
        [--quiet, -q] [--verbosity=VERBOSITY; default="warning"]
        [--version, -v] [-h] [--log-http] [--trace-token=TRACE_TOKEN]
        [--no-user-output-enabled]

DESCRIPTION
    The gcloud CLI manages authentication, local configuration, developer
    workflow, and interactions with the Google Cloud Platform APIs.
...
...

### To get authenticated

```bash
gloud init
OR
gcloud init --console-only
```

### To switch accounts

```bash
gcloud config set account 'anand.sharma@gmail.com'
gcloud container clusters get-credentials anand-cluster --zone us-east4-b --project evident-wind-163400
OR
gcloud config set account 'cisco.code.team@gmail.com'
gcloud container clusters get-credentials 'asia-south' --zone asia-south1-a --project premium-episode-193818
```

### Getting help for a sub-command (for example: Here's how you get help for "config" sub-command)

```bash
gcloud config --help
```

### Show my list of configurations

```bash
gcloud config configurations list
```

### Show my current configuration

```bash
gcloud config list
```

### Get version

```bash
gcloud --version
```

### gcloud components sub-command
(List, install, update, or remove Google SDK components)

```bash
gcloud components --help
```

### Update all your installed components

```bash
gcloud components update
```

### List all your installed components

```bash
gcloud components list
```
### Install components

```bash
gcloud components install kubectl
```

### Get Help

```bash
gcloud config --help
```

### list the current properties

```bash
gcloud config list
```

### Set Core/Project. Notice how you set config properties for Core/ configurations. You do not pass "core/" to the name

```bash
gcloud config set project evident-wind-163400
```

### Set Core/disable_usage_reporting

```bash
gcloud config set disable_usage_reporting True
```

### Set Compute/Region

```bash
gcloud config set compute/region us-east4
```

### Set Compute/Zone

```bash
gcloud config set compute/zone us-east4-a
```

### Switch between multiple projects using configurations
[Source](https://www.the-swamp.info/blog/configuring-gcloud-multiple-projects/)

### Get all projects

```bash
gcloud projects list
```

### Describe the project

```bash
gcloud projects describe <project-id>
```

### Get full list of public images with their image IDs, image families, and image projects

```bash
gcloud compute images list
```

### Create an instance using one of the public images

```bash
gcloud compute instances create anand-gcp-machine --image-family ubuntu-1604-lts --image-project ubuntu-os-cloud
```
### Get list of instances

```bash
gcloud compute instances list
```
### Obtain the existing metadata for the project

```bash
gcloud compute project-info describe
```

### List all your zones within a project

```bash
gcloud dns managed-zones list
```

### To update a zone, you must provide the zone resource name (which cannot contain .—as opposed to the DNS name, which does) and the updated information associated with the zone

```bash
gcloud beta dns managed-zones update --description="Run ezplay.io compute nodes" "sez"
```

### List Managed Zone's name servers

```bash
gcloud dns managed-zones describe sez
```

### gcloud container sub-command
(deploy and manage clusters of machines for running containers)
The gcloud container command group lets you create and manage Google Container Engine containers and clusters.

Container Engine is a cluster manager and orchestration system for running
your Docker containers. Container Engine schedules your containers into the
cluster and manages them automatically based on requirements you define,
such as CPU and memory.

### Get Help

```bash
gcloud container --help
```

### get container engine server configuration for region/zone that you have selected by default

```bash
gcloud container get-server-config
```

### Get help on deploying and tearing down Google Container Engine clusters

```bash
gcloud container clusters --help
```

### Create cluster help

```bash
gcloud container clusters create --help
```

### Create cluster with a specific version of Kubernetes

```bash
gcloud container clusters create sez-gcloud-cluster --cluster-version=1.8.2-gke.0
```
### Get a list of clusters

```bash
gcloud container clusters list
```
### Delete a cluster
gcloud container clusters delete sez-gcloud-cluster

### Interact with Virtual Private Cloud

```bash
gcloud compute networks list
gcloud compute networks create myvpc --subnet-mode custom
```

### Interact with Creating a Custom Subnet

```bash
gcloud compute networks subnets list
gcloud compute networks subnets create mysubnet --network mynetwork --range 10.240.0.0/24
```

### Interact with creating Firewall Rules

```bash
gcloud compute firewall-rules list --filter="network:mynetwork"
gcloud compute firewall-rules list --format="table(name,network,direction,priority,sourceRanges.list():label=SRC_RANGES,destinationRanges.list():label=DEST_RANGES)"
gcloud compute firewall-rules hello-world --network mynetwork --allow tcp:22,tcp:443,icmp --source-ranges 0.0.0.0/0
```

### Interact with Public External IP Addresses

```bash
gcloud compute addresses list
gcloud compute addresses create hello-world --region us-east4
```

