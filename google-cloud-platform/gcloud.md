# gcloud help
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

# To get authenticated
gloud init
OR
gcloud init --console-only

## Getting help for a sub-command (for example: Here's how you get help for "config" sub-command)
gcloud config --help

## Show my current configuration
gcloud config list

## Get version
gcloud --version

# gcloud components sub-command
(List, install, update, or remove Google SDK components)
gcloud components --help

## Update all your installed components
gcloud components update

## List all your installed components
gcloud components list

## Install components
gcloud components install kubectl

# gcloud config sub-command
(View and Edit Cloud SDK properties)
## Get Help
gcloud config --help

## list the current properties
gcloud config list

## Set Core/Project. Notice how you set config properties for Core/ configurations. You do not pass "core/" to the name
 gcloud config set project evident-wind-163400

## Set Core/disable_usage_reporting
gcloud config set disable_usage_reporting True

## Set Compute/Region
gcloud config set compute/region us-east4

## Set Compute/Zone
gcloud config set compute/zone us-east4-a

# gcloud project sub-command

## Get all projects
gcloud projects list

## Describe the project
gcloud projects describe <project-id>

# gcloud compute sub-command
(gcloud compute - create and manipulate Google Compute Engine resources)

## Get full list of public images with their image IDs, image families, and image projects
gcloud compute images list

## Create an instance using one of the public images
gcloud compute instances create anand-gcp-machine --image-family ubuntu-1604-lts --image-project ubuntu-os-cloud

## Get list of instances
gcloud compute instances list

## Log into Google Compute instance
gcloud compute ssh anand@anand-gcp-machine --ssh-key-file=~/.ssh/id_rsa
Things to note:
anand here is the userid that I want gcloud to create for me on this remote VM
--ssh-key-file="filepath of id_rsa" (not the public key)

## Obtain the existing metadata for the project
gcloud compute project-info describe

# gcloud dns sub-command

## List all your zones within a project
gcloud dns managed-zones list

## To update a zone, you must provide the zone resource name (which cannot contain .—as opposed to the DNS name, which does) and the updated information associated with the zone
gcloud beta dns managed-zones update --description="Run ezplay.io compute nodes" "sez"

## List Managed Zone's name servers
gcloud dns managed-zones describe sez













# gcloud container sub-command
(deploy and manage clusters of machines for running containers)
The gcloud container command group lets you create and manage Google Container Engine containers and clusters.

Container Engine is a cluster manager and orchestration system for running
your Docker containers. Container Engine schedules your containers into the
cluster and manages them automatically based on requirements you define,
such as CPU and memory.

## Get Help
gcloud container --help

## get container engine server configuration for region/zone that you have selected by default
gcloud container get-server-config

## Get help on deploying and tearing down Google Container Engine clusters
gcloud container clusters --help

## Create cluster help
gcloud container clusters create --help

## Create cluster with a specific version of Kubernetes
gcloud container clusters create sez-gcloud-cluster --cluster-version=1.8.2-gke.0

## Get a list of clusters
gcloud container clusters list

## Delete a cluster
gcloud container clusters delete sez-gcloud-cluster
